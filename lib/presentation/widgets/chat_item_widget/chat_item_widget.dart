import 'package:chat_flutter_app/presentation/services/chat_service/chat_service.dart';
import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:chat_flutter_app/presentation/widgets/card_name_and_message/card_name_and_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatItemWidget extends StatefulWidget {
  const ChatItemWidget({
    super.key,
    required this.name,
    required this.onTap,
    required this.getRandomGradient,
    required this.receiverId,
  });

  final String name;
  final Function() onTap;
  final Gradient Function() getRandomGradient;
  final String receiverId;
  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
        child: StreamBuilder(
          stream: chatService.getMessages(
            widget.receiverId,
            _auth.currentUser!.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // извлечим сообшение последних
            List<QueryDocumentSnapshot<Object?>>? messages =
                snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs : null;
            if (messages != null &&
                messages.isNotEmpty &&
                messages.last.data() != null) {
              var lastMessageData =
                  messages.last.data() as Map<String, dynamic>;
              // определение моя сообщение или от этого пользователя
              bool isMyMessage =
                  lastMessageData['senderId'] == _auth.currentUser!.uid;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardNameAndMessage(
                    widget: widget,
                    isMyMessage: isMyMessage,
                    messages: messages,
                    lastMessageData: lastMessageData,
                  ),
                  Text(
                    chatService.lastDateMessage(lastMessageData['timestamp']),
                    style: AppFonts.w500f12.copyWith(
                      color: AppColors.textGrey1,
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
