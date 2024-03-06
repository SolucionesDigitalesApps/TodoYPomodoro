import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/constants.dart';

class GeneralImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String url;
  final bool fromLocal;
  final double borderRadius;
  final BoxFit? fit;
  final Color? bgColor;
  final String? text;
  final bool fromMemory;
  final String? file;
  final AlignmentGeometry alignment;
  final bool fadeInEnabled;

  const GeneralImage({
    Key? key,
    this.width,
    this.height,
    required this.url,
    this.fit,
    this.fromLocal = false,
    this.fromMemory = false,
    this.borderRadius = 0,
    this.bgColor, 
    this.text,
    this.file,
    this.alignment = Alignment.center,
    this.fadeInEnabled = true
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor, 
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: fromMemory ? 
        Image.file(
          File(file!),
          fit: fit,
          width: width,
          height: height,
        ) :
        !fromLocal
        ? (url.isEmpty
          ? Image.asset(
              notFoundImage,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
            )
          : Image.network(url, width: width, height: height, fit: fit,)
        ) : Image.asset(
          url,
          fit: fit,
          width: width,
          height: height,
          alignment: alignment,
        )
      )
    );
  }
}
