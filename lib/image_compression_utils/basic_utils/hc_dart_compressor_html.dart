import 'package:image_compression/image_compression.dart' as ic;

import 'package:htkc_utils/image_compression_utils/basic_utils/hc_configurations.dart';

class HcDartCompressorHtml {
  static Future<ic.ImageFile> compressJpgDart(
    HcImageFileConfiguration param,
  ) async {
    final input = param.input;
    final config = param.config;

    return await ic.compressInQueue(
      ic.ImageFileConfiguration(
        input: input,
        config: ic.Configuration(
          outputType: ic.OutputType.jpg,
          jpgQuality: config.quality,
        ),
      ),
    );
  }

  static Future<ic.ImageFile> compressPngDart(
    HcImageFileConfiguration param,
  ) async {
    final input = param.input;
    final config = param.config;

    var compression = ic.PngCompression.defaultCompression;
    if (config.quality >= 80 && config.quality <= 100) {
      compression = ic.PngCompression.bestCompression;
    } else if (config.quality >= 10 && config.quality <= 40) {
      compression = ic.PngCompression.bestSpeed;
    } else if (config.quality < 10) {
      compression = ic.PngCompression.noCompression;
    }

    return await ic.compressInQueue(
      ic.ImageFileConfiguration(
        input: input,
        config: ic.Configuration(
          outputType: ic.OutputType.png,
          pngCompression: compression,
        ),
      ),
    );
  }
}
