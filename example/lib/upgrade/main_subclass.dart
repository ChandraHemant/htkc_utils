
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
  MyApp({Key? key}) : super(key: key);

  final upgrader = MyUpgrader();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Subclass Example',
      home: Scaffold(
          appBar: AppBar(title: Text('Upgrader Subclass Example')),
          body: HcUpgradeAlert(
            hcUpgrade: upgrader,
            child: Center(child: Text('Checking...')),
          )),
    );
  }
}

/// This class extends / subclasses Upgrader.
class MyUpgrader extends HcUpgradeNewVersion {
  MyUpgrader() : super(debugLogging: true);
}
