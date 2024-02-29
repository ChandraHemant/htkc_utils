import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ar'), // Arabic language shows right to left.
      supportedLocales: [
        const Locale('ar', ''), // Arabic, no country code
        const Locale('he', ''), // Hebrew, no country code
      ],
      title: 'Upgrader Left to Right Example',
      home: HcUpgradeAlert(
          child: Scaffold(
        appBar: AppBar(title: Text('Upgrader Left to Right Example')),
        body: Center(child: Text('Checking...')),
      )),
    );
  }
}
