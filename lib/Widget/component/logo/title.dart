import 'package:flutter/material.dart';
import '../../image_container.dart';

class LogoTitle extends StatefulWidget {
  final double width;
  final double height;
  final String imageFile;

  const LogoTitle({
    Key? key,
    this.width = 704,
    this.height = 107,
    this.imageFile = '27codes.png',
  }) : super(key: key);

  @override
  State<LogoTitle> createState() => _LogoTitleState();
}

class _LogoTitleState extends State<LogoTitle> {
  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      width: widget.width,
      height: widget.height,
      imageFile: widget.imageFile,
    );
  }
}
