import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';

class BottomInputWidget extends StatelessWidget {
  const BottomInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
        bottom: 23,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppColors.bgColorGrey,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 7,
            child: Container(
              height: 30,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
