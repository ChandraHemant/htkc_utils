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
    cardTheme: CardTheme(color: Colors.greenAccent),
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
      title: 'Upgrader Card Example',
      home: Scaffold(
        appBar: AppBar(title: Text('Upgrader Card Theme Example')),
        body: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _simpleCard,
                _simpleCard,
                HcUpgradeNewVersionCard(),
                _simpleCard,
                _simpleCard,
              ],
            ),
          ),
        ),
      ),
      theme: light,
      darkTheme: dark,
    );
  }

  Widget get _simpleCard => Card(
        child: SizedBox(
          width: 200,
          height: 50,
          child: Center(child: Text('Card')),
        ),
      );
}
