import 'package:example/lib/htkc_color_selector.dart';
import 'package:htkc_utils/htkc_utils.dart';
import 'package:htkc_utils/emergent_utils/shape/path/emergent_logo_path_provider.dart';

class EmergentPlayground extends StatefulWidget {
  @override
  _EmergentPlaygroundState createState() => _EmergentPlaygroundState();
}

class _EmergentPlaygroundState extends State<EmergentPlayground> {
  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
      themeMode: ThemeMode.light,
      theme: EmergentThemeData(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  LightSource lightSource = LightSource.topLeft;
  EmergentShape shape = EmergentShape.flat;
  EmergentBoxShape? boxShape;
  double depth = 5;
  double intensity = 0.5;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 150.0;
  double width = 150.0;

  static final minWidth = 50.0;
  static final maxWidth = 200.0;
  static final minHeight = 50.0;
  static final maxHeight = 200.0;

  bool haveEmergentChild = false;
  bool childOppositeLightSourceChild = false;
  bool drawAboveChild = false;
  double childMargin = 5;
  double childDepth = 5;

  @override
  void initState() {
    boxShape = EmergentBoxShape.path(EmergentLogoPathProvider());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: EmergentTheme.baseColor(context),
        //appBar: EmergentAppBar(
        //  title: Text('Playground'),
        //),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "back",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  lightSourceWidgets(),
                  Center(child: emergent()),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: _configurators(),
            )
          ],
        ));
  }

  int selectedConfiguratorIndex = 0;

  Widget _configurators() {
    final Color buttonActiveColor = Theme.of(context).colorScheme.secondary;
    final Color buttonInnactiveColor = Colors.white;

    final Color textActiveColor = Colors.white;
    final Color textInactiveColor = Colors.black.withOpacity(0.3);

    return Card(
      margin: EdgeInsets.all(8),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[300],
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: selectedConfiguratorIndex == 0
                        ? buttonActiveColor
                        : buttonInnactiveColor,
                    child: Text(
                      "Style",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 0
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 0;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Element",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 1
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    color: selectedConfiguratorIndex == 1
                        ? buttonActiveColor
                        : buttonInnactiveColor,
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 1;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Child",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 2
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    color: selectedConfiguratorIndex == 2
                        ? buttonActiveColor
                        : buttonInnactiveColor,
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 2;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          _configuratorsChild()!,
        ],
      ),
    );
  }

  Widget? _configuratorsChild() {
    switch (selectedConfiguratorIndex) {
      case 0:
        return styleCustomizer();
      case 1:
        return elementCustomizer();
      case 2:
        return childCustomizer();
    }
    return null;
  }

  Widget styleCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        depthSelector(),
        intensitySelector(),
        surfaceIntensitySelector(),
        colorPicker(),
      ],
    );
  }

  Widget elementCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        boxshapeWidget(),
        cornerRadiusSelector(),
        shapeWidget(),
        sizeSelector(),
      ],
    );
  }

  Widget childCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        hasChildSelector(),
        drawAboveChildSelector(),
        childDepthSelector(),
        childMarginSelector(),
        childOppositeLightsourceSelector(),
      ],
    );
  }

  Widget colorPicker() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 12,
        ),
        Text("Color "),
        SizedBox(
          width: 4,
        ),
        ColorSelector(
          onColorChanged: (color) {
            setState(() {
              EmergentTheme.of(context)
                  ?.updateCurrentTheme(EmergentThemeData(baseColor: color));
            });
          },
          color: EmergentTheme.baseColor(context),
        ),
      ],
    );
  }

  Widget emergent() {
    return EmergentButton(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      onPressed: () {
        setState(() {});
      },
      drawSurfaceAboveChild: this.drawAboveChild,
      style: EmergentStyle(
        boxShape: boxShape,
        //border: EmergentBorder(),
        shape: this.shape,
        intensity: this.intensity,
        /*
        shadowLightColor: Colors.red,
        shadowDarkColor: Colors.blue,
        shadowLightColorEmboss: Colors.red,
        shadowDarkColorEmboss: Colors.blue,
         */
        surfaceIntensity: this.surfaceIntensity,
        depth: depth,
        lightSource: this.lightSource,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: haveEmergentChild
            ? emergentChild()
            : Container(
                //color: Colors.blue,
                child: Center(child: Text("")),
              ),
      ),
    );
  }

  Widget emergentChild() {
    return Emergent(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(this.childMargin),
      drawSurfaceAboveChild: true,
      style: EmergentStyle(
          boxShape: boxShape,
          //shape: this.shape,
          intensity: this.intensity,
          surfaceIntensity: this.surfaceIntensity,
          depth: childDepth,
          lightSource: this.lightSource,
          oppositeShadowLightSource: this.childOppositeLightSourceChild),
      child: SizedBox.expand(),
    );
  }

  Widget depthSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Depth"),
        ),
        Expanded(
          child: Slider(
            min: Emergent.minDepth,
            max: Emergent.maxDepth,
            value: depth,
            onChanged: (value) {
              setState(() {
                depth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(depth.floor().toString()),
        ),
      ],
    );
  }

  Widget childDepthSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Child Depth"),
        ),
        Expanded(
          child: Slider(
            min: Emergent.minDepth,
            max: Emergent.maxDepth,
            value: childDepth,
            onChanged: (value) {
              setState(() {
                childDepth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(childDepth.floor().toString()),
        ),
      ],
    );
  }

  Widget childMarginSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Child Margin"),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 40,
            value: childMargin,
            onChanged: (value) {
              setState(() {
                childMargin = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(childMargin.floor().toString()),
        ),
      ],
    );
  }

  Widget hasChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Has Child"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: this.haveEmergentChild,
            onChanged: (value) {
              setState(() {
                haveEmergentChild = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget drawAboveChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Draw above child"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: this.drawAboveChild,
            onChanged: (value) {
              setState(() {
                drawAboveChild = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget childOppositeLightsourceSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("OppositeLight"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: this.childOppositeLightSourceChild,
            onChanged: (value) {
              setState(() {
                childOppositeLightSourceChild = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget sizeSelector() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 12,
        ),
        Text("W: "),
        Expanded(
          child: Slider(
            min: minWidth,
            max: maxWidth,
            value: width,
            onChanged: (value) {
              setState(() {
                width = value;
              });
            },
          ),
        ),
        Text("H: "),
        Expanded(
          child: Slider(
            min: minHeight,
            max: maxHeight,
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget cornerRadiusSelector() {
    if (boxShape!.isRoundRect || boxShape!.isBeveled) {
      return Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Corner"),
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: 30,
              value: cornerRadius,
              onChanged: (value) {
                setState(() {
                  cornerRadius = value;
                  if (boxShape!.isRoundRect) {
                    boxShape = EmergentBoxShape.roundRect(
                        BorderRadius.circular(this.cornerRadius));
                  }
                  if (boxShape!.isBeveled) {
                    boxShape = EmergentBoxShape.beveled(
                        BorderRadius.circular(this.cornerRadius));
                  }
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Text(cornerRadius.floor().toString()),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget intensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Intensity"),
        ),
        Expanded(
          child: Slider(
            min: Emergent.minIntensity, //in case of != 0
            max: Emergent.maxIntensity,
            value: intensity,
            onChanged: (value) {
              setState(() {
                intensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((intensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget surfaceIntensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("SurfaceIntensity"),
        ),
        Expanded(
          child: Slider(
            min: Emergent.minIntensity, //in case of != 0
            max: Emergent.maxIntensity,
            value: surfaceIntensity,
            onChanged: (value) {
              setState(() {
                surfaceIntensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((surfaceIntensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget boxshapeWidget() {
    final Color buttonActiveColor = Theme.of(context).colorScheme.secondary;
    final Color buttonInnactiveColor = Colors.white;

    final Color textActiveColor = Colors.white;
    final Color textInactiveColor = Colors.black.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  boxShape = EmergentBoxShape.roundRect(
                      BorderRadius.circular(this.cornerRadius));
                });
              },
              color: boxShape!.isRoundRect
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Text(
                "Rect",
                style: TextStyle(
                    color: boxShape!.isRoundRect
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  boxShape = EmergentBoxShape.beveled(
                      BorderRadius.circular(this.cornerRadius));
                });
              },
              color:
                  boxShape!.isBeveled ? buttonActiveColor : buttonInnactiveColor,
              child: Text(
                "Beveled",
                style: TextStyle(
                    color: boxShape!.isBeveled
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  boxShape = EmergentBoxShape.circle();
                });
              },
              color:
                  boxShape!.isCircle ? buttonActiveColor : buttonInnactiveColor,
              child: Text(
                "Circle",
                style: TextStyle(
                    color: boxShape!.isCircle
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  boxShape = EmergentBoxShape.stadium();
                });
              },
              color:
                  boxShape!.isStadium ? buttonActiveColor : buttonInnactiveColor,
              child: Text(
                "Stadium",
                style: TextStyle(
                    color: boxShape!.isStadium
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  boxShape = EmergentBoxShape.path(
                      EmergentLogoPathProvider());
                });
              },
              color: boxShape!.isCustomPath
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Text(
                "Custom",
                style: TextStyle(
                    color: boxShape!.isCustomPath
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget shapeWidget() {
    final Color buttonActiveColor = Theme.of(context).colorScheme.secondary;
    final Color buttonInnactiveColor = Colors.white;

    final Color iconActiveColor = Colors.white;
    final Color iconInactiveColor = Colors.black.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  shape = EmergentShape.concave;
                });
              },
              color: shape == EmergentShape.concave
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Image.asset("assets/images/concave.png",
                  color: shape == EmergentShape.concave
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  shape = EmergentShape.convex;
                });
              },
              color: shape == EmergentShape.convex
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Image.asset("assets/images/convex.png",
                  color: shape == EmergentShape.convex
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  shape = EmergentShape.flat;
                });
              },
              color: shape == EmergentShape.flat
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Image.asset("assets/images/flat.png",
                  color: shape == EmergentShape.flat
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget lightSourceWidgets() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 10,
          right: 10,
          child: Slider(
            min: -1,
            max: 1,
            value: lightSource.dx,
            onChanged: (value) {
              setState(() {
                lightSource = lightSource.copyWith(dx: value);
              });
            },
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          bottom: 10,
          child: RotatedBox(
            quarterTurns: 1,
            child: Slider(
              min: -1,
              max: 1,
              value: lightSource.dy,
              onChanged: (value) {
                setState(() {
                  lightSource = lightSource.copyWith(dy: value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
