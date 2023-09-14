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

## Multiselect Dropdown

```dart
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HcMultipleSelectItem> elements = List.generate(
    15,
        (index) => HcMultipleSelectItem.build(
      value: index,
      display: '$index display',
      content: '$index content',
    ),
  );

  List _selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MultiSelect DropDown"),
      ),
      body: HcMultipleDropDown(
        placeholder: 'Hint Text',
        disabled: false,
        values: _selectedValues,
        elements: elements,
      ),
    );
  }
}
```

## Dotted Border

```dart
HcDottedBorder(
    color: Colors.black,
    strokeWidth: 1,
    child: FlutterLogo(size: 148),
)
```

### BorderTypes

This package supports the following border types at the moment
* RectBorder
* RRectBorder
* CircleBorder
* OvalBorder

#### Example

```dart
return HcDottedBorder(
  borderType: HcBorderType.rRect,
  radius: Radius.circular(12),
  padding: EdgeInsets.all(6),
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    child: Container(
      height: 200,
      width: 120,
      color: Colors.amber,
    ),
  ),
);
```

### Dash Pattern

Now you can also specify the Dash Sequence by passing in an Array of Doubles

#### Example
```dart
HcDottedBorder(
    dashPattern: [6, 3, 2, 3], 
    child: ...
);
```

The above code block will render a dashed border with the following pattern:

* 6 pixel wide dash
* 3 pixel wide space
* 2 pixel wide dash
* 3 pixel wide space

### Custom Path Border

You can also specify any path as the `customPath` property when initializing the DottedBorderWidget, and it will draw it for you using the provided dash pattern.

#### Example

```dart
Path customPath = Path()
  ..moveTo(20, 20)
  ..lineTo(50, 100)
  ..lineTo(20, 200)
  ..lineTo(100, 100)
  ..lineTo(20, 20);

return HcDottedBorder(
  customPath: (size) => customPath, // PathBuilder
  color: Colors.indigo,
  dashPattern: [8, 4],
  strokeWidth: 2,
  child: Container(
    height: 220,
    width: 120,
    color: Colors.green.withAlpha(20),
  ),
);
```


## Circular Chart

```dart
final GlobalKey<HcAnimatedCircularChartState> _chartKey = new GlobalKey<HcAnimatedCircularChartState>();
```

Create chart data entry objects:

```dart
List<HcCircularSegmentEntry> data = <HcCircularSegmentEntry>[
  new HcCircularSegmentEntry(
    <HcCircularSegmentEntry>[
      new HcCircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
      new HcCircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
      new HcCircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
      new HcCircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
    ],
    rankKey: 'Quarterly Profits',
  ),
];
```

Create an `HcAnimatedCircularChart`, passing it the `_chartKey` and initial `data`:

```dart
@override
Widget build(BuildContext context) {
  return new HcAnimatedCircularChart(
    key: _chartKey,
    size: const Size(300.0, 300.0),
    initialChartData: data,
    chartType: HcCircularChartType.pie,
  );
}
```

Call `updateData` to animate the chart:

```dart
void _cycleSamples() {
  List<HcCircularStackEntry> nextData = <HcCircularStackEntry>[
    new HcCircularStackEntry(
      <HcCircularSegmentEntry>[
        new HcCircularSegmentEntry(1500.0, Colors.red[200], rankKey: 'Q1'),
        new HcCircularSegmentEntry(750.0, Colors.green[200], rankKey: 'Q2'),
        new HcCircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new HcCircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];
  setState(() {
    _chartKey.currentState.updateData(nextData);
  });
}
```

## Customization

### Hole Label:

```dart
HcAnimatedCircularChart(
  key: _chartKey,
  size: _chartSize,
  initialChartData: <HcCircularStackEntry>[
    new HcCircularStackEntry(
      <HcCircularSegmentEntry>[
        new HcCircularSegmentEntry(
          33.33,
          Colors.blue[400],
          rankKey: 'completed',
        ),
        new HcCircularSegmentEntry(
          66.67,
          Colors.blueGrey[600],
          rankKey: 'remaining',
        ),
      ],
      rankKey: 'progress',
    ),
  ],
  chartType: HcCircularChartType.Radial,
  percentageValues: true,
  holeLabel: '1/3',
  labelStyle: new TextStyle(
    color: Colors.blueGrey[600],
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  ),
)
```


### Segment Edge Style:

```dart
HcAnimatedCircularChart(
  key: _chartKey,
  size: _chartSize,
  initialChartData: <HcCircularStackEntry>[
    new HcCircularStackEntry(
      <HcCircularSegmentEntry>[
        new HcCircularSegmentEntry(
          33.33,
          Colors.blue[400],
          rankKey: 'completed',
        ),
        new CircularSegmentEntry(
          66.67,
          Colors.blueGrey[600],
          rankKey: 'remaining',
        ),
      ],
      rankKey: 'progress',
    ),
  ],
  chartType: HcCircularChartType.radial,
  edgeStyle: HcSegmentEdgeStyle.round,
  percentageValues: true,
)
```

## Drag And Drop

**Drag and drop grid view**

```dart
import 'package:htkc_utils/htkc_utils.dart';
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


## Age Calculate

**Age Calculator**

```dart
import 'package:htkc_utils/htkc_utils.dart';

void main() {
  DateTime birthday = DateTime(1990, 1, 20);
  DateTime today = DateTime.now(); //2020/1/24

  HHcAgeDuration age;

  // Find out your age
  age = HcAge.dateDifference(
      fromDate: birthday, toDate: today, includeToDate: false);

  print('Your age is $age'); // Your age is Years: 30, Months: 0, Days: 4

  // Find out when your next birthday will be.
  DateTime tempDate = DateTime(today.year, birthday.month, birthday.day);
  DateTime nextBirthdayDate = tempDate.isBefore(today)
      ? HcAge.add(date: tempDate, duration: HcAgeDuration(years: 1))
      : tempDate;
  HcAgeDuration nextBirthdayDuration =
  HcAge.dateDifference(fromDate: today, toDate: nextBirthdayDate);

  print('You next birthday will be on $nextBirthdayDate or in $nextBirthdayDuration');
  // You next birthday will be on 2023-01-20 00:00:00.000 or in Years: 0, Months: 11, Days: 27
}
```


## Dropdown Suggestion

**DropDown Suggestion Search Field**

#### Single dialog
```dart
      HcSearchableDropdown.single(
        items: items,
        value: selectedValue,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        isExpanded: true,
      ),
```
#### Multi dialog
```dart
      HcSearchableDropdown.multiple(
        items: items,
        selectedItems: selectedItems,
        hint: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Select any"),
        ),
        searchHint: "Select any",
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        closeButton: (selectedItems) {
          return (selectedItems.isNotEmpty
              ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
              : "Save without selection");
        },
        isExpanded: true,
      ),
```

#### Single done button dialog
```dart
      HcSearchableDropdown.single(
        items: items,
        value: selectedValue,
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        doneButton: "Done",
        displayItem: (item, selected) {
          return (Row(children: [
            selected
                ? Icon(
                    Icons.radio_button_checked,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                  ),
            SizedBox(width: 7),
            Expanded(
              child: item,
            ),
          ]));
        },
        isExpanded: true,
      ),
```
#### Multi custom display dialog
```dart
      HcSearchableDropdown.multiple(
        items: items,
        selectedItems: selectedItems,
        hint: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Select any"),
        ),
        searchHint: "Select any",
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        displayItem: (item, selected) {
          return (Row(children: [
            selected
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey,
                  ),
            SizedBox(width: 7),
            Expanded(
              child: item,
            ),
          ]));
        },
        selectedValueWidgetFn: (item) {
          return (Center(
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.brown,
                      width: 0.5,
                    ),
                  ),
                  margin: EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item.toString()),
                  ))));
        },
        doneButton: (selectedItemsDone, doneContext) {
          return (RaisedButton(
              onPressed: () {
                Navigator.pop(doneContext);
                setState(() {});
              },
              child: Text("Save")));
        },
        closeButton: null,
        style: TextStyle(fontStyle: FontStyle.italic),
        searchFn: (String keyword, items) {
          List<int> ret = List<int>();
          if (keyword != null && items != null && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              items.forEach((item) {
                if (k.isNotEmpty &&
                    (item.value
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  ret.add(i);
                }
                i++;
              });
            });
          }
          if (keyword.isEmpty) {
            ret = Iterable<int>.generate(items.length).toList();
          }
          return (ret);
        },
        clearIcon: Icon(Icons.clear_all),
        icon: Icon(Icons.arrow_drop_down_circle),
        label: "Label for multi",
        underline: Container(
          height: 1.0,
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.teal, width: 3.0))),
        ),
        iconDisabledColor: Colors.brown,
        iconEnabledColor: Colors.indigo,
        isExpanded: true,
      ),
```

#### Multi select 3 dialog
```dart
      HcSearchableDropdown.multiple(
        items: items,
        selectedItems: selectedItems,
        hint: "Select 3 items",
        searchHint: "Select 3",
        validator: (selectedItemsForValidator) {
          if (selectedItemsForValidator.length != 3) {
            return ("Must select 3");
          }
          return (null);
        },
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        doneButton: (selectedItemsDone, doneContext) {
          return (RaisedButton(
              onPressed: selectedItemsDone.length != 3
                  ? null
                  : () {
                      Navigator.pop(doneContext);
                      setState(() {});
                    },
              child: Text("Save")));
        },
        closeButton: (selectedItems) {
          return (selectedItems.length == 3 ? "Ok" : null);
        },
        isExpanded: true,
      ),
```

#### Single menu
```dart
      HcSearchableDropdown.single(
        items: items,
        value: selectedValue,
        hint: "Select one",
        searchHint: null,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        dialogBox: false,
        isExpanded: true,
        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      ),
```

#### Multi menu
```dart
      HcSearchableDropdown.multiple(
        items: items,
        selectedItems: selectedItems,
        hint: "Select any",
        searchHint: "",
        doneButton: "Close",
        closeButton: SizedBox.shrink(),
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        dialogBox: false,
        isExpanded: true,
        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      ),
```

#### Multi menu select all/none
```dart
      HcSearchableDropdown.multiple(
        items: items,
        selectedItems: selectedItems,
        hint: "Select any",
        searchHint: "Select any",
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        dialogBox: false,
        closeButton: (selectedItemsClose) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                      selectedItems.addAll(
                          Iterable<int>.generate(items.length).toList());
                    });
                  },
                  child: Text("Select all")),
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                    });
                  },
                  child: Text("Select none")),
            ],
          );
        },
        isExpanded: true,
        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      ),
```

#### Multi dialog select all/none without clear
```dart
      HcSearchableDropdown.multiple(
        items: items,
        selectedItems: selectedItems,
        hint: "Select any",
        searchHint: "Select any",
        displayClearIcon: false,
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        dialogBox: true,
        closeButton: (selectedItemsClose) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                      selectedItems.addAll(
                          Iterable<int>.generate(items.length).toList());
                    });
                  },
                  child: Text("Select all")),
              RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedItems.clear();
                    });
                  },
                  child: Text("Select none")),
            ],
          );
        },
        isExpanded: true,
      ),
```

#### Single dialog custom keyboard
```dart
      HcSearchableDropdown.single(
        items: Iterable<int>.generate(20).toList().map((i) {
          return (DropdownMenuItem(
            child: Text(i.toString()),
            value: i.toString(),
          ));
        }).toList(),
        value: selectedValue,
        hint: "Select one number",
        searchHint: "Select one number",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        dialogBox: true,
        keyboardType: TextInputType.number,
        isExpanded: true,
      ),
```

#### Single dialog object
```dart
      HcSearchableDropdown.single(
        items: ExampleNumber.list.map((exNum) {
          return (DropdownMenuItem(
              child: Text(exNum.numberString), value: exNum));
        }).toList(),
        value: selectedNumber,
        hint: "Select one number",
        searchHint: "Select one number",
        onChanged: (value) {
          setState(() {
            selectedNumber = value;
          });
        },
        dialogBox: true,
        isExpanded: true,
      ),
```
#### Single dialog overflow
```dart
      HcSearchableDropdown.single(
        items: [
          DropdownMenuItem(
            child: Text(
                "way too long text for a smartphone at least one that goes in a normal sized pair of trousers but maybe not for a gigantic screen like there is one at my cousin's home in a very remote country where I 
wouldn't want to go right now"),
            value:
                "way too long text for a smartphone at least one that goes in a normal sized pair of trousers but maybe not for a gigantic screen like there is one at my cousin's home in a very remote country where I 
wouldn't want to go right now",
          )
        ],
        value: "",
        hint: "Select one",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        dialogBox: true,
        isExpanded: true,
      ),
```
#### Single dialog readOnly
```dart
      HcSearchableDropdown.single(
        items: [
          DropdownMenuItem(
            child: Text(
                "one item"),
            value:
            "one item",
          )
        ],
        value: "one item",
        hint: "Select one",
        searchHint: "Select one",
        disabledHint: "Disabled",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        dialogBox: true,
        isExpanded: true,
        readOnly: true,
      ),
```
#### Single dialog disabled
```dart
      HcSearchableDropdown.single(
        items: [
          DropdownMenuItem(
            child: Text(
                "one item"),
            value:
            "one item",
          )
        ],
        value: "one item",
        hint: "Select one",
        searchHint: "Select one",
        disabledHint: "Disabled",
        onChanged: null,
        dialogBox: true,
        isExpanded: true,
      ),
```

## Image Compression

**Compress Image**

```dart
import 'package:htkc_utils/htkc_utils.dart';
void main() {
  runApp(MaterialApp(home: MainPage()));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  HcConfiguration config = const HcConfiguration();
  ImageFile? image;
  ImageFile? imageOutput;
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    final buttonGallery = ElevatedButton.icon(
      onPressed: handleOpenGallery,
      icon: const Icon(Icons.photo_outlined),
      label: const Text('Pick an Image'),
    );

    final buttonCompress = Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: handleCompressImage,
        icon: const Icon(Icons.compress),
        label: const Text('Compress Image'),
      ),
    );

    Widget body = Center(child: buttonGallery);
    if (image != null) {
      final inputImage = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Image.memory(image!.rawBytes),
      );
      final inputImageSizeType = ListTile(
        title: const Text('Image size-type :'),
        subtitle: Text(
            '${(image!.sizeInBytes / 1024 / 1024).toStringAsFixed(2)} MB - (${image!.width} x ${image!.height})'),
        trailing: Text(image!.extension),
      );
      final inputImageName = ListTile(
        title: const Text('Image name :'),
        subtitle: Text(image!.fileName),
      );

      body = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: buttonGallery,
            ),
            const ListTile(title: Text('INPUT IMAGE')),
            inputImage,
            inputImageSizeType,
            inputImageName,
            const Divider(),
            const ListTile(title: Text('OUTPUT IMAGE')),
            configOutputType,
            configQuality,
            nativeCompressorCheckBox,
            buttonCompress,
            processing
                ? const Padding(
              padding: EdgeInsets.all(16.0),
              child: LinearProgressIndicator(),
            )
                : const SizedBox.shrink(),
            if (imageOutput != null && !processing)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.memory(imageOutput!.rawBytes),
              ),
            if (imageOutput != null && !processing)
              ListTile(
                title: const Text('Image size-type :'),
                subtitle: Text(
                    '${(imageOutput!.sizeInBytes / 1024 / 1024).toStringAsFixed(2)} MB - (${imageOutput!.width} x ${imageOutput!.height})'),
                trailing: Text(imageOutput!.contentType ?? '-'),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Compression'),
      ),
      body: body,
    );
  }

  Widget get nativeCompressorCheckBox {
    return CheckboxListTile(
      title: const Text('Native compressor for JPG/PNG'),
      value: config.useJpgPngNativeCompressor,
      onChanged: (flag) {
        setState(() {
          config = HcConfiguration(
            outputType: config.outputType,
            useJpgPngNativeCompressor: flag ?? false,
            quality: config.quality,
          );
        });
      },
    );
  }

  Widget get configOutputType {
    return ListTile(
      title: const Text('Select output type'),
      subtitle: Text(config.outputType.toString()),
      trailing: PopupMenuButton<HcImageOutputType>(
        itemBuilder: (context) {
          return HcImageOutputType.values
              .map((e) => PopupMenuItem(
            child: Text(e.toString()),
            value: e,
          ))
              .toList();
        },
        onSelected: (outputType) {
          setState(() {
            config = HcConfiguration(
              outputType: outputType,
              useJpgPngNativeCompressor: config.useJpgPngNativeCompressor,
              quality: config.quality,
            );
          });
        },
      ),
    );
  }

  Widget get configQuality {
    return ListTile(
      title: Text('Select quality (${config.quality})'),
      subtitle: Slider.adaptive(
        value: config.quality.toDouble(),
        divisions: 100,
        min: 0,
        max: 100,
        label: config.quality.toString(),
        onChanged: (value) {
          setState(() {
            config = HcConfiguration(
              outputType: config.outputType,
              useJpgPngNativeCompressor: config.useJpgPngNativeCompressor,
              quality: value.toInt(),
            );
          });
        },
      ),
    );
  }

  handleOpenGallery() async {
    final xFile = await flimer.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      final image = await xFile.asImageFile;
      setState(() {
        this.image = image;
      });
    }
  }

  handleCompressImage() async {
    setState(() {
      processing = true;
    });
    final param = ImageFileConfiguration(input: image!, config: config);
    final output = await compressor.compress(param);

    setState(() {
      imageOutput = output;
      processing = false;
    });
  }
}
```


## Custom Alert Dialog

**Alert Dialog**


```dart

showNewDialog(
context: context,
builder: (context) => const ChangePswDialog());
```

## OTP Text Field

**OTP Field**

```dart
import 'package:flimer/flimer.dart';
import 'package:htkc_utils/htkc_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Credit Card Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Awesome Credit Card Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cleaning_services),
        onPressed: () {
          print("Floating button was pressed.");
          otpController.clear();
          // otpController.set(['2', '3', '5', '5', '7']);
          // otpController.setValue('3', 0);
          // otpController.setFocus(1);
        },
      ),
      body: Center(
        child: HcOTPTextField(
            controller: otpController,
            length: 5,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: TextStyle(fontSize: 17),
            onChanged: (pin) {
              print("Changed: " + pin);
            },
            onCompleted: (pin) {
              print("Completed: " + pin);
            }),
      ),
    );
  }
}
```


## Emergent Text

**Text only handle positive depth**

```dart
child: EmergentText('I love flutter',
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
child: Emergent(
    style: EmergentStyle(
      boxShape: EmergentBoxShape.path(MyShapePathProvider()),
    ),
...
),
```

You can import the Flutter logo as a custom shape using

```dart
child: Emergent(
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
child: Emergent(
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

You can use directly in your project a `EmergentApp`, surrounding your code

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

# System Utils

You can use directly in your project a `hcSetStatusBarColor`, inside `build(BuildContext context)`,
and `hcFinish(context)` to pop Context.

```dart

@override
Widget build(BuildContext context) {
  hcSetStatusBarColor(Colors.blue);
  return Scaffold(
  ...
  onPressed: () { hcFinish(context); }
  ...
```

# Flutter Chat UI

```dart
Chat(
    messages: _messages,
    onAttachmentPressed: _handleAttachmentPressed,
    onMessageTap: _handleMessageTap,
    onPreviewDataFetched: _handlePreviewDataFetched,
    onSendPressed: _handleSendPressed,
    showUserAvatars: true,
    showUserNames: true,
user: _user,
),
```