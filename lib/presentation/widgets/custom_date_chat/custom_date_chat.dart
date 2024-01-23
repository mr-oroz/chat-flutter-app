import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomDateChat extends StatelessWidget {
  const CustomDateChat({
    super.key, required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 1,
            decoration: const BoxDecoration(color: AppColors.grey),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Text(date),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 1,
            decoration: const BoxDecoration(color: AppColors.grey),
          ),
        ),
      ],
    ));
  }
}
