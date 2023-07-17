import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:htkc_utils/htkc_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

String hcDirPath = "/storage/emulated/0/Documents";
double hcDefaultRadius = 8.0;
//region Global variables - This variables can be changed.
Color textPrimaryColorGlobal = textPrimaryColor;
Color textSecondaryColorGlobal = textSecondaryColor;
double textBoldSizeGlobal = 16;
double textPrimarySizeGlobal = 16;
double textSecondarySizeGlobal = 14;
String? fontFamilyBoldGlobal;
String? fontFamilyPrimaryGlobal;
String? fontFamilySecondaryGlobal;
FontWeight fontWeightBoldGlobal = FontWeight.bold;
FontWeight fontWeightPrimaryGlobal = FontWeight.normal;
FontWeight fontWeightSecondaryGlobal = FontWeight.normal;

const textPrimaryColor = Color(0xFF2E3033);
const textSecondaryColor = Color(0xFF757575);
const Color hcHomeBgColor = Color(0xFFf1f1f1);
const Color hcPrimaryColor = Color(0xFF29abe2);
const Color hcSecondColor = Color(0xFF2697FF);

double hcTabletBreakpointGlobal = 600.0;
double hcDesktopBreakpointGlobal = 720.0;

/// Enum for page route
enum PageRouteAnimation { fade, scale, rotate, slide, slideBottomTop }

PageRouteAnimation? pageRouteAnimationGlobal;
Duration pageRouteTransitionDurationGlobal = 400.milliseconds;

// String Extensions
extension HcStringCasingExtension on String {
  /// Word Capitalized
  String hcToCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';

  /// Title Capitalized
  String hcToTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.hcToCapitalized()).join(' ');

}

// Indexed Map Extensions
extension HcIndexedIterable<E> on Iterable<E> {
  /// Indexed Map
  Iterable<T> hcIndexedMap<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }
}

// File Extensions
extension HcFileSaveUtils on void {

  /// Save PDF Documents
  hcSavePdfDocuments(
      {
        required String name,
        required Uint8List fileBytes,
        String customDirectoryName = "Documents",
        BuildContext? context
      }
      ) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String path = Platform.isAndroid?hcDirPath:"${appDocDirectory.path}/$customDirectoryName";
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
  hcSaveNetworkImage(
      {
        required String name,
        required String url,
        String customDirectoryName = "Documents",
        BuildContext? context
      }
      ) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String path = Platform.isAndroid?hcDirPath:"${appDocDirectory.path}/$customDirectoryName";

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

// Widget Extensions
extension HcWidgetExtension on Widget? {

  /// Launch a new screen
  Future<T?> hcLaunch<T>(BuildContext context,
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

  /// Circular Progressbar
  Widget hcProgress({Color color = Colors.blue, }) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        margin: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: hcRadius(50)),
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


  /// set parent widget in center
  Widget hcCenter({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }

  /// set visibility
  Widget hcVisible(bool visible, {Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? const SizedBox());
  }

}

// Boolean Extensions
extension HcBooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool hcValidate({bool value = false}) => this ?? value;
}


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

/// Convert Time Format
String hcFormatTime(int timeNum) => timeNum < 10 ? "0$timeNum" : timeNum.toString();

/// Calculate Age
String hcCalculateAge(String birthDateString) {
  String datePattern = "dd-MM-yyyy";
  DateTime today = DateFormat(datePattern).parse(DateTime.now().toString());
  DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
  String year = (today.year - birthDate.year).toString();
  String month = (today.month - birthDate.month).abs().toString();
  return '$year year, $month months';
}

/// Validate Text Input Field
bool hcValidateTextInputField(BuildContext context, TextEditingController controller, String fieldName, {FocusNode? focusNode}) {
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
bool hcValidateTextField(BuildContext context, var controller, String fieldName, {FocusNode? focusNode}) {
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
bool hcLiesBetweenTimes(String sTime, String eTime) {
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
bool hcCheckMature(String birthDateString) {
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

/// Time Difference
String hcTimeDifference(String startTime, String endTime) {
  var format = DateFormat("HH:mm");
  DateTime now = DateTime.now();
  var sTime = format.parse(startTime);
  var eTime = format.parse(endTime);
  sTime = DateTime(now.year, now.month, now.day, sTime.hour, sTime.minute);
  eTime = DateTime(now.year, now.month, now.day, eTime.hour, eTime.minute);
  if (sTime.isAfter(eTime)) {
    return "${sTime
        .difference(eTime)
        .inMinutes}";
  } else {
    return "${eTime
        .difference(sTime)
        .inMinutes}";
  }
}
/// returns gradient
Gradient hcGradient([Color secondGradientColor = hcSecondColor, Color firstGradientColor = hcPrimaryColor, AlignmentGeometry begin = Alignment.topCenter, AlignmentGeometry end = Alignment.bottomCenter]) {
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


hcOnBackPressed(BuildContext context) {
  /// Cancel Button
  Widget cancelButton(BuildContext context, {Color color = hcPrimaryColor}) => TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Cancel', style: HcAppTextStyle.boldTextStyle()));

  /// Continue Button
  Widget continueButton(BuildContext context, {Color color = hcPrimaryColor}) => TextButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Text('Ok', style: HcAppTextStyle.boldTextStyle(color: color)));

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
          style: HcAppTextStyle.boldTextStyle(size: 18),
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

RoundedRectangleBorder hcRoundedRectangleShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8),
);

/// returns Radius
BorderRadius hcRadius([double? radius]) {
  return BorderRadius.all(hcRadiusCircular(radius ?? hcDefaultRadius));
}

/// returns Radius
Radius hcRadiusCircular([double? radius]) {
  return Radius.circular(radius ?? hcDefaultRadius);
}