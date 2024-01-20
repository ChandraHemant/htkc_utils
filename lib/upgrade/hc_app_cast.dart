// ignore_for_file: constant_identifier_names

import 'dart:convert' show utf8;

import 'package:flutter/foundation.dart';
import 'package:htkc_utils/upgrade/hc_upgrade_new_version_device.dart';
import 'package:htkc_utils/upgrade/hc_upgrade_new_version_os.dart';
import 'package:http/http.dart' as http;
import 'package:version/version.dart';
import 'package:xml/xml.dart';


/// The [HcAppCast] class is used to download an Appcast, based on the Sparkle
/// Documentation: https://sparkle-project.org/documentation/publishing/
/// An Appcast is an RSS feed with one channel that has a collection of items
/// that each describe one app version.
class HcAppCast {
  /// Provide an HTTP Client that can be replaced during testing.
  final http.Client client;

  /// Provide [HcUpgradeOS] that can be replaced during testing.
  final HcUpgradeOS hcUpgradeOS;

  /// Provide [HcUpgradeDevice] that ca be replaced during testing.
  final HcUpgradeDevice hcUpgradeDevice;

  HcAppCast({
    http.Client? client,
    HcUpgradeOS? hcUpgradeOS,
    HcUpgradeDevice? hcUpgradeDevice,
  })  : client = client ?? http.Client(),
        hcUpgradeOS = hcUpgradeOS ?? HcUpgradeOS(),
        hcUpgradeDevice = hcUpgradeDevice ?? HcUpgradeDevice();

  /// The items in the Appcast.
  List<AppCastItem>? items;

  String? osVersionString;

  /// Returns the latest critical item in the Appcast.
  AppCastItem? bestCriticalItem() {
    if (items == null) {
      return null;
    }

    AppCastItem? bestItem;
    for (var item in items!) {
      if (item.hostSupportsItem(
              osVersion: osVersionString,
              currentPlatform: hcUpgradeOS.current) &&
          item.isCriticalUpdate) {
        if (bestItem == null) {
          bestItem = item;
        } else {
          try {
            final itemVersion = Version.parse(item.versionString!);
            final bestItemVersion = Version.parse(bestItem.versionString!);
            if (itemVersion > bestItemVersion) {
              bestItem = item;
            }
          } on Exception catch (e) {
            if (kDebugMode) {
              print('hcUpgrade: criticalUpdateItem invalid version: $e');
            }
          }
        }
      }
    }
    return bestItem;
  }

  /// Returns the latest item in the Appcast based on OS, OS version, and app
  /// version.
  AppCastItem? bestItem() {
    if (items == null) {
      return null;
    }

    AppCastItem? bestItem;
    for (var item in items!) {
      if (item.hostSupportsItem(
          osVersion: osVersionString, currentPlatform: hcUpgradeOS.current)) {
        if (bestItem == null) {
          bestItem = item;
        } else {
          try {
            final itemVersion = Version.parse(item.versionString!);
            final bestItemVersion = Version.parse(bestItem.versionString!);
            if (itemVersion > bestItemVersion) {
              bestItem = item;
            }
          } on Exception catch (e) {
            if (kDebugMode) {
              print('hcUpgrade: bestItem invalid version: $e');
            }
          }
        }
      }
    }
    return bestItem;
  }

  /// Download the Appcast from [appCastURL].
  Future<List<AppCastItem>?> parseAppCastItemsFromUri(String appCastURL) async {
    http.Response response;
    try {
      response = await client.get(Uri.parse(appCastURL));
    } catch (e) {
      if (kDebugMode) {
        print('hcUpgrade: parseAppcastItemsFromUri exception: $e');
      }
      return null;
    }
    final contents = utf8.decode(response.bodyBytes);
    return parseAppcastItems(contents);
  }

  /// Parse the Appcast from XML string.
  Future<List<AppCastItem>?> parseAppcastItems(String contents) async {
    osVersionString = await hcUpgradeDevice.getOsVersionString(hcUpgradeOS);
    return parseItemsFromXMLString(contents);
  }

  List<AppCastItem>? parseItemsFromXMLString(String xmlString) {
    items = null;

    if (xmlString.isEmpty) {
      return null;
    }

    try {
      // Parse the XML
      final document = XmlDocument.parse(xmlString);

      // Ensure the root element is valid
      document.rootElement;

      var localItems = <AppCastItem>[];

      // look for all item elements in the rss/channel
      document.findAllElements('item').forEach((XmlElement itemElement) {
        String? title;
        String? itemDescription;
        String? dateString;
        String? fileURL;
        String? maximumSystemVersion;
        String? minimumSystemVersion;
        String? osString;
        String? releaseNotesLink;
        final tags = <String>[];
        String? newVersion;
        String? itemVersion;
        String? enclosureVersion;

        for (var childNode in itemElement.children) {
          if (childNode is XmlElement) {
            final name = childNode.name.toString();
            if (name == AppCastConstants.ElementTitle) {
              title = childNode.innerText;
            } else if (name == AppCastConstants.ElementDescription) {
              itemDescription = childNode.innerText;
            } else if (name == AppCastConstants.ElementEnclosure) {
              for (var attribute in childNode.attributes) {
                if (attribute.name.toString() ==
                    AppCastConstants.AttributeVersion) {
                  enclosureVersion = attribute.value;
                } else if (attribute.name.toString() ==
                    AppCastConstants.AttributeOsType) {
                  osString = attribute.value;
                } else if (attribute.name.toString() ==
                    AppCastConstants.AttributeURL) {
                  fileURL = attribute.value;
                }
              }
            } else if (name == AppCastConstants.ElementMaximumSystemVersion) {
              maximumSystemVersion = childNode.innerText;
            } else if (name == AppCastConstants.ElementMinimumSystemVersion) {
              minimumSystemVersion = childNode.innerText;
            } else if (name == AppCastConstants.ElementPubDate) {
              dateString = childNode.innerText;
            } else if (name == AppCastConstants.ElementReleaseNotesLink) {
              releaseNotesLink = childNode.innerText;
            } else if (name == AppCastConstants.ElementTags) {
              for (var tagChildNode in childNode.children) {
                if (tagChildNode is XmlElement) {
                  final tagName = tagChildNode.name.toString();
                  tags.add(tagName);
                }
              }
            } else if (name == AppCastConstants.AttributeVersion) {
              itemVersion = childNode.innerText;
            }
          }
        }

        if (itemVersion == null) {
          newVersion = enclosureVersion;
        } else {
          newVersion = itemVersion;
        }

        // There must be a version
        if (newVersion == null || newVersion.isEmpty) {
          return;
        }

        final item = AppCastItem(
          title: title,
          itemDescription: itemDescription,
          dateString: dateString,
          maximumSystemVersion: maximumSystemVersion,
          minimumSystemVersion: minimumSystemVersion,
          osString: osString,
          releaseNotesURL: releaseNotesLink,
          tags: tags,
          fileURL: fileURL,
          versionString: newVersion,
        );
        localItems.add(item);
      });

      items = localItems;
    } catch (e) {
      if (kDebugMode) {
        print('hcUpgrade: parseItemsFromXMLString exception: $e');
      }
    }

    return items;
  }
}

class AppCastItem {
  final String? title;
  final String? dateString;
  final String? itemDescription;
  final String? releaseNotesURL;
  final String? minimumSystemVersion;
  final String? maximumSystemVersion;
  final String? fileURL;
  final int? contentLength;
  final String? versionString;
  final String? osString;
  final String? displayVersionString;
  final String? infoURL;
  final List<String>? tags;

  AppCastItem({
    this.title,
    this.dateString,
    this.itemDescription,
    this.releaseNotesURL,
    this.minimumSystemVersion,
    this.maximumSystemVersion,
    this.fileURL,
    this.contentLength,
    this.versionString,
    this.osString,
    this.displayVersionString,
    this.infoURL,
    this.tags,
  });

  /// Returns true if the tags ([AppCastConstants.ElementTags]) contains
  /// critical update ([AppCastConstants.ElementCriticalUpdate]).
  bool get isCriticalUpdate => tags == null
      ? false
      : tags!.contains(AppCastConstants.ElementCriticalUpdate);

  /// Does the host support this item? If so is [osVersion] supported?
  bool hostSupportsItem({String? osVersion, required String currentPlatform}) {
    assert(currentPlatform.isNotEmpty);
    bool supported = true;
    if (osString != null && osString!.isNotEmpty) {
      final platformEnum = 'TargetPlatform.${osString!}';
      currentPlatform = 'TargetPlatform.$currentPlatform';
      supported = platformEnum.toLowerCase() == currentPlatform.toLowerCase();
    }

    if (supported && osVersion != null && osVersion.isNotEmpty) {
      Version osVersionValue;
      try {
        osVersionValue = Version.parse(osVersion);
      } catch (e) {
        if (kDebugMode) {
          print('hcUpgrade: hostSupportsItem invalid osVersion: $e');
        }
        return false;
      }
      if (maximumSystemVersion != null) {
        try {
          final maxVersion = Version.parse(maximumSystemVersion!);
          if (osVersionValue > maxVersion) {
            supported = false;
          }
        } on Exception catch (e) {
          if (kDebugMode) {
            print('hcUpgrade: hostSupportsItem invalid maximumSystemVersion: $e');
          }
        }
      }
      if (supported && minimumSystemVersion != null) {
        try {
          final minVersion = Version.parse(minimumSystemVersion!);
          if (osVersionValue < minVersion) {
            supported = false;
          }
        } on Exception catch (e) {
          if (kDebugMode) {
            print('hcUpgrade: hostSupportsItem invalid minimumSystemVersion: $e');
          }
        }
      }
    }
    return supported;
  }
}

/// These constants taken from:
/// https://github.com/sparkle-project/Sparkle/blob/master/Sparkle/SUConstants.m
class AppCastConstants {
  static const String AttributeDeltaFrom = 'sparkle:deltaFrom';
  static const String AttributeDSASignature = 'sparkle:dsaSignature';
  static const String AttributeEDSignature = 'sparkle:edSignature';
  static const String AttributeShortVersionString =
      'sparkle:shortVersionString';
  static const String AttributeVersion = 'sparkle:version';
  static const String AttributeOsType = 'sparkle:os';

  static const String ElementCriticalUpdate = 'sparkle:criticalUpdate';
  static const String ElementDeltas = 'sparkle:deltas';
  static const String ElementMinimumSystemVersion =
      'sparkle:minimumSystemVersion';
  static const String ElementMaximumSystemVersion =
      'sparkle:maximumSystemVersion';
  static const String ElementReleaseNotesLink = 'sparkle:releaseNotesLink';
  static const String ElementTags = 'sparkle:tags';

  static const String AttributeURL = 'url';
  static const String AttributeLength = 'length';

  static const String ElementDescription = 'description';
  static const String ElementEnclosure = 'enclosure';
  static const String ElementLink = 'link';
  static const String ElementPubDate = 'pubDate';
  static const String ElementTitle = 'title';
}
