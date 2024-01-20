
import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const appcastURL =
      'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast_macos.xml';
  final upgrader = HcUpgradeNewVersion(
    appCastConfig:
        HcAppCastConfiguration(url: appcastURL, supportedOS: ['macos']),
    debugLogging: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: HcUpgradeAlert(
          hcUpgrade: upgrader,
          child: Scaffold(
            appBar: AppBar(title: Text('Upgrader Example')),
            body: Center(child: Text('Checking...')),
          )),
    );
  }
}
