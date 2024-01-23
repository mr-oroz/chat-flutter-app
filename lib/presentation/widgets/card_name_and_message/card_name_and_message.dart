
import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:chat_flutter_app/presentation/widgets/chat_item_widget/chat_item_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/my_circle_avatar/my_cirle_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardNameAndMessage extends StatelessWidget {
  const CardNameAndMessage({
    super.key,
    required this.widget,
    required this.isMyMessage,
    required this.messages,
    required this.lastMessageData,
  });

  final ChatItemWidget widget;
  final bool isMyMessage;
  final List<QueryDocumentSnapshot<Object?>> messages;
  final Map<String, dynamic> lastMessageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyCircleAvatar(
          getRandomGradient: widget.getRandomGradient,
          name: widget.name.substring(0, 2).toUpperCase(),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: AppFonts.w600f15,
            ),
            Row(
              children: [
                Text(
                  isMyMessage ? 'Вы:' : '',
                  style: AppFonts.w500f12,
                ),
                SizedBox(width: isMyMessage ? 4 : 0),
                if (messages.isNotEmpty)
                  Text(
                    lastMessageData['message'],
                    style: AppFonts.w500f12.copyWith(
                      color: AppColors.textGrey1,
                    ),
                  )
              ],
            )
          ],
        ),
      ],
    );
  }
}
