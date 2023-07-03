import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HImageSliderWidget extends StatefulWidget {
  final List<String> imageUrls;
  final BorderRadius imageBorderRadius;
  final double imageHeight;
  final double imageWidth;
  final String from;
  final bool isFeatured;
  final Color bgColor;
  final Color bulletColor;

  const HImageSliderWidget({
    Key? key,
    required this.imageUrls,
    required this.imageBorderRadius,
    required this.imageHeight,
    required this.imageWidth,
    required this.from,
    required this.isFeatured,
    required this.bgColor,
    required this.bulletColor,
  }) : super(key: key);

  @override
  State<HImageSliderWidget> createState() => _HImageSliderWidgetState();

}

class _HImageSliderWidgetState extends State<HImageSliderWidget> {
  List<Widget> _pages = [];
  int page = 0;
  bool isChange = false;
  Timer? sliderTime;
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    _pages = widget.imageUrls.map((slider) {
      return _buildImagePageItem(slider);
    }).toList();

    if (widget.from != "fullscreen") {
      Future.delayed(const Duration(seconds: 10), () {
        sliderTime =
            Timer.periodic(const Duration(seconds: 5), (Timer t) => setPage());
      });
    }
  }

  void setPage() {
    if (page == _pages.length - 1) {
      page = 0;
    } else {
      page++;
    }
    if (_controller.hasClients) {
      _controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildingImageSlider();
  }

  Widget _buildingImageSlider() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: widget.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: widget.imageBorderRadius,
          ),
          child: SizedBox(
            height: widget.imageHeight,
            width:  widget.imageWidth,
            child: _buildPagerViewSlider(),
          ),
        ),
        _buildDotsIndicatorOverlay(),
      ],
    );
  }

  Widget _buildPagerViewSlider() {
    return PageView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _controller,
      itemCount: _pages.length,
      itemBuilder: (BuildContext context, int index) {
        return _pages[index % _pages.length];
      },
      onPageChanged: (int p) {
        setState(() {
          page = p;
        });
      },
    );
  }

  Widget _buildDotsIndicatorOverlay() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 4.0,
          children: List.generate(
              _pages.length,
                  (index) => Icon(
                page == index
                    ? Icons.brightness_1
                    : Icons.radio_button_unchecked,
                color: widget.bulletColor,
                size: 11,
              ))),
    );
  }

  Widget _buildImagePageItem(String sliderImage) {
    return ClipRRect(
      borderRadius: widget.imageBorderRadius,
      child: GestureDetector(
          onTap: () {},
          child: Image.asset(sliderImage,
            fit: widget.from == "fullscreen" ? BoxFit.contain : BoxFit.fill,
          )),
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({Key? key,
    required this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = blueColor,
    //this.color: Colors.white,
  }) : super(listenable: controller, key: key);

  final PageController controller;
  final int? itemCount;
  final ValueChanged<int>? onPageSelected;
  final Color color;
  static const double _kDotSize = 4.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 15.0;

  Widget _buildDot(int index) {
    double selectedNess = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedNess;
    return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected!(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}
