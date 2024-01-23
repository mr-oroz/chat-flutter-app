import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CardMessageWidget extends StatefulWidget {
  const CardMessageWidget({
    super.key,
    required this.aligment,
    required this.isOwnMessage,
    required this.data,
  });

  final Alignment aligment;
  final bool isOwnMessage;
  final Map<String, dynamic> data;

  @override
  State<CardMessageWidget> createState() => _CardMessageWidgetState();
}

class _CardMessageWidgetState extends State<CardMessageWidget> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru_RU', null);
  }
  @override
  Widget build(BuildContext context) {
    var time = DateTime.parse(widget.data['timestamp'].toDate().toString());
    var formattedTime = DateFormat('HH:mm', 'ru_RU').format(time.toLocal());
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Container(
      alignment: widget.aligment,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: widget.isOwnMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: widget.isOwnMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.isOwnMessage
                  ? const SizedBox()
                  : SvgPicture.asset('assets/svgs/Vector2.svg'),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                decoration: BoxDecoration(
                  color: widget.isOwnMessage ? AppColors.green : AppColors.grey,
                  borderRadius: widget.isOwnMessage
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.data['message'],
                      style: AppFonts.w600f15.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      formattedTime,
                      textAlign: TextAlign.end,
                      style: AppFonts.w500f12,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    if (widget.data['isReady'] != null)
                      _buildMessageStatusIcon(widget.data['senderId'],
                          widget.data['isReady'] as bool, auth),
                  ],
                ),
              ),
              widget.isOwnMessage
                  ? SvgPicture.asset('assets/svgs/Vector.svg')
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageStatusIcon(
      String senderId, bool isReady, FirebaseAuth auth) {
    bool isMyMessage = senderId == auth.currentUser!.uid;
    if (!isMyMessage) {
      // Это сообщение от другого пользователя, статус не показываем
      return const SizedBox.shrink();
    }

    if (isReady) {
      // Сообщение прочитано: отображаем две галочки
      return const Icon(
        Icons.done_all,
        size: 12,
      );
    } else {
      // Сообщение отправлено, но еще не прочитано: отображаем одну галочку
      return const Icon(
        Icons.done,
        size: 12,
      );
    }
  }
}
