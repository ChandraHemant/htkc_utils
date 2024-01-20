import 'dart:async';

import 'package:htkc_utils/htkc_utils.dart';

final dialogKey = GlobalKey(debugLabel: 'gloabl_upgrader_alert_dialog');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  final log =
      () => print('$dialogKey mounted=${dialogKey.currentContext?.mounted}');
  unawaited(Future.delayed(Duration(seconds: 0)).then((value) => log()));
  unawaited(Future.delayed(Duration(seconds: 3)).then((value) => log()));
  unawaited(Future.delayed(Duration(seconds: 4)).then((value) => log()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: HcUpgradeAlert(
          dialogKey: dialogKey,
          child: Scaffold(
            appBar: AppBar(title: Text('Upgrader Example')),
            body: Center(child: Text('Checking...')),
          )),
    );
  }
}
