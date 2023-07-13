HTKC Utils Package is a reusable Flutter package that provides a collection of utility functions, classes, and widgets that can be used in any Flutter project. It aims to simplify common tasks and enhance productivity by encapsulating frequently used functionalities into a single package.

## Features

Validation Utilities: The package includes various utility functions for validating user inputs, such as email addresses, phone numbers, passwords, etc. These functions can be used to ensure that the user provides valid and correctly formatted data.

Custom Widgets: It provides a set of pre-built custom widgets that can be easily integrated into any Flutter project. These widgets are designed to enhance the user interface and provide common functionalities, such as a loading spinner, toast messages, snackbar notifications, etc.

File and Image Handling: The package includes helper classes and functions for file and image handling. It provides methods for selecting images from the device's gallery, capturing images using the camera, compressing and resizing images, and saving files locally or remotely. These utilities simplify working with files and images in Flutter projects.

## Getting started

Create your project and follow below instructions.

## Usage

[Example] (https://github.com/ChandraHemant/htkc_utils/blob/main/example/)

To use this package : *add dependency to your [pubspec.yaml] file

```yaml
   dependencies:
       flutter:
         sdk: flutter
       htkc_utils: 
```
## Add to your dart file

```dart
import 'package:htkc_utils/htkc_utils.dart';

void main() async {
  runApp(const HTKCExample());
}

class HTKCExample extends StatefulWidget {
  const HTKCExample({Key? key}) : super(key: key);

  @override
  State<HTKCExample> createState() => _HTKCExampleState();
}

class _HTKCExampleState extends State<HTKCExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HcCustomAppBar(
          title: 'HTKC Example',
          bgColor: Colors.white,
          action: true,
          actionTitle: '+ New',
          isDialog: true,
          actionWidget: const HcCustomAlertDialog(child: Center(child: Text('Action Widget Clicked'))),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('AH')),
                  label: Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('ML')),
                  label: Text('Lafayette'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('HM')),
                  label: Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade900, child: Text('JL')),
                  label: Text('Laurens'),
                ),
              ],
            ),
          ),
        ));
  }
}


```

## Drag And Drop

**Drag and drop grid view**

```dart
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _imageUris = [
    "https://images.pexels.com/photos/4466054/pexels-photo-4466054.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/4561739/pexels-photo-4561739.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/4507967/pexels-photo-4507967.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/4321194/pexels-photo-4321194.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/1053924/pexels-photo-1053924.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/1624438/pexels-photo-1624438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/1144687/pexels-photo-1144687.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/2589010/pexels-photo-2589010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
  ];

  int variableSet = 0;
  ScrollController? _scrollController;
  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Drag And drop Plugin'),
        ),
        body: Center(
          child: DragAndDropGridView(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4.5,
            ),
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) => Card(
              elevation: 2,
              child: LayoutBuilder(
                builder: (context, costrains) {
                  if (variableSet == 0) {
                    height = costrains.maxHeight;
                    width = costrains.maxWidth;
                    variableSet++;
                  }
                  return GridTile(
                    child: Image.network(
                      _imageUris[index],
                      fit: BoxFit.cover,
                      height: height,
                      width: width,
                    ),
                  );
                },
              ),
            ),
            itemCount: _imageUris.length,
            onWillAccept: (oldIndex, newIndex) {
              // Implement you own logic

              // Example reject the reorder if the moving item's value is something specific
              if (_imageUris[newIndex] == "something") {
                return false;
              }
              return true; // If you want to accept the child return true or else return false
            },
            onReorder: (oldIndex, newIndex) {
              final temp = _imageUris[oldIndex];
              _imageUris[oldIndex] = _imageUris[newIndex];
              _imageUris[newIndex] = temp;

              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
```


## Emergent Text

**Text only handle positive depth**

```dart
child: EmergentText(
"I love flutter",
style: EmergentStyle(
depth: 4,  //customize depth here
color: Colors.white, //customize color here
),
textStyle: EmergentTextStyle(
fontSize: 18, //customize size here
// AND others usual text style properties (fontFamily, fontWeight, ...)
),
),
```


## Emergent Icon

```dart
child: EmergentIcon(
Icons.add_circle,
size: 80,
),
```

How to display **SVG** icons ?

Simply use [https://fluttericon.com/](https://fluttericon.com/) to export your svg as .ttf & use EmergentIcon(YOUR_ICON)

## 🎨 Custom Shape

Flutter Emergent supports custom shapes, just provide a path to

```dart
class MyShapePathProvider extends EmergentPathProvider {
  @override
  bool shouldReclip(EmergentPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width/2, 0)
      ..lineTo(size.width, size.height/2)
      ..lineTo(size.width/2, size.height/2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }
}
```

And use `EmergentBoxShape.path`

```dart
Emergent(
style: EmergentStyle(
boxShape: EmergentBoxShape.path(MyShapePathProvider()),
),
...
),
```

You can import the Flutter logo as a custom shape using

```dart
Emergent(
style: EmergentStyle(
shape: EmergentBoxShape.path(EmergentFlutterLogoPathProvider()),
),
...
),
```

## 🔲 Accessibility / Border

For design purposes, or simply to enhance accessibility,
you can add a border on Emergent widgets


```dart
Emergent(
style: EmergentStyle(
border: EmergentBorder(
color: Color(0x33000000),
width: 0.8,
)
),
...
)
```

You can enable/disable it (eg: listening an Accessibility Provider) with `isEnabled`

```dart
border: EmergentBorder(
isEnabled: true,
color: Color(0x33000000),
width: 0.8,
)
```

Note that `borderColor` and `borderWidth` default values has been added to `EmergentThemeData`

## 🎨 Emergent Theme


```dart
EmergentTheme(
themeMode: ThemeMode.light, //or dark / system
darkTheme: EmergentThemeData(
baseColor: Color(0xff333333),
accentColor: Colors.green,
lightSource: LightSource.topLeft,
depth: 4,
intensity: 0.3,
),
theme: EmergentThemeData(
baseColor: Color(0xffDDDDDD),
accentColor: Colors.cyan,
lightSource: LightSource.topLeft,
depth: 6,
intensity: 0.5,
),
child: ...
)
```

To retrieve the current used theme :

```dart
final theme = EmergentTheme.currentTheme(context);
final baseColor = theme.baseColor;
final accentColor = theme.accentColor;
...
```

Toggle from light to dark
```dart
EmergentTheme.of(context).themeMode = ThemeMode.dark;
```

Know if using dark
```dart
if(EmergentTheme.of(context).isUsingDark){

}
```

# EmergentApp

You can use direcly in your project a `EmergentApp`, surrounding your code

It handle directly EmergentTheme & Navigation (and all possibilities of MaterialApp )

```dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EmergentApp(
      debugShowCheckedModeBanner: false,
      title: 'Emergent App',
      themeMode: ThemeMode.light,
      theme: EmergentThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: EmergentThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: MyHomePage(),
    );
  }
}
```
