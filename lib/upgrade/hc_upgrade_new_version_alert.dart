import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:htkc_utils/upgrade/hc_upgrade_new_version.dart';
import 'package:htkc_utils/upgrade/hc_upgrade_new_version_messages.dart';

/// There are two different dialog styles: Cupertino and Material
enum HcUpgradeDialogStyle { cupertino, material }

/// A widget to display the upgrade dialog.
/// Override the [createState] method to provide a custom class
/// with overridden methods.
class HcUpgradeAlert extends StatefulWidget {
  /// Creates a new [HcUpgradeAlert].
  HcUpgradeAlert({
    super.key,
    HcUpgradeNewVersion? hcUpgrade,
    this.canDismissDialog = false,
    this.dialogStyle = HcUpgradeDialogStyle.material,
    this.onIgnore,
    this.onLater,
    this.onUpdate,
    this.shouldPopScope,
    this.showIgnore = true,
    this.showLater = true,
    this.showReleaseNotes = true,
    this.cupertinoButtonTextStyle,
    this.dialogKey,
    this.navigatorKey,
    this.child,
  }) : upgrader = hcUpgrade ?? HcUpgradeNewVersion.sharedInstance;

  /// The upgraders used to configure the upgrade dialog.
  final HcUpgradeNewVersion upgrader;

  /// Can alert dialog be dismissed on tap outside of the alert dialog. Not used by [UpgradeCard]. (default: false)
  final bool canDismissDialog;

  /// The upgrade dialog style. Used only on UpgradeAlert. (default: material)
  final HcUpgradeDialogStyle dialogStyle;

  /// Called when the ignore button is tapped or otherwise activated.
  /// Return false when the default behavior should not execute.
  final BoolCallback? onIgnore;

  /// Called when the later button is tapped or otherwise activated.
  final BoolCallback? onLater;

  /// Called when the update button is tapped or otherwise activated.
  /// Return false when the default behavior should not execute.
  final BoolCallback? onUpdate;

  /// Called when the user taps outside of the dialog and [canDismissDialog]
  /// is false. Also called when the back button is pressed. Return true for
  /// the screen to be popped.
  final BoolCallback? shouldPopScope;

  /// Hide or show Ignore button on dialog (default: true)
  final bool showIgnore;

  /// Hide or show Later button on dialog (default: true)
  final bool showLater;

  /// Hide or show release notes (default: true)
  final bool showReleaseNotes;

  /// The text style for the cupertino dialog buttons. Used only for
  /// [HcUpgradeDialogStyle.cupertino]. Optional.
  final TextStyle? cupertinoButtonTextStyle;

  /// The [Key] assigned to the dialog when it is shown.
  final GlobalKey? dialogKey;

  /// For use by the Router architecture as part of the RouterDelegate.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// The [child] contained by the widget.
  final Widget? child;

  @override
  HcUpgradeAlertState createState() => HcUpgradeAlertState();
}

/// The [HcUpgradeAlert] widget state.
class HcUpgradeAlertState extends State<HcUpgradeAlert> {
  /// Is the alert dialog being displayed right now?
  bool displayed = false;

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
        print('hcUpgrade: build UpgradeAlert');
      }
    }

    return StreamBuilder(
      initialData: widget.upgrader.evaluationReady,
      stream: widget.upgrader.evaluationStream,
      builder:
          (BuildContext context, AsyncSnapshot<HcUpgradeEvaluateNeed> snapshot) {
        if ((snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active) &&
            snapshot.data != null &&
            snapshot.data!) {
          if (widget.upgrader.debugLogging) {
            if (kDebugMode) {
              print("hcUpgrade: need to evaluate version");
            }
          }

          if (!displayed) {
            final checkContext = widget.navigatorKey != null &&
                    widget.navigatorKey!.currentContext != null
                ? widget.navigatorKey!.currentContext!
                : context;
            checkVersion(context: checkContext);
          }
        }
        return widget.child ?? const SizedBox.shrink();
      },
    );
  }

  /// Will show the alert dialog when it should be dispalyed.
  /// Only called by [HcUpgradeAlert] and not used by [UpgradeCard].
  void checkVersion({required BuildContext context}) {
    final shouldDisplay = widget.upgrader.shouldDisplayUpgrade();
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: shouldDisplayReleaseNotes: shouldDisplayReleaseNotes');
      }
    }
    if (shouldDisplay) {
      displayed = true;
      final appMessages = widget.upgrader.determineMessages(context);

      Future.delayed(const Duration(milliseconds: 0), () {
        showTheDialog(
          key: widget.dialogKey ?? const Key('upgrader_alert_dialog'),
          context: context,
          title: appMessages.message(HcUpgradeMessage.title),
          message: widget.upgrader.body(appMessages),
          releaseNotes:
              shouldDisplayReleaseNotes ? widget.upgrader.releaseNotes : null,
          canDismissDialog: widget.canDismissDialog,
          messages: appMessages,
        );
      });
    }
  }

  void onUserIgnored(BuildContext context, bool shouldPop) {
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

    if (shouldPop) {
      popNavigator(context);
    }
  }

  void onUserLater(BuildContext context, bool shouldPop) {
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: button tapped: later');
      }
    }

    // If this callback has been provided, call it.
    widget.onLater?.call();

    if (shouldPop) {
      popNavigator(context);
    }
  }

  void onUserUpdated(BuildContext context, bool shouldPop) {
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

    if (shouldPop) {
      popNavigator(context);
    }
  }

  void popNavigator(BuildContext context) {
    Navigator.of(context).pop();
    displayed = false;
  }

  bool get shouldDisplayReleaseNotes =>
      widget.showReleaseNotes &&
      (widget.upgrader.releaseNotes?.isNotEmpty ?? false);

  /// Show the alert dialog.
  void showTheDialog({
    Key? key,
    required BuildContext context,
    required String? title,
    required String message,
    required String? releaseNotes,
    required bool canDismissDialog,
    required HcUpgradeMessages messages,
  }) {
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: showTheDialog title: $title');
        print('hcUpgrade: showTheDialog message: $message');
        print('hcUpgrade: showTheDialog releaseNotes: $releaseNotes');
      }
    }

    // Save the date/time as the last time alerted.
    widget.upgrader.saveLastAlerted();

    showDialog(
      barrierDismissible: canDismissDialog,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => onWillPop(),
            child: alertDialog(
              key,
              title ?? '',
              message,
              releaseNotes,
              context,
              widget.dialogStyle == HcUpgradeDialogStyle.cupertino,
              messages,
            ));
      },
    );
  }

  /// Called when the user taps outside of the dialog and [canDismissDialog]
  /// is false. Also called when the back button is pressed. Return true for
  /// the screen to be popped. Defaults to false.
  bool onWillPop() {
    if (widget.upgrader.debugLogging) {
      if (kDebugMode) {
        print('hcUpgrade: onWillPop called');
      }
    }
    if (widget.shouldPopScope != null) {
      final should = widget.shouldPopScope!();
      if (widget.upgrader.debugLogging) {
        if (kDebugMode) {
          print('hcUpgrade: shouldPopScope=$should');
        }
      }
      return should;
    }

    return false;
  }

  Widget alertDialog(
      Key? key,
      String title,
      String message,
      String? releaseNotes,
      BuildContext context,
      bool cupertino,
      HcUpgradeMessages messages) {
    // If installed version is below minimum app version, or is a critical update,
    // disable ignore and later buttons.
    final isBlocked = widget.upgrader.blocked();
    final showIgnore = isBlocked ? false : widget.showIgnore;
    final showLater = isBlocked ? false : widget.showLater;

    Widget? notes;
    if (releaseNotes != null) {
      notes = Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: cupertino
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: <Widget>[
              Text(messages.message(HcUpgradeMessage.releaseNotes) ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(releaseNotes),
            ],
          ));
    }
    final textTitle = Text(title, key: const Key('upgrader.dialog.title'));
    final content = Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment:
              cupertino ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message),
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(messages.message(HcUpgradeMessage.prompt) ?? '')),
            if (notes != null) notes,
          ],
        )));
    final actions = <Widget>[
      if (showIgnore)
        button(cupertino, messages.message(HcUpgradeMessage.buttonTitleIgnore),
            context, () => onUserIgnored(context, true)),
      if (showLater)
        button(cupertino, messages.message(HcUpgradeMessage.buttonTitleLater),
            context, () => onUserLater(context, true)),
      button(cupertino, messages.message(HcUpgradeMessage.buttonTitleUpdate),
          context, () => onUserUpdated(context, !widget.upgrader.blocked())),
    ];

    return cupertino
        ? CupertinoAlertDialog(
            key: key, title: textTitle, content: content, actions: actions)
        : AlertDialog(
            key: key, title: textTitle, content: content, actions: actions);
  }

  Widget button(bool cupertino, String? text, BuildContext context,
      VoidCallback? onPressed) {
    return cupertino
        ? CupertinoDialogAction(
            textStyle: widget.cupertinoButtonTextStyle,
            onPressed: onPressed,
            child: Text(text ?? ''))
        : TextButton(onPressed: onPressed, child: Text(text ?? ''));
  }
}
