import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_compression/image_compression.dart' as ic;

import 'package:htkc_utils/image_compression_utils/basic_utils/hc_configurations.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_extension.dart';

/// Image compression engine
abstract class HcImageCompressionInterface {
  static const MethodChannel _channel = MethodChannel('hc_image_compression');

  @protected
  Future dummyCallNativeCode(
    String method,
    Map<String, dynamic> data,
    Future<ic.ImageFile> Function() callback,
  ) async {
    try {
      // Invoke will work only on Web, otherwise it will execute callback
      final result = await _channel.invokeMethod(method, data);
      if (result is Map) {
        return HcImageFileExtension.decode(result);
      }

      return null;
    } on MissingPluginException catch (_) {
      return await callback();
    }
  }

  /// Compressing image into supported format
  Future<ic.ImageFile> compress(HcImageFileConfiguration param) async {
    return await dummyCallNativeCode(
      'compress',
      param.toMap(),
      () {
        switch (param.config.outputType) {
          case HcImageOutputType.webpThenJpg:
            return compressWebpThenJpg(param);
          case HcImageOutputType.webpThenPng:
            return compressWebpThenPng(param);
          case HcImageOutputType.jpg:
            return compressJpg(param);
          case HcImageOutputType.png:
            return compressPng(param);
        }
      },
    );
  }

  /// Compressing image into WEBP if platform supported, otherwise JPG
  ///
  /// The [HcImageOutputType] is set automatically to [HcImageOutputType.webpThenJpg]
  Future<ic.ImageFile> compressWebpThenJpg(HcImageFileConfiguration param);

  /// Compressing image into WEBP if platform supported, otherwise PNG
  ///
  /// The [HcImageOutputType] is set automatically to [HcImageOutputType.webpThenPng]
  Future<ic.ImageFile> compressWebpThenPng(HcImageFileConfiguration param);

  /// Compressing image into JPG
  ///
  /// The [HcImageOutputType] is set automatically to [HcImageOutputType.jpg]
  Future<ic.ImageFile> compressJpg(HcImageFileConfiguration param);

  /// Compressing image into PNG
  ///
  /// The [HcImageOutputType] is set automatically to [HcImageOutputType.png]
  Future<ic.ImageFile> compressPng(HcImageFileConfiguration param);
}
