import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key, required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: 24,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.textGrey2,
            ),
            hintStyle: AppFonts.w500f16.copyWith(
              color: AppColors.textGrey2,
            ),
            hintText: 'Поиск',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: AppColors.bgColorGrey,
            filled: true),
      ),
    );
  }
}