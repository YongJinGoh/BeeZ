import 'package:flutter/material.dart';
import '../../image_container.dart';

class LogoCicle extends StatefulWidget {
  final double width;
  final double height;
  final String imageFile;

  const LogoCicle({
    Key? key,
    this.width = 318,
    this.height = 318,
    this.imageFile = 'left-round.png',
  }) : super(key: key);

  @override
  State<LogoCicle> createState() => _LogoCicleState();
}

class _LogoCicleState extends State<LogoCicle> {
  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      width: widget.width,
      height: widget.height,
      imageFile: widget.imageFile,
    );
  }
}
