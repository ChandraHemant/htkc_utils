import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example - Multiple',
      home: HcUpgradeAlert(
          child: Scaffold(
        appBar: AppBar(title: Text('Upgrader Example - Multiple')),
        body: Center(child: HcUpgradeAlert(child: Text('Checking...'))),
      )),
    );
  }
}
