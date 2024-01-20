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

## New Version Upgrade Dialog

```dart

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Instantiate NewVersion manager object (Using GCP Console app as example)
    final newVersion = HcUpgradeVersion(
      iOSId: 'com.google.Vespa',
      androidId: 'com.google.android.apps.cloudconsole',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    }
  }

  basicStatusCheck(HcUpgradeVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(HcUpgradeVersion newVersion) async {
    final status = await newVersion.getHcNewVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Custom Title',
        dialogText: 'Custom Text',
      );
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EmergentApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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

## Dropdown Search

```dart
import 'package:example/dropdown_search/user_model.dart';
import 'package:htkc_utils/dropdown_search/hc_dropdown_search_form_field.dart';
import 'package:htkc_utils/htkc_utils.dart';
import 'package:dio/dio.dart';

class HcAdvanceExample extends StatefulWidget {
  final List<String> suggestions;

  HcAdvanceExample({required this.suggestions});

  @override
  _HcAdvanceExampleState createState() => _HcAdvanceExampleState();
}

class _HcAdvanceExampleState extends State<HcAdvanceExample> {
  final _formKey = GlobalKey<FormState>();
  final _openDropDownProgKey = GlobalKey<HcDropdownSearchState<int>>();
  final _multiKey = GlobalKey<HcDropdownSearchState<String>>();
  final _popupBuilderKey = GlobalKey<HcDropdownSearchState<String>>();
  final _popupCustomValidationKey = GlobalKey<HcDropdownSearchState<int>>();
  final _userEditTextController = TextEditingController(text: 'Mrs');
  final myKey = GlobalKey<HcDropdownSearchState<MultiLevelString>>();
  final List<MultiLevelString> myItems = [
    MultiLevelString(level1: "1"),
    MultiLevelString(level1: "2"),
    MultiLevelString(
      level1: "3",
      subLevel: [
        MultiLevelString(level1: "sub3-1"),
        MultiLevelString(level1: "sub3-2"),
      ],
    ),
    MultiLevelString(level1: "4")
  ];
  bool? _popupBuilderSelection = false;

  @override
  Widget build(BuildContext context) {
    void _handleCheckBoxState({bool updateState = true}) {
      var selectedItem = _popupBuilderKey.currentState?.popupGetSelectedItems ?? [];
      var isAllSelected = _popupBuilderKey.currentState?.popupIsAllItemSelected ?? false;
      _popupBuilderSelection = selectedItem.isEmpty ? false : (isAllSelected ? true : null);

      if (updateState) setState(() {});
    }

    _handleCheckBoxState(updateState: false);

    return Scaffold(
      appBar: AppBar(title: Text("DropdownSearch Demo")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.all(4),
            children: <Widget>[
              ///************************[simple examples for single and multi selection]************///
              Text("[simple examples for single and multi selection]"),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: [1, 2, 3, 4, 5, 6, 7],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<int>.multiSelection(
                      clearButtonProps: HcClearButtonProps(isVisible: true),
                      items: [1, 2, 3, 4, 5, 6, 7],
                    ),
                  )
                ],
              ),

              ///************************[simple examples for each mode]*************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[simple examples for each mode]"),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: [1, 2, 3, 4, 5, 6, 7],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<int>.multiSelection(
                      key: _popupCustomValidationKey,
                      items: [1, 2, 3, 4, 5, 6, 7],
                      popupProps: HcPopupPropsMultiSelection.dialog(
                        validationWidgetBuilder: (ctx, selectedItems) {
                          return Container(
                            color: Colors.blue[200],
                            height: 56,
                            child: Align(
                              alignment: Alignment.center,
                              child: MaterialButton(
                                child: Text('OK'),
                                onPressed: () {
                                  _popupCustomValidationKey.currentState?.popupOnValidate();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(4)),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: [1, 2, 3, 4, 5, 6, 7],
                      dropdownDecoratorProps: HcDropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "BottomSheet mode",
                          hintText: "Select an Int",
                        ),
                      ),
                      popupProps: PopupProps.bottomSheet(
                          bottomSheetProps: BottomSheetProps(elevation: 16, backgroundColor: Color(0xFFAADCEE))),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: [1, 2, 3, 4, 5, 6, 7],
                      dropdownDecoratorProps: HcDropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Modal mode",
                          hintText: "Select an Int",
                          filled: true,
                        ),
                      ),
                      popupProps: HcPopupPropsMultiSelection.modalBottomSheet(
                        disabledItemFn: (int i) => i <= 3,
                      ),
                    ),
                  )
                ],
              ),

              ///************************[Favorites examples]**********************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[Favorites examples]"),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<UserModel>(
                      asyncItems: (filter) => getData(filter),
                      compareFn: (i, s) => i.isEqual(s),
                      popupProps: HcPopupPropsMultiSelection.modalBottomSheet(
                        isFilterOnline: true,
                        showSelectedItems: true,
                        showSearchBox: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        favoriteItemProps: FavoriteItemProps(
                          showFavoriteItems: true,
                          favoriteItems: (us) {
                            return us.where((e) => e.name.contains("Mrs")).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<UserModel>.multiSelection(
                      asyncItems: (filter) => getData(filter),
                      compareFn: (i, s) => i.isEqual(s),
                      popupProps: HcPopupPropsMultiSelection.modalBottomSheet(
                        showSearchBox: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        favoriteItemProps: FavoriteItemProps(
                          showFavoriteItems: true,
                          favoriteItems: (us) {
                            return us.where((e) => e.name.contains("Mrs")).toList();
                          },
                          favoriteItemBuilder: (context, item, isSelected) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]),
                              child: Row(
                                children: [
                                  Text(
                                    "${item.name}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  isSelected ? Icon(Icons.check_box_outlined) : SizedBox.shrink(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///************************[validation examples]********************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[validation examples]"),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: [1, 2, 3, 4, 5, 6, 7],
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (int? i) {
                        if (i == null)
                          return 'required filed';
                        else if (i >= 5) return 'value should be < 5';
                        return null;
                      },
                      clearButtonProps: HcClearButtonProps(isVisible: true),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<int>.multiSelection(
                      items: [1, 2, 3, 4, 5, 6, 7],
                      validator: (List<int>? items) {
                        if (items == null || items.isEmpty)
                          return 'required filed';
                        else if (items.length > 3) return 'only 1 to 3 items are allowed';
                        return null;
                      },
                    ),
                  )
                ],
              ),

              ///************************[custom popup background examples]********************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[custom popup background examples]"),
              Divider(),
              HcDropdownSearch<String>(
                items: List.generate(5, (index) => "$index"),
                popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  containerBuilder: (ctx, popupWidget) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Image.asset(
                            'assets/images/arrow-up.png',
                            color: Color(0xFF2F772A),
                            height: 12,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: popupWidget,
                            color: Color(0xFF2F772A),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<String>.multiSelection(
                      key: _popupBuilderKey,
                      items: List.generate(30, (index) => "$index"),
                      popupProps: HcPopupPropsMultiSelection.dialog(
                        onItemAdded: (l, s) => _handleCheckBoxState(),
                        onItemRemoved: (l, s) => _handleCheckBoxState(),
                        showSearchBox: true,
                        containerBuilder: (ctx, popupWidget) {
                          return _CheckBoxWidget(
                            child: popupWidget,
                            isSelected: _popupBuilderSelection,
                            onChanged: (v) {
                              if (v == true)
                                _popupBuilderKey.currentState!.popupSelectAllItems();
                              else if (v == false) _popupBuilderKey.currentState!.popupDeselectAllItems();
                              _handleCheckBoxState();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<String>.multiSelection(
                      key: _multiKey,
                      items: List.generate(30, (index) => "$index"),
                      popupProps: HcPopupPropsMultiSelection.dialog(
                        onItemAdded: (l, s) => _handleCheckBoxState(),
                        onItemRemoved: (l, s) => _handleCheckBoxState(),
                        showSearchBox: true,
                        containerBuilder: (ctx, popupWidget) {
                          return Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // How should I unselect all items in the list?
                                        _multiKey.currentState?.closeDropDownSearch();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // How should I select all items in the list?
                                        _multiKey.currentState?.popupSelectAllItems();
                                      },
                                      child: const Text('All'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // How should I unselect all items in the list?
                                        _multiKey.currentState?.popupDeselectAllItems();
                                      },
                                      child: const Text('None'),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: popupWidget),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              ///************************[dropdownBuilder examples]********************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[DropDownSearch builder examples]"),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<UserModel>.multiSelection(
                      asyncItems: (String? filter) => getData(filter),
                      clearButtonProps: HcClearButtonProps(isVisible: true),
                      popupProps: HcPopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        isFilterOnline: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          controller: _userEditTextController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _userEditTextController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                      compareFn: (item, selectedItem) => item.id == selectedItem.id,
                      dropdownDecoratorProps: HcDropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Users *',
                          filled: true,
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                        ),
                      ),
                      dropdownBuilder: _customDropDownExampleMultiSelection,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<UserModel>(
                      asyncItems: (String? filter) => getData(filter),
                      popupProps: HcPopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        showSearchBox: true,
                      ),
                      compareFn: (item, sItem) => item.id == sItem.id,
                      dropdownDecoratorProps: HcDropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'User *',
                          filled: true,
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///************************[Dynamic height depending on items number]********************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[popup dynamic height examples]"),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: List.generate(50, (i) => i),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        title: Text('default fit'),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: List.generate(50, (i) => i),
                      popupProps: PopupProps.menu(
                        title: Text('With fit to loose and no constraints'),
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(4)),
              Row(
                children: [
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: List.generate(50, (i) => i),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        title: Text('fit to a specific max height'),
                        constraints: BoxConstraints(maxHeight: 300),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Expanded(
                    child: HcDropdownSearch<int>(
                      items: List.generate(50, (i) => i),
                      popupProps: PopupProps.menu(
                        title: Text('fit to a specific width and height'),
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        constraints: BoxConstraints.tightFor(
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                  )
                ],
              ),

              ///************************[Handle dropdown programmatically]********************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[handle dropdown programmatically]"),
              Divider(),
              HcDropdownSearch<int>(
                key: _openDropDownProgKey,
                items: [1, 2, 3],
              ),
              Padding(padding: EdgeInsets.all(4)),
              ElevatedButton(
                onPressed: () {
                  _openDropDownProgKey.currentState?.changeSelectedItem(100);
                },
                child: Text('set to 100'),
              ),
              Padding(padding: EdgeInsets.all(4)),
              ElevatedButton(
                onPressed: () {
                  _openDropDownProgKey.currentState?.openDropDownSearch();
                },
                child: Text('open popup'),
              ),

              ///************************[multiLevel items example]********************************///
              Padding(padding: EdgeInsets.all(8)),
              Text("[multiLevel items example]"),
              Divider(),
              HcDropdownSearch<MultiLevelString>(
                key: myKey,
                items: myItems,
                compareFn: (i1, i2) => i1.level1 == i2.level1,
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  interceptCallBacks: true, //important line
                  itemBuilder: (ctx, item, isSelected) {
                    return ListTile(
                      selected: isSelected,
                      title: Text(item.level1),
                      trailing: item.subLevel.isEmpty
                          ? null
                          : (item.isExpanded
                          ? IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          item.isExpanded = !item.isExpanded;
                          myKey.currentState?.updatePopupState();
                        },
                      )
                          : IconButton(
                        icon: Icon(Icons.arrow_right),
                        onPressed: () {
                          item.isExpanded = !item.isExpanded;
                          myKey.currentState?.updatePopupState();
                        },
                      )),
                      subtitle: item.subLevel.isNotEmpty && item.isExpanded
                          ? Container(
                        height: item.subLevel.length * 50,
                        child: ListView(
                          children: item.subLevel
                              .map(
                                (e) => ListTile(
                              selected: myKey.currentState?.getSelectedItem?.level1 == e.level1,
                              title: Text(e.level1),
                              onTap: () {
                                myKey.currentState?.popupValidate([e]);
                              },
                            ),
                          )
                              .toList(),
                        ),
                      )
                          : null,
                      onTap: () => myKey.currentState?.popupValidate([item]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customDropDownExampleMultiSelection(BuildContext context, List<UserModel> selectedItems) {
    if (selectedItems.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(),
        title: Text("No item selected"),
      );
    }

    return Wrap(
      children: selectedItems.map((e) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(e.avatar),
              ),
              title: Text(e.name),
              subtitle: Text(
                e.createdAt.toString(),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _customPopupItemBuilderExample2(BuildContext context, UserModel item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
        subtitle: Text(item.createdAt.toString()),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.avatar),
        ),
      ),
    );
  }

  Future<List<UserModel>> getData(filter) async {
    var response = await Dio().get(
      "https://63c1210999c0a15d28e1ec1d.mockapi.io/users",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}

class _CheckBoxWidget extends StatefulWidget {
  final Widget child;
  final bool? isSelected;
  final ValueChanged<bool?>? onChanged;

  _CheckBoxWidget({required this.child, this.isSelected, this.onChanged});

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<_CheckBoxWidget> {
  bool? isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant _CheckBoxWidget oldWidget) {
    if (widget.isSelected != isSelected) isSelected = widget.isSelected;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0x88F44336),
            Colors.blue,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Select: '),
              Checkbox(
                  value: isSelected,
                  tristate: true,
                  onChanged: (bool? v) {
                    if (v == null) v = false;
                    setState(() {
                      isSelected = v;
                      if (widget.onChanged != null) widget.onChanged!(v);
                    });
                  }),
            ],
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

class MultiLevelString {
  final String level1;
  final List<MultiLevelString> subLevel;
  bool isExpanded;

  MultiLevelString({
    this.level1 = "",
    this.subLevel = const [],
    this.isExpanded = false,
  });

  MultiLevelString copy({
    String? level1,
    List<MultiLevelString>? subLevel,
    bool? isExpanded,
  }) =>
      MultiLevelString(
        level1: level1 ?? this.level1,
        subLevel: subLevel ?? this.subLevel,
        isExpanded: isExpanded ?? this.isExpanded,
      );

  @override
  String toString() => level1;
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
HcDottedBorder(
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

HcDottedBorder(
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