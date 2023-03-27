import 'package:flutter/material.dart';
import '../../image_container.dart';

class LogoWing extends StatefulWidget {
  final double width;
  final double height;
  final String imageFile;

  const LogoWing({
    Key? key,
    this.width = 180,
    this.height = 165,
    this.imageFile = 'white-left.png',
  }) : super(key: key);

  @override
  State<LogoWing> createState() => _LogoWingState();
}

class _LogoWingState extends State<LogoWing> {
  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      width: widget.width,
      height: widget.height,
      imageFile: widget.imageFile,
    );
  }
}
