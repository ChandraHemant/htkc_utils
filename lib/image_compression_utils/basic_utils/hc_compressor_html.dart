import 'dart:async';

import 'package:image_compression/image_compression.dart' as ic;

import 'package:htkc_utils/image_compression_utils/basic_utils/hc_configurations.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_dart_compressor.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_interface.dart';

HcImageCompressionInterface getCompressor() => HcImageCompressionHtml();

class HcImageCompressionHtml extends HcImageCompressionInterface {
  @override
  Future<ic.ImageFile> compressWebpThenJpg(
      HcImageFileConfiguration param) async {
    return await HcDartCompressor.compressJpgDart(param);
  }

  @override
  Future<ic.ImageFile> compressWebpThenPng(
      HcImageFileConfiguration param) async {
    return await HcDartCompressor.compressJpgDart(param);
  }

  @override
  Future<ic.ImageFile> compressJpg(HcImageFileConfiguration param) async {
    return await HcDartCompressor.compressJpgDart(param);
  }

  @override
  Future<ic.ImageFile> compressPng(HcImageFileConfiguration param) async {
    return await HcDartCompressor.compressPngDart(param);
  }
}
