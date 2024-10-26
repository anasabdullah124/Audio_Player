import 'package:audio_player/customs/custom_colors.dart';
import 'package:flutter/material.dart';

class OurStyle {
  static ourStyle(
      {double? size = 14, color = whiteColor, required = FontWeight.bold}) {
    return TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold);
  }
}

class OurStyle2 {
  static ourStyle2({
    double? size = 14,
    color = whiteColor,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
    );
  }
}
