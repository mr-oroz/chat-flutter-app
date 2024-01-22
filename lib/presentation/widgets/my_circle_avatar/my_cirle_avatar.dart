
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({
    super.key,
    required this.gradient,
    required this.name,
  });

  final Gradient gradient;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), gradient: gradient),
      child: Center(
        child: Text(
          name.toString(),
          style: AppFonts.w700f20.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}