import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:chat_flutter_app/presentation/widgets/bottom_input_widget/bottom_input_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/my_circle_avatar/my_cirle_avatar.dart';
import 'package:flutter/material.dart';

class DetailChatScreen extends StatelessWidget {
  const DetailChatScreen({
    super.key,
    required this.name,
    required this.active,
    required this.gradient,
    required this.login,
  });

  final String name;
  final String login;

  final String active;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: false,
        title: Row(
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
                  style: AppFonts.w500f16.copyWith(color: Colors.black),
                ),
                Text(
                  'В сети',
                  style: AppFonts.w500f12.copyWith(color: AppColors.textGrey1),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomInputWidget(),
    );
  }
}

