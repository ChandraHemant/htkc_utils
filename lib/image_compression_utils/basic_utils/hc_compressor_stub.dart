import 'package:image_compression/image_compression.dart' as ic;

import 'package:htkc_utils/image_compression_utils/basic_utils/hc_configurations.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_interface.dart';

HcImageCompressionInterface getCompressor() => HcImageCompressionStub();

class HcImageCompressionStub extends HcImageCompressionInterface {
  @override
  Future<ic.ImageFile> compressJpg(HcImageFileConfiguration param) {
    throw UnimplementedError();
  }

  @override
  Future<ic.ImageFile> compressPng(HcImageFileConfiguration param) {
    throw UnimplementedError();
  }

  @override
  Future<ic.ImageFile> compressWebpThenJpg(HcImageFileConfiguration param) {
    throw UnimplementedError();
  }

  @override
  Future<ic.ImageFile> compressWebpThenPng(HcImageFileConfiguration param) {
    throw UnimplementedError();
  }
}
