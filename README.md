HTKC Utils Package is a reusable Flutter package that provides a collection of utility functions, classes, and widgets that can be used in any Flutter project. It aims to simplify common tasks and enhance productivity by encapsulating frequently used functionalities into a single package.

## Features

Validation Utilities: The package includes various utility functions for validating user inputs, such as email addresses, phone numbers, passwords, etc. These functions can be used to ensure that the user provides valid and correctly formatted data.

Custom Widgets: It provides a set of pre-built custom widgets that can be easily integrated into any Flutter project. These widgets are designed to enhance the user interface and provide common functionalities, such as a loading spinner, toast messages, snackbar notifications, etc.

File and Image Handling: The package includes helper classes and functions for file and image handling. It provides methods for selecting images from the device's gallery, capturing images using the camera, compressing and resizing images, and saving files locally or remotely. These utilities simplify working with files and images in Flutter projects.

## Getting started

Create your project and follow below instructions.

## Usage

[Example] (https://github.com/ChandraHemant/htkc_utils/blob/main/example/example_app.dart)

To use this package : *add dependency to your [pubspec.yaml] file

```yaml
   dependencies:
       flutter:
         sdk: flutter
       htkc_utils: 
```
## Add to your dart file

```dart
import 'package:flutter/material.dart';
import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  runApp(const HTKCExample());
}

class HTKCExample extends StatefulWidget {
  const HTKCExample({super.key});

  @override
  State<HTKCExample> createState() => _HTKCExampleState();
}

class _HTKCExampleState extends State<HTKCExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: customAppBar(
          context,
          title: 'HTKC Example',
          bgColor: Colors.white,
          action: true,
          actionTitle: '+ New',
          isDialog: true,
          actionWidget: CustomAlertDialog(child: const Center(child: Text('Action Widget Clicked'))),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('HI')),
                  label: Text('Hello'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('BYE')),
                  label: Text('Good Night'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('GM')),
                  label: Text('Good Morning'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('GE')),
                  label: Text('Good Evening'),
                ),
              ],
            ),
          ),
        ));
  }
}

```
