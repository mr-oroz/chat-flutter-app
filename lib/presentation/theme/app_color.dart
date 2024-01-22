import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color green = Color(0xFF3BEC78);
  static const Color grey = Color(0xFFEDF2F6);
  static const Color textGrey1 = Color(0xFF5D7A90);
  static const Color textGrey2 = Color(0xFF9DB6CA);
  static const Color bgColorGrey = Color(0xFFEDF2F6);
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFF66700), Color(0xFFEC3800)],
  );
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF00ACF6), Color(0xFF006CEC)],
  );
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF1EDA5E), Color(0xFF31C764)],
  );
}
