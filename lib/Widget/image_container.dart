import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final double width;
  final double height;
  final String imageFile;
  final double ratio;

  const ImageContainer({
    Key? key,
    required this.width,
    required this.height,
    this.ratio = 4.5,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / ratio,
      height: height / ratio,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/$imageFile',
        fit: BoxFit.contain,
      ),
    );
  }
}
