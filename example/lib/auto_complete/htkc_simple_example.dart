import 'package:htkc_utils/htkc_utils.dart';

class HcSimpleExample extends StatefulWidget {
  final List<String> suggestions;

  HcSimpleExample({required this.suggestions});

  @override
  _HcSimpleExampleState createState() => _HcSimpleExampleState();
}

class _HcSimpleExampleState extends State<HcSimpleExample> {
  String _selectedSuggestion = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HcDropdownSuggestionsFormField<String>(
          decoration: InputDecoration(
              hintText: 'Start typing', labelText: 'Simple suggestion'),
          items: widget.suggestions,
          onSelected: (suggestion) => setState(() {
            _selectedSuggestion = suggestion;
          }),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'SELECTED SUGGESTION: ${_selectedSuggestion}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
