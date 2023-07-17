import 'dart:async';

import 'package:flutter/services.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:htkc_utils/htkc_utils.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_compressor_html.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_extension.dart';

/// A web implementation of the ImageCompressionFlutter plugin.
class HcImageCompressionWeb {
  // static void registerWith(Registrar registrar) {
  //   final MethodChannel channel = MethodChannel(
  //     'hc_image_compression',
  //     const StandardMethodCodec(),
  //     registrar,
  //   );
  //
  //   final pluginInstance = HcImageCompressionWeb();
  //   channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  // }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    final compressor = getCompressor();
    final ImageFile output;

    switch (call.method) {
      case 'compress':
        final param = HcImageFileConfigurationExtension.decode(call.arguments);

        switch (param.config.outputType) {
          case HcImageOutputType.webpThenJpg:
            output = await compressor.compressWebpThenJpg(param);
            break;
          case HcImageOutputType.webpThenPng:
            output = await compressor.compressWebpThenPng(param);
            break;
          case HcImageOutputType.jpg:
            output = await compressor.compressJpg(param);
            break;
          case HcImageOutputType.png:
            output = await compressor.compressPng(param);
            break;
        }
        break;
      case 'compressWebpThenJpg':
        final param = HcImageFileConfigurationExtension.decode(call.arguments);
        output = await compressor.compressWebpThenJpg(param);
        break;
      case 'compressWebpThenPng':
        final param = HcImageFileConfigurationExtension.decode(call.arguments);
        output = await compressor.compressWebpThenPng(param);
        break;
      case 'compressJpg':
        final param = HcImageFileConfigurationExtension.decode(call.arguments);
        output = await compressor.compressJpg(param);
        break;
      case 'compressPng':
        final param = HcImageFileConfigurationExtension.decode(call.arguments);
        output = await compressor.compressPng(param);
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'hc_image_compression for web doesn\'t implement \'${call.method}\'',
        );
    }

    return output.toMap();
  }
}
