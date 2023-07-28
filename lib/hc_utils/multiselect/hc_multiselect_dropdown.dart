
import 'package:htkc_utils/hc_utils/multiselect/hc_multiple_select.dart';
import 'package:htkc_utils/htkc_utils.dart';

typedef OnConfirm = Function(List selectedValues);

class MultipleDropDown extends StatefulWidget {
  final List values;
  final List<HcMultipleSelectItem> elements;
  final String? placeholder;
  final bool disabled;

  const MultipleDropDown({
    Key? key,
    required this.values,
    required this.elements,
    this.placeholder,
    this.disabled = false,
  })  : super(key: key);

  @override
  State<StatefulWidget> createState() => MultipleDropDownState();
}

class MultipleDropDownState extends State<MultipleDropDown> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Opacity(
              opacity: widget.disabled ? 0.4 : 1,
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[350]!))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _getContent(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
                      child: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      onTap: () {
        if (!widget.disabled) {
          HcMultipleSelect.hcShowMultipleSelector(
            context,
            elements: widget.elements,
            values: widget.values,
            title: widget.placeholder!,
          ).then((values) {
            setState(() {});
          });
        }
      },
    );
  }

  Widget _getContent() {
    if (widget.values.isEmpty && widget.placeholder != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10),
        child: Text(
          widget.placeholder!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            decoration: TextDecoration.none,
          ),
        ),
      );
    } else {
      return Wrap(
        children: widget
            .elements
            .where((element) => widget.values.contains(element.value))
            .map(
              (element) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: RawChip(
              isEnabled: !widget.disabled,
              label: Text(element.display),
              onDeleted: () {
                if (!widget.disabled) {
                  widget.values.remove(element.value);
                  setState(() {});
                }
              },
            ),
          ),
        )
            .toList(),
      );
    }
  }
}