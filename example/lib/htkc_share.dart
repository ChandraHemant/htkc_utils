import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:htkc_utils/htkc_utils.dart';

class HtkcSharePage extends StatefulWidget {
  HtkcSharePage();

  @override
  _HtkcSharePageState createState() => _HtkcSharePageState();
}

class _HtkcSharePageState extends State<HtkcSharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HTKC Share Plugin Sample'),
        ),
        body: Center(
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Share text'),
                  onPressed: () async => await _shareText(),
                ),
                ElevatedButton(
                  child: Text('Share image'),
                  onPressed: () async => await _shareImage(),
                ),
                ElevatedButton(
                  child: Text('Share images'),
                  onPressed: () async => await _shareImages(),
                ),
                ElevatedButton(
                  child: Text('Share CSV'),
                  onPressed: () async => await _shareCSV(),
                ),
                ElevatedButton(
                  child: Text('Share mixed'),
                  onPressed: () async => await _shareMixed(),
                ),
                ElevatedButton(
                  child: Text('Share image from url'),
                  onPressed: () async => await _shareImageFromUrl(),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _shareText() async {
    try {
      HcShare.text('my text title', 'This is my text to share with other applications.', 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/image1.png');
      await HcShare.file('esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png', text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImages() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/image1.png');
      final ByteData bytes2 = await rootBundle.load('assets/image2.png');

      await HcShare.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
          },
          'image/png');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareCSV() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/addresses.csv');
      await HcShare.file('addresses', 'addresses.csv', bytes.buffer.asUint8List(), 'text/csv');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareMixed() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/image1.png');
      final ByteData bytes2 = await rootBundle.load('assets/image2.png');
      final ByteData bytes3 = await rootBundle.load('assets/addresses.csv');

      await HcShare.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
            'addresses.csv': bytes3.buffer.asUint8List(),
          },
          '*/*',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImageFromUrl() async {
    try {
      var request =
      await HttpClient().getUrl(Uri.parse('https://cdn.shopware.store/r/4/9/Q2AEt/thumbnail/5d/d6/aa/1612969110/leiterplatte_800x800.png'));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await HcShare.file('HTKC LOG', 'amlog.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }
}