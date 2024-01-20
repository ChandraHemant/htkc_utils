import 'package:device_info_plus/device_info_plus.dart';
import 'package:htkc_utils/upgrade/hc_upgrade_new_version_os.dart';
import 'package:version/version.dart';


class HcUpgradeDevice {
  Future<String?> getOsVersionString(HcUpgradeOS upgradeOS) async {
    final deviceInfo = DeviceInfoPlugin();
    String? osVersionString;
    if (upgradeOS.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      osVersionString = androidInfo.version.baseOS;
    } else if (upgradeOS.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      osVersionString = iosInfo.systemVersion;
    } else if (upgradeOS.isFuchsia) {
      osVersionString = '';
    } else if (upgradeOS.isLinux) {
      final info = await deviceInfo.linuxInfo;
      osVersionString = info.version;
    } else if (upgradeOS.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      final release = info.osRelease;

      // For macOS the release string looks like: Version 13.2.1 (Build 22D68)
      // We need to parse out the actual OS version number.

      String regExpSource = r"[\w]*[\s]*(?<version>[^\s]+)";
      final regExp = RegExp(regExpSource, caseSensitive: false);
      final match = regExp.firstMatch(release);
      final version = match?.namedGroup('version');
      osVersionString = version;
    } else if (upgradeOS.isWeb) {
      osVersionString = '0.0.0';
    } else if (upgradeOS.isWindows) {
      final info = await deviceInfo.windowsInfo;
      osVersionString = info.displayVersion;
    }

    // If the OS version string is not valid, don't use it.
    try {
      Version.parse(osVersionString!);
    } catch (e) {
      osVersionString = null;
    }

    return osVersionString;
  }
}

class HcMockUpgradeDevice extends HcUpgradeDevice {
  HcMockUpgradeDevice({this.osVersionString = ''});

  final String osVersionString;

  @override
  Future<String?> getOsVersionString(HcUpgradeOS upgradeOS) async =>
      osVersionString;
}
