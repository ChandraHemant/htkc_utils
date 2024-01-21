
import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  // On Android, setup the Appcast.
  // On iOS, the default behavior will be to use the App Store version of
  // the app, so update the Bundle Identifier in example/ios/Runner with a
  // valid identifier already in the App Store.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const appcastURL =
      'https://raw.githubusercontent.com/larryaasen/upgrade/master/test/testappcast.xml';
  final upgrade = HcUpgradeNewVersion(
    appCastConfig:
        HcAppCastConfiguration(url: appcastURL, supportedOS: ['android']),
    debugLogging: true,
    minAppVersion: '1.1.0',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: Scaffold(
          appBar: AppBar(title: Text('Upgrader Example')),
          body: HcUpgradeAlert(
            hcUpgrade: upgrade,
            child: Center(child: Text('Checking...')),
          )),
    );
  }
}
