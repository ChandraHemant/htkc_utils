import 'dart:typed_data';

import 'package:htkc_utils/htkc_utils.dart';

extension HcXFileExtension on XFile {
  Future<ImageFile> get asImageFile async {
    return ImageFile(
      filePath: path,
      rawBytes: await readAsBytes(),
      contentType: mimeType,
    );
  }
}

extension HcImageFileExtension on ImageFile {
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['filePath'] = filePath;
    map['rawBytes'] = List<int>.from(rawBytes);
    if (contentType != null) map['contentType'] = contentType;
    if (width != null) map['width'] = width;
    if (height != null) map['height'] = height;

    return map;
  }

  static ImageFile decode(dynamic data) {
    return ImageFile(
      filePath: data['filePath'],
      rawBytes: Uint8List.fromList(List<int>.from(data['rawBytes'])),
      contentType: data['contentType'],
      width: data['width'],
      height: data['height'],
    );
  }
}

extension HcConfigurationExtension on HcConfiguration {
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['quality'] = quality;
    map['outputType'] = outputType.index;
    map['useJpgPngNativeCompressor'] = useJpgPngNativeCompressor;

    return map;
  }

  static HcConfiguration decode(dynamic data) {
    return HcConfiguration(
      quality: data['quality'] as int,
      outputType: HcImageOutputType.values[data['outputType'] as int],
      useJpgPngNativeCompressor: data['useJpgPngNativeCompressor'],
    );
  }
}

extension HcImageFileConfigurationExtension on HcImageFileConfiguration {
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['input'] = input.toMap();
    map['config'] = config.toMap();

    return map;
  }

  static HcImageFileConfiguration decode(dynamic data) {
    return HcImageFileConfiguration(
      input: HcImageFileExtension.decode(data['input']),
      config: HcConfigurationExtension.decode(data['config']),
    );
  }
}
