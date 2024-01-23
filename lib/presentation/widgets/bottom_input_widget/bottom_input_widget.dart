import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomInputWidget extends StatelessWidget {
  const BottomInputWidget({
    super.key,
    required this.controller,
    required this.sendMessage,
  });

  final Function() sendMessage;

  final TextEditingController controller;

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
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.bgColorGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: SvgPicture.asset('assets/svgs/Attach.svg')),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.bgColorGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Сообщение',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  hintStyle: AppFonts.w500f16,
                  border: InputBorder.none,
                ),
                onSubmitted: (String valeu) {
                  sendMessage();
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.bgColorGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset('assets/svgs/Audio.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
