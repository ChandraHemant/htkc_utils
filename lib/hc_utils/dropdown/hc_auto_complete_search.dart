import 'package:htkc_utils/htkc_utils.dart';

const EdgeInsetsGeometry _hcAlignedButtonPadding =
    EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _hcUnalignedButtonPadding = EdgeInsets.zero;

class NotGiven {
  const NotGiven();
}

class PointerThisPlease<T> {
  T value;
  PointerThisPlease(this.value);
}

Widget prepareWidget(dynamic object,
    {dynamic parameter = const NotGiven(),
    BuildContext? context,
    Function? stringToWidgetFunction}) {
  if (object == null) {
    return (object);
  }
  if (object is Widget) {
    return (object);
  }
  if (object is String) {
    if (stringToWidgetFunction == null) {
      return (Text(object));
    } else {
      return (stringToWidgetFunction(object));
    }
  }
  if (object is Function) {
    if (parameter is NotGiven) {
      if (context == null) {
        return (prepareWidget(object(),
            stringToWidgetFunction: stringToWidgetFunction));
      } else {
        return (prepareWidget(object(context),
            stringToWidgetFunction: stringToWidgetFunction));
      }
    }
    if (context == null) {
      return (prepareWidget(object(parameter),
          stringToWidgetFunction: stringToWidgetFunction));
    }
    return (prepareWidget(object(parameter, context),
        stringToWidgetFunction: stringToWidgetFunction));
  }
  return (Text("Unknown type: ${object.runtimeType.toString()}"));
}

class HcSearchableDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final Function onChanged;
  final T? value;
  final TextStyle? style;
  final dynamic searchHint;
  final dynamic hint;
  final dynamic disabledHint;
  final dynamic icon;
  final dynamic underline;
  final dynamic doneButton;
  final dynamic label;
  final dynamic closeButton;
  final bool displayClearIcon;
  final Icon clearIcon;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double iconSize;
  final bool isExpanded;
  final bool isCaseSensitiveSearch;
  final Function? searchFn;
  final Function? onClear;
  final Function? selectedValueWidgetFn;
  final TextInputType keyboardType;
  final Function? validator;
  final bool multipleSelection;
  final List<int> selectedItems;
  final Function? displayItem;
  final bool dialogBox;
  final BoxConstraints? menuConstraints;
  final bool readOnly;
  final Color? menuBackgroundColor;

  /// Search choices Widget with a single choice that opens a dialog or a menu to let the user do the selection conveniently with a search.
  ///
  /// @param items with __child__: [Widget] displayed ; __value__: any object with .toString() used to match search keyword.
  /// @param onChanged [Function] with parameter: __value__ not returning executed after the selection is done.
  /// @param value value to be preselected.
  /// @param style used for the hint if it is given is [String].
  /// @param searchHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param hint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed before any value is selected or after the selection is cleared.
  /// @param disabledHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// @param icon [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed next to the selected item or the hint if none.
  /// @param underline [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed below the selected item or the hint if none.
  /// @param doneButton [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param label [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed above the selected item or the hint if none.
  /// @param closeButton [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed at the bottom of the search dialog box.
  /// @param displayClearIcon whether or not to display an icon to clear the selected value.
  /// @param clearIcon [Icon] to be used for clearing the selected value.
  /// @param iconEnabledColor [Color] to be used for enabled icons.
  /// @param iconDisabledColor [Color] to be used for disabled icons.
  /// @param iconSize for the icons next to the selected value (icon and clearIcon).
  /// @param isExpanded can be necessary to avoid pixel overflows (zebra symptom).
  /// @param isCaseSensitiveSearch only used when searchFn is not specified.
  /// @param searchFn [Function] with parameters: __keyword__, __items__ returning [List<int>] as the list of indexes for the items to be displayed.
  /// @param onClear [Function] with no parameter not returning executed when the clear icon is tapped.
  /// @param selectedValueWidgetFn [Function] with parameter: __item__ returning [Widget] to be used to display the selected value.
  /// @param keyboardType used for the search.
  /// @param validator [Function] with parameter: __value__ returning [String] displayed below selected value when not valid and null when valid.
  /// @param assertUniqueValue whether to run a consistency check of the list of items.
  /// @param displayItem [Function] with parameters: __item__, __selected__ returning [Widget] to be displayed in the search list.
  /// @param dialogBox whether the search should be displayed as a dialog box or as a menu below the selected value if any.
  /// @param menuConstraints [BoxConstraints] used to define the zone where to display the search menu. Example: BoxConstraints.tight(Size.fromHeight(250)) . Not to be used for dialogBox = true.
  /// @param readOnly [bool] whether to let the user choose the value to select or just present the selected value if any.
  /// @param menuBackgroundColor [Color] background color of the menu whether in dialog box or menu mode.
  factory HcSearchableDropdown.single({
    Key? key,
    required List<DropdownMenuItem<T>> items,
    Function? onChanged,
    required T value,
    TextStyle? style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton,
    dynamic label,
    dynamic closeButton = "Close",
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color? iconEnabledColor,
    Color? iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    bool isCaseSensitiveSearch = false,
    Function? searchFn,
    Function? onClear,
    Function? selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    Function? validator,
    bool assertUniqueValue = true,
    Function? displayItem,
    bool dialogBox = true,
    BoxConstraints? menuConstraints,
    bool readOnly = false,
    Color? menuBackgroundColor,
  }) {
    return (HcSearchableDropdown._(
      key: key!,
      items: items,
      onChanged: onChanged!,
      value: value,
      style: style!,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor!,
      iconDisabledColor: iconDisabledColor!,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear!,
      selectedValueWidgetFn: selectedValueWidgetFn,
      keyboardType: keyboardType,
      validator: validator,
      label: label,
      searchFn: searchFn!,
      multipleSelection: false,
      doneButton: doneButton,
      displayItem: displayItem!,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints!,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor!,
    ));
  }

  /// Search choices Widget with a multiple choice that opens a dialog or a menu to let the user do the selection conveniently with a search.
  ///
  /// @param items with __child__: [Widget] displayed ; __value__: any object with .toString() used to match search keyword.
  /// @param onChanged [Function] with parameter: __selectedItems__ not returning executed after the selection is done.
  /// @param selectedItems indexes of items to be preselected.
  /// @param style used for the hint if it is given is [String].
  /// @param searchHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param hint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed before any value is selected or after the selection is cleared.
  /// @param disabledHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// @param icon [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed next to the selected items or the hint if none.
  /// @param underline [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed below the selected items or the hint if none.
  /// @param doneButton [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed at the top of the search dialog box. Cannot be null in multiple selection mode.
  /// @param label [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed above the selected items or the hint if none.
  /// @param closeButton [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed at the bottom of the search dialog box.
  /// @param displayClearIcon whether or not to display an icon to clear the selected values.
  /// @param clearIcon [Icon] to be used for clearing the selected values.
  /// @param iconEnabledColor [Color] to be used for enabled icons.
  /// @param iconDisabledColor [Color] to be used for disabled icons.
  /// @param iconSize for the icons next to the selected values (icon and clearIcon).
  /// @param isExpanded can be necessary to avoid pixel overflows (zebra symptom).
  /// @param isCaseSensitiveSearch only used when searchFn is not specified.
  /// @param searchFn [Function] with parameters: __keyword__, __items__ returning [List<int>] as the list of indexes for the items to be displayed.
  /// @param onClear [Function] with no parameter not returning executed when the clear icon is tapped.
  /// @param selectedValueWidgetFn [Function] with parameter: __item__ returning [Widget] to be used to display the selected values.
  /// @param keyboardType used for the search.
  /// @param validator [Function] with parameter: __selectedItems__ returning [String] displayed below selected values when not valid and null when valid.
  /// @param displayItem [Function] with parameters: __item__, __selected__ returning [Widget] to be displayed in the search list.
  /// @param dialogBox whether the search should be displayed as a dialog box or as a menu below the selected values if any.
  /// @param menuConstraints [BoxConstraints] used to define the zone where to display the search menu. Example: BoxConstraints.tight(Size.fromHeight(250)) . Not to be used for dialogBox = true.
  /// @param readOnly [bool] whether to let the user choose the value to select or just present the selected value if any.
  /// @param menuBackgroundColor [Color] background color of the menu whether in dialog box or menu mode.
  factory HcSearchableDropdown.multiple({
    Key? key,
    required List<DropdownMenuItem<T>> items,
    required Function onChanged,
    T? value,
    TextStyle? style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton,
    dynamic label,
    dynamic closeButton = "Close",
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color? iconEnabledColor,
    Color? iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    List<int> selectedItems = const [],
    bool isCaseSensitiveSearch = false,
    Function? searchFn,
    Function? onClear,
    Function? selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    Function? validator,
    bool assertUniqueValue = true,
    Function? displayItem,
    bool dialogBox = true,
    BoxConstraints? menuConstraints,
    bool readOnly = false,
    Color? menuBackgroundColor,
  }) {
    return (HcSearchableDropdown._(
      key: key!,
      items: items,
      style: style!,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor!,
      iconDisabledColor: iconDisabledColor!,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear!,
      selectedValueWidgetFn: selectedValueWidgetFn,
      keyboardType: keyboardType,
      validator: validator,
      label: label,
      searchFn: searchFn!,
      multipleSelection: true,
      selectedItems: selectedItems,
      doneButton: doneButton,
      onChanged: onChanged,
      displayItem: displayItem!,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints!,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor!,
      value: value,
    ));
  }

  const HcSearchableDropdown._({
    Key? key,
    this.items,
    required this.onChanged,
    required this.value,
    required this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon,
    this.underline,
    required this.iconEnabledColor,
    required this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.closeButton,
    this.displayClearIcon = true,
    this.clearIcon = const Icon(Icons.clear),
    required this.onClear,
    required this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.label,
    required this.searchFn,
    this.multipleSelection = false,
    this.selectedItems = const [],
    this.doneButton,
    required this.displayItem,
    required this.dialogBox,
    required this.menuConstraints,
    this.readOnly = false,
    required this.menuBackgroundColor,
  })  : assert(items != null),
        assert(!multipleSelection || doneButton != null),
        assert(!dialogBox),
        super(key: key);

  const HcSearchableDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.value,
    this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon = const Icon(Icons.arrow_drop_down),
    this.underline,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.closeButton = "Close",
    this.displayClearIcon = false,
    this.clearIcon = const Icon(Icons.clear),
    this.onClear,
    this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.label,
    this.searchFn,
    this.multipleSelection = false,
    this.selectedItems = const [],
    this.doneButton,
    this.displayItem,
    this.dialogBox = true,
    this.menuConstraints,
    this.readOnly = false,
    this.menuBackgroundColor,
  })  : assert(items != null),
        assert(!multipleSelection || doneButton != null),
        assert(!dialogBox),
        super(key: key);

  @override
  HcSearchableDropdownState<T> createState() => HcSearchableDropdownState();
}

class HcSearchableDropdownState<T> extends State<HcSearchableDropdown<T>> {
  List<int>? selectedItems;
  PointerThisPlease<bool> displayMenu = PointerThisPlease<bool>(false);

  TextStyle get _textStyle => widget.style!;
  bool get _enabled => widget.items != null && widget.items!.isNotEmpty;

  Color get _enabledIconColor {
    return widget.iconEnabledColor!;
  }

  Color get _disabledIconColor {
    return widget.iconDisabledColor!;
  }

  Color get _iconColor {
    // These colors are not defined in the Material Design spec.
    return (_enabled && !(widget.readOnly)
        ? _enabledIconColor
        : _disabledIconColor);
  }

  bool get valid {
    if (widget.validator == null) {
      return (true);
    }
    return (widget.validator!(selectedResult) == null);
  }

  bool get hasSelection {
    return (selectedItems != null && selectedItems!.isNotEmpty);
  }

  dynamic get selectedResult {
    return (widget.multipleSelection
        ? selectedItems
        : selectedItems?.isNotEmpty ?? false
            ? widget.items![selectedItems!.first].value
            : null);
  }

  int indexFromValue(T value) {
    return (widget.items!.indexWhere((item) {
      return (item.value == value);
    }));
  }

  @override
  void initState() {
    _updateSelectedIndex();
    super.initState();
  }

  void _updateSelectedIndex() {
    if (!_enabled) {
      return;
    }
    if (widget.multipleSelection) {
      selectedItems = List<int>.from(widget.selectedItems);
    } else if (widget.value != null) {
      int i = indexFromValue(widget.value as T);
      if (i != -1) {
        selectedItems = [i];
      }
    }
    selectedItems ??= [];
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedIndex();
  }

  Widget get menuWidget {
    return (DropdownDialog(
      items: widget.items!,
      hint: prepareWidget(widget.searchHint),
      isCaseSensitiveSearch: widget.isCaseSensitiveSearch,
      closeButton: widget.closeButton,
      keyboardType: widget.keyboardType,
      searchFn: widget.searchFn,
      multipleSelection: widget.multipleSelection,
      selectedItems: selectedItems!,
      doneButton: widget.doneButton,
      displayItem: widget.displayItem,
      validator: widget.validator!,
      dialogBox: widget.dialogBox,
      displayMenu: displayMenu,
      menuConstraints: widget.menuConstraints!,
      menuBackgroundColor: widget.menuBackgroundColor!,
      callOnPop: () {
        if (!widget.dialogBox && selectedItems != null) {
          widget.onChanged(selectedResult);
        }
        setState(() {});
      },
    ));
  }

  int? hintIndex;
  @override
  Widget build(BuildContext context) {
    final List<Widget> items =
        _enabled ? List<Widget>.from(widget.items!) : <Widget>[];
    if (widget.hint != null || (!_enabled)) {
      final Widget emplaceHint = _enabled
          ? prepareWidget(widget.hint)
          : DropdownMenuItem<Widget>(child: prepareWidget(widget.disabledHint));
      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          ignoringSemantics: false,
          child: emplaceHint,
        ),
      ));
    }
    Widget innerItemsWidget;
    List<Widget> list = List<Widget>.empty();
    selectedItems?.forEach((item) {
      list.add(widget.selectedValueWidgetFn != null
          ? widget.selectedValueWidgetFn!(widget.items![item].value)
          : items[item]);
    });
    if (list.isEmpty && hintIndex != null) {
      innerItemsWidget = items[hintIndex!];
    } else {
      innerItemsWidget = Column(
        children: list,
      );
    }
    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _hcAlignedButtonPadding
        : _hcUnalignedButtonPadding;

    Widget clickable = InkWell(
        key: const Key(
            "clickableResultPlaceHolder"), //this key is used for running automated tests
        onTap: (widget.readOnly) || !_enabled
            ? null
            : () async {
                if (widget.dialogBox) {
                  await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return (menuWidget);
                      });
                  if (selectedItems != null) {
                    widget.onChanged(selectedResult);
                  }
                } else {
                  displayMenu.value = true;
                }
                setState(() {});
              },
        child: Row(
          children: <Widget>[
            widget.isExpanded
                ? Expanded(child: innerItemsWidget)
                : innerItemsWidget,
            IconTheme(
              data: IconThemeData(
                color: _iconColor,
                size: widget.iconSize,
              ),
              child: prepareWidget(widget.icon, parameter: selectedResult),
            ),
          ],
        ));

    Widget result = DefaultTextStyle(
      style: _textStyle,
      child: Container(
        padding: padding.resolve(Directionality.of(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.isExpanded ? Expanded(child: clickable) : clickable,
            !widget.displayClearIcon
                ? const SizedBox()
                : InkWell(
                    onTap: hasSelection && _enabled && !widget.readOnly
                        ? () {
                            clearSelection();
                          }
                        : null,
                    child: Container(
                      padding: padding.resolve(Directionality.of(context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconTheme(
                            data: IconThemeData(
                              color:
                                  hasSelection && _enabled && !widget.readOnly
                                      ? _enabledIconColor
                                      : _disabledIconColor,
                              size: widget.iconSize,
                            ),
                            child: widget.clearIcon,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );

    const double bottom = 8.0;
    var validatorOutput = widget.validator!(selectedResult);
    var labelOutput = prepareWidget(widget.label, parameter: selectedResult,
        stringToWidgetFunction: (string) {
      return (Text(string,
          style: const TextStyle(color: Colors.blueAccent, fontSize: 13)));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        labelOutput,
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: result,
            ),
            widget.underline is NotGiven
                ? const SizedBox.shrink()
                : Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: bottom,
                    child: prepareWidget(widget.underline,
                        parameter: selectedResult),
                  ),
          ],
        ),
        valid
            ? const SizedBox.shrink()
            : validatorOutput is String
                ? Text(
                    validatorOutput,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  )
                : validatorOutput,
        displayMenu.value ? menuWidget : const SizedBox.shrink(),
      ],
    );
  }

  clearSelection() {
    selectedItems!.clear();
    widget.onChanged(selectedResult);
    widget.onClear!();
    setState(() {});
  }
}

class DropdownDialog<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final Widget? hint;
  final bool isCaseSensitiveSearch;
  final dynamic closeButton;
  final TextInputType keyboardType;
  final Function? searchFn;
  final bool multipleSelection;
  final List<int> selectedItems;
  final Function? displayItem;
  final dynamic doneButton;
  final Function? validator;
  final bool dialogBox;
  final PointerThisPlease<bool> displayMenu;
  final BoxConstraints menuConstraints;
  final Function callOnPop;
  final Color menuBackgroundColor;

  const DropdownDialog({
    Key? key,
    required this.items,
    this.hint,
    this.isCaseSensitiveSearch = false,
    this.closeButton,
    required this.keyboardType,
    this.searchFn,
    required this.multipleSelection,
    required this.selectedItems,
    this.displayItem,
    this.doneButton,
    this.validator,
    required this.dialogBox,
    required this.displayMenu,
    required this.menuConstraints,
    required this.callOnPop,
    required this.menuBackgroundColor,
  }) : super(key: key);

  @override
  DropdownDialogState<T> createState() => DropdownDialogState<T>();
}

class DropdownDialogState<T> extends State<DropdownDialog> {
  TextEditingController txtSearch = TextEditingController();
  TextStyle defaultButtonStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  List<int> shownIndexes = [];
  Function? searchFn;

  dynamic get selectedResult {
    return (widget.multipleSelection
        ? widget.selectedItems
        : widget.selectedItems.isNotEmpty
            ? widget.items[widget.selectedItems.first].value
            : null);
  }

  void _updateShownIndexes(String keyword) {
    shownIndexes = searchFn!(keyword, widget.items);
  }

  @override
  void initState() {
    if (widget.searchFn != null) {
      searchFn = widget.searchFn;
    } else {
      Function matchFn;
      if (widget.isCaseSensitiveSearch) {
        matchFn = (item, keyword) {
          return (item.value.toString().contains(keyword));
        };
      } else {
        matchFn = (item, keyword) {
          return (item.value
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()));
        };
      }
      searchFn = (keyword, items) {
        List<int> shownIndexes = [];
        int i = 0;
        for (var item in widget.items) {
          if (matchFn(item, keyword) || (keyword?.isEmpty ?? true)) {
            shownIndexes.add(i);
          }
          i++;
        }
        return (shownIndexes);
      };
    }
    assert(searchFn != null);
    _updateShownIndexes('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 300),
      child: Card(
        color: widget.menuBackgroundColor,
        margin: EdgeInsets.symmetric(
            vertical: widget.dialogBox ? 10 : 5,
            horizontal: widget.dialogBox ? 10 : 4),
        child: Container(
          constraints: widget.menuConstraints,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              titleBar(),
              searchBar(),
              list(),
              closeButtonWrapper(),
            ],
          ),
        ),
      ),
    );
  }

  bool get valid {
    if (widget.validator == null) {
      return (true);
    }
    return (widget.validator!(selectedResult) == null);
  }

  Widget titleBar() {
    var validatorOutput = widget.validator!(selectedResult);

    Widget validatorOutputWidget = valid
        ? const SizedBox.shrink()
        : validatorOutput is String
            ? Text(
                validatorOutput,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              )
            : validatorOutput;

    Widget doneButtonWidget =
        widget.multipleSelection || widget.doneButton != null
            ? prepareWidget(widget.doneButton,
                parameter: selectedResult,
                context: context, stringToWidgetFunction: (string) {
                return (ElevatedButton.icon(
                    onPressed: !valid
                        ? null
                        : () {
                            pop();
                            setState(() {});
                          },
                    icon: const Icon(Icons.close),
                    label: Text(string)));
              })
            : const SizedBox.shrink();
    return widget.hint != null
        ? Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  prepareWidget(widget.hint),
                  Column(
                    children: <Widget>[doneButtonWidget, validatorOutputWidget],
                  ),
                ]),
          )
        : Column(
            children: <Widget>[doneButtonWidget, validatorOutputWidget],
          );
  }

  Widget searchBar() {
    return Stack(
      children: <Widget>[
        TextField(
          controller: txtSearch,
          decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
          autofocus: true,
          onChanged: (value) {
            _updateShownIndexes(value);
            setState(() {});
          },
          keyboardType: widget.keyboardType,
        ),
        const Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: Icon(
              Icons.search,
              size: 24,
            ),
          ),
        ),
        txtSearch.text.isNotEmpty
            ? Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      _updateShownIndexes('');
                      setState(() {
                        txtSearch.text = '';
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    child: const SizedBox(
                      width: 32,
                      height: 32,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  pop() {
    if (widget.dialogBox) {
      Navigator.pop(context);
    } else {
      widget.displayMenu.value = false;
      widget.callOnPop();
    }
  }

  Widget list() {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) {
            DropdownMenuItem item = widget.items[shownIndexes[index]];
            return InkWell(
              onTap: () {
                if (widget.multipleSelection) {
                  setState(() {
                    if (widget.selectedItems.contains(shownIndexes[index])) {
                      widget.selectedItems.remove(shownIndexes[index]);
                    } else {
                      widget.selectedItems.add(shownIndexes[index]);
                    }
                  });
                } else {
                  widget.selectedItems.clear();
                  widget.selectedItems.add(shownIndexes[index]);
                  if (widget.doneButton == null) {
                    pop();
                  } else {
                    setState(() {});
                  }
                }
              },
              child: widget.multipleSelection
                  ? widget.displayItem == null
                      ? (Row(children: [
                          Icon(
                            widget.selectedItems.contains(shownIndexes[index])
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Flexible(child: item),
                        ]))
                      : widget.displayItem!(item,
                          widget.selectedItems.contains(shownIndexes[index]))
                  : widget.displayItem == null
                      ? item
                      : widget.displayItem!(item, item.value == selectedResult),
            );
          },
          itemCount: shownIndexes.length,
        ),
      ),
    );
  }

  Widget closeButtonWrapper() {
    return (prepareWidget(widget.closeButton, parameter: selectedResult,
        stringToWidgetFunction: (string) {
      return (Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              pop();
            },
            child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2),
                child: Text(
                  string,
                  style: defaultButtonStyle,
                  overflow: TextOverflow.ellipsis,
                )),
          )
        ],
      ));
    }));
  }
}
