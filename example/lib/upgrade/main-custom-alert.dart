
import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await HcUpgradeNewVersion.clearSavedSettings(); // REMOVE this for release builds

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final upgrade = MyUpgrader(debugLogging: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: MyUpgradeAlert(
          hcUpgrade: upgrade,
          child: Scaffold(
            appBar: AppBar(title: Text('Upgrader Custom Alert Example')),
            body: Center(child: Text('Checking...')),
          )),
    );
  }
}

class MyUpgrader extends HcUpgradeNewVersion {
  MyUpgrader({super.debugLogging});

  @override
  bool isTooSoon() {
    return super.isTooSoon();
  }

  @override
  bool isUpdateAvailable() {
    final appStoreVersion = currentAppStoreVersion;
    final installedVersion = currentInstalledVersion;
    print('appStoreVersion=$appStoreVersion');
    print('installedVersion=$installedVersion');
    return super.isUpdateAvailable();
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
  void showTheDialog({
    Key? key,
    required BuildContext context,
    required String? title,
    required String message,
    required String? releaseNotes,
    required bool canDismissDialog,
    required HcUpgradeMessages messages,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            key: key,
            title: const Text('Update?'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Would you like to update?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  onUserIgnored(context, true);
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  onUserUpdated(context, !widget.upgrade.blocked());
                },
              ),
            ],
          );
        });
  }
}
