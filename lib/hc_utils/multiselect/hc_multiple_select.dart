import 'package:htkc_utils/htkc_utils.dart';

class HcMultipleSelect {
  static Future hcShowMultipleSelector(
      BuildContext context, {
        required List<HcMultipleSelectItem> elements,
        required values,
        required String title,
      }) {
    return Navigator.push(
      context,
      HcMultipleSelectRoute<List>(
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        elements: elements,
        values: values,
        title: title,
      ),
    );
  }
}

class HcMultipleSelectRoute<T> extends PopupRoute<T> {
  final List<HcMultipleSelectItem> elements;
  final List values;
  final String title;

  HcMultipleSelectRoute({
    this.barrierLabel,
    required this.elements,
    required this.values,
    required this.title,
  });

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 2000);

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: HcSelectorList(
        elements: this.elements,
        values: this.values,
        title: this.title,
      ),
    );
    ThemeData theme = Theme.of(context);
    bottomSheet = Theme(data: theme, child: bottomSheet);
    return bottomSheet;
  }
}

class HcSelectorList<T> extends StatefulWidget {
  final List<HcMultipleSelectItem> elements;
  final double height;
  final List values;
  final String title;

  const HcSelectorList({super.key,
    required this.elements,
    this.height = 200,
    required this.values,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() => HcSelectorListState();
}

class HcSelectorListState extends State<HcSelectorList> {
  List<HcMultipleSelectItem>? _elements;

  @override
  initState() {
    super.initState();
    _elements = widget.elements;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 5.0),
              ]),
          padding: const EdgeInsets.only(top: 20, bottom: 5, left: 6, right: 6),
          margin: EdgeInsets.only(top: widget.height, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 30,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontFamily: 'pyitaungsu'),
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 1.0, color: Colors.black54),
                  itemCount: _elements!.length,
                  itemBuilder: (context, index) {
                    HcMultipleSelectItem item = _elements![index];
                    return GestureDetector(
                      onTap: () {
                        widget.values.contains(item.value)
                            ? widget.values.remove(item.value)
                            : widget.values.add(item.value);
                        setState(() {});
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Text(
                                item.content.toString(),
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'pyitaungsu'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: widget.values.contains(item.value)
                                  ? const Icon(
                                Icons.check_box,
                                color: Colors.green,
                                size: 30,
                              )
                                  : const Icon(
                                Icons.check_box_outline_blank,
                                color: Colors.grey,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        getToolbar(context, widget.values),
      ],
    );
  }

  var getToolbar = (context, values) => Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    height: 40,
    child: GestureDetector(
      onTap: () => Navigator.pop(context, values),
      child: Container(
        decoration: BoxDecoration(
          border:
          Border(top: BorderSide(width: 2, color: Colors.grey[350]!)),
          color: Colors.grey[200],
        ),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.keyboard_arrow_down,
          size: 35,
          color: Colors.black54,
        ),
      ),
    ),
  );
}

class HcMultipleSelectItem<V, D, C> {
  V value;
  D display;

  /// drop down content.
  C content;

  HcMultipleSelectItem.build({
    required this.value,
    required this.display,
    required this.content,
  });

  HcMultipleSelectItem.fromJson(
      Map<String, dynamic> json, {
        displayKey = 'display',
        valueKey = 'value',
        contentKey = 'content',
      })  : value = json[valueKey] ?? '',
        display = json[displayKey] ?? '',
        content = json[contentKey] ?? '';

  static List<HcMultipleSelectItem> allFromJson(
      List jsonList, {
        displayKey = 'display',
        valueKey = 'value',
        contentKey = 'content',
      }) {
    return jsonList
        .map((json) => HcMultipleSelectItem.fromJson(
      json,
      displayKey: displayKey,
      valueKey: valueKey,
      contentKey: contentKey,
    ))
        .toList();
  }
}