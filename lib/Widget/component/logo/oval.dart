import 'package:flutter/material.dart';
import '../../image_container.dart';

class LogoOval extends StatefulWidget {
  final double width;
  final double height;
  final String imageFile;

  const LogoOval({
    Key? key,
    this.width = 160,
    this.height = 275,
    this.imageFile = 'mid-blue.png',
  }) : super(key: key);

  @override
  State<LogoOval> createState() => _LogoOvalState();
}

class _LogoOvalState extends State<LogoOval> {
  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      width: widget.width,
      height: widget.height,
      imageFile: widget.imageFile,
    );
  }
}
