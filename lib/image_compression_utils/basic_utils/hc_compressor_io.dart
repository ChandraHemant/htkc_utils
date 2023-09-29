import 'dart:async';
import 'dart:io';

import 'package:image_compression/image_compression.dart' as ic;
import 'package:htkc_utils/image_compression_utils/hc_image_compress.dart';

import 'package:htkc_utils/image_compression_utils/basic_utils/hc_configurations.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_dart_compressor.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_extension.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_compressor.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_interface.dart';

HcImageCompressionInterface getCompressor() => HcImageCompressionIO();

class HcImageCompressionIO extends HcImageCompressionInterface {
  @override
  Future<ic.ImageFile> compressWebpThenJpg(
      HcImageFileConfiguration param) async {
    return await dummyCallNativeCode(
      'compressWebpThenJpg',
      param.toMap(),
      () {
        if (Platform.isAndroid || Platform.isIOS) {
          return HcCompressor.compressWebpNativeAndroidIOS(
            param,
            HcCompressFormat.jpeg,
          );
        }

        return compressJpg(param);
      },
    );
  }

  @override
  Future<ic.ImageFile> compressWebpThenPng(
      HcImageFileConfiguration param) async {
    return await dummyCallNativeCode(
      'compressWebpThenPng',
      param.toMap(),
      () {
        if (Platform.isAndroid || Platform.isIOS) {
          return HcCompressor.compressWebpNativeAndroidIOS(
            param,
            HcCompressFormat.png,
          );
        }

        return compressPng(param);
      },
    );
  }

  @override
  Future<ic.ImageFile> compressJpg(HcImageFileConfiguration param) async {
    return await dummyCallNativeCode(
      'compressJpg',
      param.toMap(),
      () {
        if (param.config.useJpgPngNativeCompressor &&
            (Platform.isAndroid || Platform.isIOS)) {
          return HcCompressor.compressNativeAndroidIOS(
            param.input.rawBytes,
            param.config.quality,
            HcCompressFormat.jpeg,
          );
        }

        return HcDartCompressor.compressJpgDart(param);
      },
    );
  }

  @override
  Future<ic.ImageFile> compressPng(HcImageFileConfiguration param) async {
    return await dummyCallNativeCode(
      'compressPng',
      param.toMap(),
      () {
        if (param.config.useJpgPngNativeCompressor &&
            (Platform.isAndroid || Platform.isIOS)) {
          return HcCompressor.compressNativeAndroidIOS(
            param.input.rawBytes,
            param.config.quality,
            HcCompressFormat.png,
          );
        }

        return HcDartCompressor.compressPngDart(param);
      },
    );
  }
}
