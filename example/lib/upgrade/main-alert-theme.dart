import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  // On Android, the default behavior will be to use the Google Play Store
  // version of the app.
  // On iOS, the default behavior will be to use the App Store version of
  // the app, so update the Bundle Identifier in example/ios/Runner with a
  // valid identifier already in the App Store.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final dark = ThemeData.dark(useMaterial3: true);

  final light = ThemeData(
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(color: Colors.red, fontSize: 48),
      contentTextStyle: TextStyle(color: Colors.green, fontSize: 18),
    ),
    // Change the text buttons.
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        // Change the color of the text buttons.
        foregroundColor: MaterialStatePropertyAll(Colors.orange),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: HcUpgradeAlert(
          child: Scaffold(
        appBar: AppBar(title: Text('Upgrader Alert Theme Example')),
        body: Center(child: Text('Checking...')),
      )),
      theme: light,
      darkTheme: dark,
    );
  }
}
