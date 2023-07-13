import 'package:flutter/material.dart';

class HcDragItem extends StatefulWidget {
  final bool isDraggable;
  final bool isDroppable;
  final Widget child;

  const HcDragItem({super.key,
    this.isDraggable = true,
    this.isDroppable = true,
    required this.child,
  });

  @override
  HcDragItemState createState() => HcDragItemState();
}

class HcDragItemState extends State<HcDragItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      child: widget.child,
    );
  }
}