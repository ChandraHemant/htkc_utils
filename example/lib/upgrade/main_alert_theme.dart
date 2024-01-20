import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: MyUpgradeAlert(
          child: Scaffold(
        appBar: AppBar(title: Text('Upgrader Alert Theme Example')),
        body: Center(child: Text('Checking...')),
      )),
    );
  }
}

class MyUpgradeAlert extends HcUpgradeAlert {
  MyUpgradeAlert({super.hcUpgrade, super.child});

  /// Override the [createState] method to provide a custom class
  /// with overridden methods.
  @override
  HcUpgradeAlertState createState() => MyUpgradeAlertState();
}

class MyUpgradeAlertState extends HcUpgradeAlertState {
  @override
  Widget alertDialog(
      Key? key,
      String title,
      String message,
      String? releaseNotes,
      BuildContext context,
      bool cupertino,
      HcUpgradeMessages messages) {
    return Theme(
      data: ThemeData(
        dialogTheme: DialogTheme(
            titleTextStyle: TextStyle(color: Colors.red, fontSize: 48.0)),
      ),
      child: super.alertDialog(
          key, title, message, releaseNotes, context, cupertino, messages),
    );
  }
}
