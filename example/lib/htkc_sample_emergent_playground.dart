import 'package:htkc_utils/htkc_utils.dart';

void main() => runApp(EmergentPlayground());

class EmergentPlayground extends StatefulWidget {
  @override
  _EmergentPlaygroundState createState() => _EmergentPlaygroundState();
}

class _EmergentPlaygroundState extends State<EmergentPlayground> {
  @override
  Widget build(BuildContext context) {
    return EmergentApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: EmergentThemeData(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      home: _Page(),
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
  EmergentBoxShape boxShape =
      EmergentBoxShape.roundRect(BorderRadius.circular(12));

  double depth = 5;
  double intensity = 0.5;
  double surfaceIntensity = 0.5;
  double cornerRadius = 40;
  double height = 150.0;
  double width = 150.0;

  bool haveEmergentChild = false;
  bool childOppositeLightsourceChild = false;
  bool drawAboveChild = false;
  double childMargin = 5;
  double childDepth = 5;

  @override
  void initState() {
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
          ],
        ));
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
        shape: this.shape,
        intensity: this.intensity,
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
          oppositeShadowLightSource: this.childOppositeLightsourceChild),
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

  Widget shapeWidget() {
    final Color buttonActiveColor = Theme.of(context).colorScheme.secondary;
    final Color buttonInactiveColor = Colors.white;

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
                  : buttonInactiveColor,
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
                  : buttonInactiveColor,
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
                  : buttonInactiveColor,
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
          left: 20,
          right: 20,
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
          top: 20,
          bottom: 20,
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
