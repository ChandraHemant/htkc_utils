library htkc_utils;

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:htkc_utils/htkc_text_style.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

String dirPath = "/storage/emulated/0/Documents";
String backBtn = "assets/icons/back_button.png";
double defaultRadius = 8.0;

const Color homeBgColor = Color(0xFFf1f1f1);
const Color primaryColor = Color(0xFF29abe2);
const Color secondColor = Color(0xFF2697FF);


// String Extensions
extension StringCasingExtension on String {
  /// Word Capitalized
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';

  /// Title Capitalized
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

  /// Convert Time Format
  String formatTime(int timeNum) => timeNum < 10 ? "0$timeNum" : timeNum.toString();

  /// Time Difference
  String timeDifference(String startTime, String endTime) {
    var format = DateFormat("HH:mm");
    DateTime now = DateTime.now();
    var sTime = format.parse(startTime);
    var eTime = format.parse(endTime);
    sTime = DateTime(now.year, now.month, now.day, sTime.hour, sTime.minute);
    eTime = DateTime(now.year, now.month, now.day, eTime.hour, eTime.minute);
    if (sTime.isAfter(eTime)) {
      return "${sTime.difference(eTime).inMinutes}";
    } else {
      return "${eTime.difference(sTime).inMinutes}";
    }
  }

  /// Calculate Age
  String calculateAge(String birthDateString) {
    String datePattern = "dd-MM-yyyy";
    DateTime today = DateFormat(datePattern).parse(DateTime.now().toString());
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    String year = (today.year - birthDate.year).toString();
    String month = (today.month - birthDate.month).abs().toString();
    return '$year year, $month months';
  }
}

// Boolean Extensions
extension BoolCasingExtension on bool {

  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this;

  /// Validate Text Input Field
  bool validateTextInputField(BuildContext context, TextEditingController controller, String fieldName, {FocusNode? focusNode}) {
    if (controller.text.isEmpty) {
      if (focusNode != null) {
        focusNode.requestFocus();
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$fieldName can\'t be empty'),
          )
      );
      return false;
    }
    return true;
  }

  /// Validate Text Field or Dropdown Value
  bool validateTextField(BuildContext context, var controller, String fieldName, {FocusNode? focusNode}) {
    if (controller.isEmpty) {
      if (focusNode != null) {
        focusNode.requestFocus();
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$fieldName can\'t be empty'),
          )
      );
      return false;
    }
    return true;
  }

  /// Lies Between Times
  bool liesBetweenTimes(String sTime, String eTime) {
    DateTime now = DateTime.now();
    var format = DateFormat("HH:mm");
    var startTime = format.parse(sTime);
    var endTime = format.parse(eTime);
    startTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
    endTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return true;
    }
    return false;
  }

  /// Check Age if age is greater than 18 year or not
  bool isAdult(String birthDateString) {
    String datePattern = "dd-MM-yyyy";
    DateTime today = DateTime.now();
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );
    return adultDate.isBefore(today);
  }
}

// Indexed Map Extensions
extension IndexedIterable<E> on Iterable<E> {
  /// Indexed Map
  Iterable<T> indexedMap<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }
}

// Int Extensions
extension IntExtension on int {

  /// Validate given int is not null and returns given value if null.
  int validate({int value = 0}) {
    return this;
  }

  /// return millisecond
  Duration get milliseconds => Duration(milliseconds: validate());
}

// File Extensions
extension FileSaveUtils on void {

  /// Save PDF Documents
  savePdfDocuments(
    {
      required String name,
      required Uint8List fileBytes,
      String customDirectoryName = "Documents",
      BuildContext? context
    }
  ) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String path = Platform.isAndroid?dirPath:"${appDocDirectory.path}/$customDirectoryName";
    try {
      bool checkPermission = await Permission.accessMediaLocation.isGranted;
      if (checkPermission) {
        File pdfDoc = File("$path/${DateFormat('yy-HH-mm-ss').format(DateTime.now())}-$name");
        await pdfDoc.writeAsBytes(fileBytes);
        ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text("File saved successfully to $path/${DateFormat('yy-HH-mm-ss').format(DateTime.now())}-$name""File saved successfully to $path/${DateFormat('yy-HH-mm-ss').format(DateTime.now())}-$name"),
            )
        );
      } else {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              content: Text("Storage permission denied !, please try again!"),
            )
        );
        var status = await Permission.accessMediaLocation.status;
        if(!status.isGranted){
          await Permission.accessMediaLocation.request();
        }
      }
    } on FileSystemException catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text("ERROR: ${e.message} $path/$name"),
          )
      );
    } catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text("ERROR: $e"),
          )
      );
    }
  }

  /// Save Network Image
  saveNetworkImage(
    {
      required String name,
      required String url,
      String customDirectoryName = "Documents",
      BuildContext? context
    }
  ) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String path = Platform.isAndroid?dirPath:"${appDocDirectory.path}/$customDirectoryName";

    try {
      var response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      bool checkPermission = await Permission.mediaLibrary.isGranted;
      if (checkPermission) {
        File file = File("$path/${DateFormat('yy-HH-mm-ss').format(DateTime.now())}-$name");
        await file.writeAsBytes(bytes);
        ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text("File saved successfully to $path/${DateFormat('yy-HH-mm-ss').format(DateTime.now())}-$name"),
            )
        );
      } else {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              content: Text("Storage permission denied !, please try again!"),
            )
        );
        var status = await Permission.mediaLibrary.status;
        if(!status.isGranted){
          await Permission.mediaLibrary.request();
        }
      }
    } on FileSystemException catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text("ERROR: ${e.message} $path/$name"),
          )
      );
    } catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text("ERROR: $e"),
          )
      );
    }
  }
}

/// returns Radius
Radius radiusCircular([double? radius]) {
  return Radius.circular(radius ?? defaultRadius);
}

/// returns Radius
BorderRadius radius([double? radius]) {
  return BorderRadius.all(radiusCircular(radius ?? defaultRadius));
}

/// returns gradient
Gradient gradient([Color secondGradientColor = secondColor, Color firstGradientColor = primaryColor, AlignmentGeometry begin = Alignment.topCenter, AlignmentGeometry end = Alignment.bottomCenter]) {
  return LinearGradient(
    colors: [
      secondGradientColor,
      firstGradientColor,
    ],
    //stops: [0, 1],
    begin: begin,
    end: end,
  );
}

// Widget Extensions
extension WidgetExtension on Widget? {

  /// set parent widget in center
  Widget center({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }

  /// set visibility
  Widget visible(bool visible, {Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? const SizedBox());
  }

  /// Circular Progressbar
  Widget mProgress({Color color = Colors.blue, }) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        margin: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: radius(50)),
        child: Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(8.0),
          child: Theme(
            data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: color)),
            child: const CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    );
  }

  /// Launch a new screen
  Future<T?> launch<T>(BuildContext context,
      {bool isNewTask = false,
        PageRouteAnimation? pageRouteAnimation,
        Duration? duration}) async {
    if (isNewTask) {
      return await Navigator.of(context).pushAndRemoveUntil(
        buildPageRoute(
            this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
            (route) => false,
      );
    } else {
      return await Navigator.of(context).push(
        buildPageRoute(
            this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
      );
    }
  }
}

class AppStackLoader extends StatelessWidget {
  final bool visible;
  final Widget child;

  const AppStackLoader({super.key, required this.visible, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        mProgress().center().visible(visible.validate()),
      ],
    );
  }
}

onBackPress(BuildContext context) {

  /// Cancel Button
  Widget cancelButton(BuildContext context, {Color color = primaryColor}) => TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Cancel', style: boldTextStyle()));

  /// Continue Button
  Widget continueButton(BuildContext context, {Color color = primaryColor}) => TextButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Text('Ok', style: boldTextStyle(color: color)));

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          'Warning!!!',
          style: boldTextStyle(size: 18),
        ),
        content: Text('Are you sure! you want to close this?',
            style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.7))),
        actions: [
          cancelButton(context),
          continueButton(context),
        ],
      );
    },
  );
}

/// Enum for page route
enum PageRouteAnimation { fade, scale, rotate, slide, slideBottomTop }


PageRouteAnimation? pageRouteAnimationGlobal;
Duration pageRouteTransitionDurationGlobal = 400.milliseconds;

Route<T> buildPageRoute<T>(
    Widget child,
    PageRouteAnimation? pageRouteAnimation,
    Duration? duration,
    ) {
  if (pageRouteAnimation != null) {
    if (pageRouteAnimation == PageRouteAnimation.fade) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return FadeTransition(opacity: anim, child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.rotate) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return RotationTransition(
              turns: ReverseAnimation(anim),
              child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.scale) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return ScaleTransition(scale: anim, child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.slide) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(anim),
            child: child,
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.slideBottomTop) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(anim),
            child: child,
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    }
  }
  return MaterialPageRoute<T>(builder: (_) => child);
}


Stack customAppBar(
    BuildContext context, {
      double topPadding = kToolbarHeight,
      required Widget child,
      String? title,
      Color bgColor = homeBgColor,
      Color color = Colors.white,
      Color sColor = secondColor,
      FontWeight titleFontWeight = FontWeight.normal,
      bool action = false,
      bool isDialog = false,
      bool isBack = true,
      bool isBackFunction = false,
      bool isCenter = false,
      bool isTitleSuffix = false,
      String? actionTitle,
      Widget? actionWidget,
      IconData? titleSuffix,
      GestureTapCallback? onTap,
    }) {
  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: gradient(),
        ),
        padding: EdgeInsets.only(top: Platform.isAndroid ? topPadding + 40: topPadding + size.height*0.06),
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18)),
          ),
          child: child,
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: IntrinsicHeight(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: isTitleSuffix
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isCenter ? SizedBox(width: 35.toDouble()) : SizedBox(width: 0.toDouble()),
                Text(title ?? '',
                    style: TextStyle(
                        color: color, fontWeight: titleFontWeight)),
                GestureDetector(
                    onTap: onTap,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
                            depth: 3,
                            lightSource: LightSource.topLeft,
                            color: sColor
                        ),child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(titleSuffix, size: 30,),
                    ))
                ),
              ],
            )
            : Text(title ?? '', style: TextStyle(color: color, fontWeight: titleFontWeight)),
            leading: isBack ? GestureDetector(
                onTap: () {
                  if(isBackFunction){
                    onBackPress(context);
                  }else {
                    Navigator.of(context).pop();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    backBtn,
                    color: color,
                  ),
                ))
            : Container(),
            centerTitle: !isBack,
            actions: [
              action
                  ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                      depth: -5, color: sColor),
                  child: TextButton(
                    onPressed: () {
                      isDialog ? showDialog(
                        context: context,
                        builder: (_) => actionWidget!,
                      ) : actionWidget?.launch(context);
                    },
                    child: Text(
                      actionTitle!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ) : Container(),
            ],
          ),
        ),
      )
    ],
  );
}

RoundedRectangleBorder roundedRectangleShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8),
);

//ignore: must_be_immutable
class CustomAlertDialog extends StatefulWidget {
  Widget child;
  Function? function;
  CustomAlertDialog({super.key, required this.child, this.function});
  @override
  CustomAlertDialogState createState() => CustomAlertDialogState();
}

class CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  void initState() {
    widget.function;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return openAlertDialog();
  }

  openAlertDialog() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: roundedRectangleShape,
        content: SingleChildScrollView(
          child: widget.child,
        ),
      );
    });
  }
}
