import 'package:flutter/material.dart';

class DragItem extends StatefulWidget {
  @override
  // ignore: overridden_fields
  final Key? key;
  final bool isDraggable;
  final bool isDropable;
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const DragItem({
    this.key,
    this.isDraggable = true,
    this.isDropable = true,
    /*required*/ required this.child,
  });

  @override
  DragItemState createState() => DragItemState();
}

class DragItemState extends State<DragItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      child: widget.child,
    );
  }
}
