import 'dart:typed_data';

import 'package:htkc_utils/image_compression_utils/hc_image_compress.dart';
import 'package:image_compression/image_compression.dart' as ic;
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_configurations.dart';

class HcCompressor {
  static Future<ic.ImageFile> compressNativeAndroidIOS(
    Uint8List input,
    int quality,
    HcCompressFormat format,
  ) async {
    final rawBytes = await HcImageCompress.compressWithList(
      input,
      quality: quality,
      format: format,
    );

    return ic.ImageFile(
      filePath: '',
      rawBytes: rawBytes,
    );
  }

  static Future<ic.ImageFile> compressWebpNativeAndroidIOS(
    HcImageFileConfiguration param,
    HcCompressFormat thenFormat,
  ) async {
    final input = param.input;
    final config = param.config;

    Uint8List rawBytes;
    try {
      rawBytes = await HcImageCompress.compressWithList(
        input.rawBytes,
        quality: config.quality,
        format: HcCompressFormat.webp,
      );
    } catch (_) {
      rawBytes = await HcImageCompress.compressWithList(
        input.rawBytes,
        quality: config.quality,
        format: thenFormat,
      );
    }

    return ic.ImageFile(
      filePath: '',
      rawBytes: rawBytes,
    );
  }
}
