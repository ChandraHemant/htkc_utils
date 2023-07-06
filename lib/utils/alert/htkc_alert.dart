import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:htkc_utils/utils/alert/htkc_alert_style.dart';
import 'package:htkc_utils/utils/alert/htkc_dialog_button.dart';
import 'package:htkc_utils/utils/htkc_image_res.dart';


class HAlert {
  final BuildContext context;
  final HAlertType? type;
  final HAlertStyle style;
  final Image? image;
  final String? title;
  final String? desc;
  final Widget? content;
  final List<HDialogButton>? buttons;

  /// [context], [title] are required.
  HAlert({
    required this.context,
    this.type,
    this.style = const HAlertStyle(),
    this.image,
    this.title,
    this.desc,
    this.content,
    this.buttons,
  });

  /// Displays defined alert window
  void show() {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return _buildDialog();
      },
      barrierDismissible: style.isOverlayTapDismiss,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: style.overlayColor,
      transitionDuration: style.animationDuration,
      transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          _showAnimation(animation, secondaryAnimation, child),
    );
  }

  /// Displays defined alert window
  void previewImage() {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return _buildImagePreviewDialog();
      },
      barrierDismissible: style.isOverlayTapDismiss,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: style.overlayColor,
      transitionDuration: style.animationDuration,
      transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          _showAnimation(animation, secondaryAnimation, child),
    );
  }

  // Alert dialog content widget
  Widget _buildDialog() {
    return AlertDialog(
      shape: style.alertBorder ?? _defaultShape(),
      titlePadding: const EdgeInsets.all(0.0),
      title: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getCloseButton(),
            Padding(
              padding: EdgeInsets.fromLTRB(20, (style.isCloseButton ? 0 : 20), 20, 0),
              child: Column(
                children: <Widget>[
                  _getImage(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    title!,
                    style: style.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: desc == null ? 5 : 10,
                  ),
                  desc == null
                      ? Container()
                      : Text(
                    desc!,
                    style: style.descStyle,
                    textAlign: TextAlign.center,
                  ),
                  content == null ? Container() : content!,
                ],
              ),
            )
          ],
        ),
      ),
      contentPadding: style.buttonAreaPadding,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _getButtons(),
      ),
    );
  }

  // Alert dialog content widget
  Widget _buildImagePreviewDialog() {
    return AlertDialog(
      shape: style.alertBorder ?? _defaultShape(),
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: style.buttonAreaPadding,
      content: Container(
        child: content,
      ),
    );
  }

  // Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.blueGrey,
      ),
    );
  }

// Returns the close button on the top right
  Widget _getCloseButton() {
    return style.isCloseButton
        ? Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: Container(
        alignment: FractionalOffset.topRight,
        child: SizedBox(
          width: 20,
          height: 20,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: CachedNetworkImageProvider(
          //       ImagesRes.exit,
          //       //  package: 'flutter_alert',
          //     ),
          //   ),
          // ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(onTap: () => Navigator.of(context, rootNavigator: true).pop('dialog')
              //Navigator.pop(context),
            ),
          ),
        ),
      ),
    )
        : Container();
  }

  // Returns defined buttons. Default: Cancel Button
  List<Widget> _getButtons() {
    List<Widget> expandedButtons = [];
    if (buttons != null) {
      buttons?.forEach(
            (button) {
          var buttonWidget = Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: button,
          );
          if (button.width != null && buttons?.length == 1) {
            expandedButtons.add(buttonWidget);
          } else {
            expandedButtons.add(Expanded(
              child: buttonWidget,
            ));
          }
        },
      );
    } else {
      expandedButtons.add(
        Expanded(
          child: HDialogButton(
              child: const Text(
                "CANCEL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog')
            //  Navigator.of(context).pop()
            //Navigator.pop(context),
          ),
        ),
      );
    }

    return expandedButtons;
  }

// Returns alert image for icon
  Widget _getImage() {
    Widget response = image ?? Container();
    switch (type!) {
      case HAlertType.success:
        response = CachedNetworkImage(
          imageUrl: HImagesRes.subject,
          // package: 'rflutter_alert',
        );
        break;
      case HAlertType.error:
        response = CachedNetworkImage(
          imageUrl:  HImagesRes.subject,
          // package: 'rflutter_alert',
        );
        break;
      case HAlertType.info:
        response = CachedNetworkImage(
          imageUrl:  HImagesRes.subject,
          // package: 'flutter_alert',
        );
        break;
      case HAlertType.warning:
        response = CachedNetworkImage(
          imageUrl:  HImagesRes.subject,
          // package: 'flutter_alert',
        );
        break;
      case HAlertType.none:
        response = Container();
        break;
    }
    return response;
  }

// Shows alert with selected animation
  _showAnimation(animation, secondaryAnimation, child) {
    if (style.animationType == HAnimationType.fromRight) {
      return AnimationTransition.fromRight(animation, secondaryAnimation, child);
    } else if (style.animationType == HAnimationType.fromLeft) {
      return AnimationTransition.fromLeft(animation, secondaryAnimation, child);
    } else if (style.animationType == HAnimationType.fromBottom) {
      return AnimationTransition.fromBottom(animation, secondaryAnimation, child);
    } else if (style.animationType == HAnimationType.grow) {
      return AnimationTransition.grow(animation, secondaryAnimation, child);
    } else if (style.animationType == HAnimationType.shrink) {
      return AnimationTransition.shrink(animation, secondaryAnimation, child);
    } else {
      return AnimationTransition.fromTop(animation, secondaryAnimation, child);
    }
  }
}

class AnimationTransition {

  /// Slide animation, from right to left (SlideTransition)
  static fromRight(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from left to right (SlideTransition)
  static fromLeft(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromTop(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromBottom(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Scale animation, from in to out (ScaleTransition)
  static grow(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.00,
            0.50,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  }

  /// Scale animation, from out to in (ScaleTransition)
  static shrink(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.2,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.50,
            1.00,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  }
}
