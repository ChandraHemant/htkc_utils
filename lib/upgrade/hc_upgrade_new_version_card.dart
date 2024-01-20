import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:htkc_utils/upgrade/hc_alert_style_widget.dart';
import 'package:htkc_utils/upgrade/hc_upgrade_new_version.dart';
import 'package:htkc_utils/upgrade/hc_upgrade_new_version_messages.dart';

/// A widget to display the upgrade card.
/// The only reason this is a [StatefulWidget] and not a [StatelessWidget] is that
/// the widget needs to rebulid after one of the buttons have been tapped.
/// Override the [createState] method to provide a custom class
/// with overridden methods.
class HcUpgradeNewVersionCard extends StatefulWidget {
  /// Creates a new [HcUpgradeNewVersionCard].
  HcUpgradeNewVersionCard({
    super.key,
    HcUpgradeNewVersion? hcUpgrade,
    this.margin,
    this.maxLines = 15,
    this.onIgnore,
    this.onLater,
    this.onUpdate,
    this.overflow = TextOverflow.ellipsis,
    this.showIgnore = true,
    this.showLater = true,
    this.showReleaseNotes = true,
  }) : upgrader = hcUpgrade ?? HcUpgradeNewVersion.sharedInstance;

  /// The upgraders used to configure the upgrade dialog.
  final HcUpgradeNewVersion upgrader;

  /// The empty space that surrounds the card.
  ///
  /// The default margin is [Card.margin].
  final EdgeInsetsGeometry? margin;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  final int? maxLines;

  /// Called when the ignore button is tapped or otherwise activated.
  /// Return false when the default behavior should not execute.
  final BoolCallback? onIgnore;

  /// Called when the later button is tapped or otherwise activated.
  final VoidCallback? onLater;

  /// Called when the update button is tapped or otherwise activated.
  /// Return false when the default behavior should not execute.
  final BoolCallback? onUpdate;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Hide or show Ignore button on dialog (default: true)
  final bool showIgnore;

  /// Hide or show Later button on dialog (default: true)
  final bool showLater;

  /// Hide or show release notes (default: true)
  final bool showReleaseNotes;

  @override
  HcUpgradeNewVersionCardState createState() => HcUpgradeNewVersionCardState();
}

/// The [HcUpgradeNewVersionCard] widget state.
class HcUpgradeNewVersionCardState extends State<HcUpgradeNewVersionCard> {
  @override
  void initState() {
    super.initState();
    widget.upgrader.initialize();
  }

  /// Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context) {
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: build UpgradeCard');
      }
    }

    return StreamBuilder(
        initialData: widget.upgrader.evaluationReady,
        stream: widget.upgrader.evaluationStream,
        builder: (BuildContext context,
            AsyncSnapshot<HcUpgradeEvaluateNeed> snapshot) {
          if ((snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) &&
              snapshot.data != null &&
              snapshot.data!) {
            if (widget.upgrader.shouldDisplayUpgrade()) {
              return buildUpgradeCard(
                  context, const Key('upgrader_alert_card'));
            } else {
              if (widget.upgrader.debugLogging) {
                if (kDebugMode) {
                  print('hcUpgrade: UpgradeCard will not display');
                }
              }
            }
          }
          return const SizedBox.shrink();
        });
  }

  /// Build the UpgradeCard widget.
  Widget buildUpgradeCard(BuildContext context, Key? key) {
    final appMessages = widget.upgrader.determineMessages(context);
    final title = appMessages.message(HcUpgradeMessage.title);
    final message = widget.upgrader.body(appMessages);
    final releaseNotes = widget.upgrader.releaseNotes;

    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: UpgradeCard: will display');
        print('hcUpgrade: UpgradeCard: showDialog title: $title');
        print('hcUpgrade: UpgradeCard: showDialog message: $message');
        print(
            'hcUpgrade: UpgradeCard: shouldDisplayReleaseNotes: $shouldDisplayReleaseNotes');

        print('hcUpgrade: UpgradeCard: showDialog releaseNotes: $releaseNotes');
      }
    }

    Widget? notes;
    if (shouldDisplayReleaseNotes && releaseNotes != null) {
      notes = Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(appMessages.message(HcUpgradeMessage.releaseNotes) ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                releaseNotes,
                maxLines: widget.maxLines,
                overflow: widget.overflow,
              ),
            ],
          ));
    }

    return Card(
      key: key,
      margin: widget.margin,
      child: HcAlertStyleWidget(
        title: Text(title ?? ''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(message),
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(appMessages.message(HcUpgradeMessage.prompt) ?? '')),
            if (notes != null) notes,
          ],
        ),
        actions: actions(appMessages),
      ),
    );
  }

  void forceRebuild() => setState(() {});

  List<Widget> actions(HcUpgradeMessages appMessages) {
    final isBlocked = widget.upgrader.blocked();
    final showIgnore = isBlocked ? false : widget.showIgnore;
    final showLater = isBlocked ? false : widget.showLater;
    return <Widget>[
      if (showIgnore)
        TextButton(
            child: Text(
                appMessages.message(HcUpgradeMessage.buttonTitleIgnore) ?? ''),
            onPressed: () {
              // Save the date/time as the last time alerted.
              widget.upgrader.saveLastAlerted();

              onUserIgnored();
              forceRebuild();
            }),
      if (showLater)
        TextButton(
            child: Text(
                appMessages.message(HcUpgradeMessage.buttonTitleLater) ?? ''),
            onPressed: () {
              // Save the date/time as the last time alerted.
              widget.upgrader.saveLastAlerted();

              onUserLater();
              forceRebuild();
            }),
      TextButton(
          child: Text(
              appMessages.message(HcUpgradeMessage.buttonTitleUpdate) ?? ''),
          onPressed: () {
            // Save the date/time as the last time alerted.
            widget.upgrader.saveLastAlerted();

            onUserUpdated();
          }),
    ];
  }

  bool get shouldDisplayReleaseNotes =>
      widget.showReleaseNotes &&
      (widget.upgrader.releaseNotes?.isNotEmpty ?? false);

  void onUserIgnored() {
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: button tapped: ignore');
      }
    }

    // If this callback has been provided, call it.
    final doProcess = widget.onIgnore?.call() ?? true;

    if (doProcess) {
      widget.upgrader.saveIgnored();
    }

    forceRebuild();
  }

  void onUserLater() {
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: button tapped: later');
      }
    }

    // If this callback has been provided, call it.
    widget.onLater?.call();

    forceRebuild();
  }

  void onUserUpdated() {
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: button tapped: update now');
      }
    }

    // If this callback has been provided, call it.
    final doProcess = widget.onUpdate?.call() ?? true;

    if (doProcess) {
      widget.upgrader.sendUserToAppStore();
    }

    forceRebuild();
  }
}
