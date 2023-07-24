import 'package:example/libraries/htkc_theme_configurator.dart';
import 'package:example/libraries/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class FormSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
      theme: EmergentThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.grey,
        variantColor: Colors.black38,
        depth: 8,
        intensity: 0.65,
      ),
      themeMode: ThemeMode.light,
      child: Material(
        child: EmergentBackground(
          child: _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

enum Gender { MALE, FEMALE, NON_BINARY }

class __PageState extends State<_Page> {
  String firstName = "";
  String lastName = "";
  double age = 12;
  Gender? gender;
  Set<String> rides = Set();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 10),
              child: TopBar(
                actions: <Widget>[
                  ThemeConfigurator(),
                ],
              ),
            ),
            Emergent(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              style: EmergentStyle(
                boxShape:
                    EmergentBoxShape.roundRect(BorderRadius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: EmergentButton(
                      onPressed: _isButtonEnabled() ? () {} : null,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  _AvatarField(),
                  SizedBox(
                    height: 8,
                  ),
                  _TextField(
                    label: "First name",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.firstName = firstName;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  _TextField(
                    label: "Last name",
                    hint: "",
                    onChanged: (lastName) {
                      setState(() {
                        this.lastName = lastName;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  _AgeField(
                    age: this.age,
                    onChanged: (age) {
                      setState(() {
                        this.age = age;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  _GenderField(
                    gender: gender!,
                    onChanged: (gender) {
                      setState(() {
                        this.gender = gender;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  /*
                  _RideField(
                    rides: this.rides,
                    onChanged: (rides) {
                      setState(() {
                        this.rides = rides;
                      });
                    },
                  ),
                  SizedBox(
                    height: 28,
                  ),
                   */
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isButtonEnabled() {
    return this.firstName.isNotEmpty && this.lastName.isNotEmpty;
  }
}

class _AvatarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Emergent(
        padding: EdgeInsets.all(10),
        style: EmergentStyle(
          boxShape: EmergentBoxShape.circle(),
          depth: EmergentTheme.hcDepth(context),
        ),
        child: Icon(
          Icons.insert_emoticon,
          size: 120,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}

class _AgeField extends StatelessWidget {
  final double age;
  final ValueChanged<double>? onChanged;

  _AgeField({required this.age, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: EmergentTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: EmergentSlider(
                  min: 8,
                  max: 75,
                  value: this.age,
                  onChanged: (value) {
                    this.onChanged!(value);
                  },
                ),
              ),
            ),
            Text("${this.age.floor()}"),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

class _TextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String>? onChanged;

  _TextField({required this.label, required this.hint, this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            this.widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: EmergentTheme.defaultTextColor(context),
            ),
          ),
        ),
        Emergent(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: EmergentStyle(
            depth: EmergentTheme.hcDepth(context),
            boxShape: EmergentBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextField(
            onChanged: this.widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: this.widget.hint),
          ),
        )
      ],
    );
  }
}

class _GenderField extends StatelessWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const _GenderField({
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Gender",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: EmergentTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 12),
            EmergentRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              style: EmergentRadioStyle(
                boxShape: EmergentBoxShape.circle(),
              ),
              value: Gender.MALE,
              child: Icon(Icons.account_box),
              onChanged: (value) => this.onChanged(value!),
            ),
            SizedBox(width: 12),
            EmergentRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              style: EmergentRadioStyle(
                boxShape: EmergentBoxShape.circle(),
              ),
              value: Gender.FEMALE,
              child: Icon(Icons.pregnant_woman),
              onChanged: (value) => this.onChanged(value!),
            ),
            SizedBox(width: 12),
            EmergentRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              style: EmergentRadioStyle(
                boxShape: EmergentBoxShape.circle(),
              ),
              value: Gender.NON_BINARY,
              child: Icon(Icons.supervised_user_circle),
              onChanged: (value) => this.onChanged(value!),
            ),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}
