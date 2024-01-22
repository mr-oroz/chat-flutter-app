import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:chat_flutter_app/presentation/widgets/my_circle_avatar/my_cirle_avatar.dart';
import 'package:flutter/material.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    super.key,
    required this.login,
    required this.name,
    required this.message,
    required this.status,
    required this.onTap, required this.gradient,
  });

  final String login;
  final String name;
  final String message;
  final String status;
  final Function() onTap;
  final Gradient gradient;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyCircleAvatar(
                  gradient: gradient,
                  name: login,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppFonts.w600f15,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Вы:',
                          style: AppFonts.w500f12,
                        ),
                        Text(
                          message,
                          style: AppFonts.w500f12.copyWith(
                            color: AppColors.textGrey1,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Text(
              status,
              style: AppFonts.w500f12.copyWith(
                color: AppColors.textGrey1,
              ),
            )
          ],
        ),
      ),
    );
  }
}