import 'dart:math';

import 'package:chat_flutter_app/presentation/core/data.dart';
import 'package:chat_flutter_app/presentation/screens/detail_chat_screen/detail_chat_screen.dart';
import 'package:chat_flutter_app/presentation/services/auth/auth_service.dart';
import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:chat_flutter_app/presentation/widgets/chat_item_widget/chat_item_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/search_widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random random = Random();
  final TextEditingController searchController = TextEditingController();
  void logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.logout();
  }

  final List<Gradient> gradients = [
    AppColors.greenGradient,
    AppColors.redGradient,
    AppColors.blueGradient,
  ];

  Gradient getRandomGradient() {
    return gradients[random.nextInt(gradients.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Чаты',
          style: AppFonts.w600f32,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(controller: searchController),
            Container(
              height: 1,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.bgColorGrey,
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: List.generate(4, (index) {
                return ChatItemWidget(
                  login: chatList[index].login,
                  name: chatList[index].name,
                  message: chatList[index].message,
                  status: chatList[index].status,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailChatScreen(
                            name: chatList[index].name,
                            active: '',
                            gradient: getRandomGradient(),
                            login: chatList[index].login),
                      ),
                    );
                  },
                  gradient: getRandomGradient(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}


//ChatItemWidget(
//                  gradient: AppColors.greenGradient,
//                  login: 'BB',
//                  message: 'Уже сделал?',
//                  name: 'Виктор Власов',
//                  status: 'Вчера',
//                  onTap: () {},
//                ),
//                ChatItemWidget(
//                  gradient: AppColors.redGradient,
//                  login: 'СА',
//                  message: 'Я готов',
//                  name: 'Саша Алексеев',
//                  status: '12.01.22',
//                  onTap: () {},
//                ),
//                ChatItemWidget(
//                  gradient: AppColors.blueGradient,
//                  login: 'ПЖ',
//                  message: 'Я вышел',
//                  name: 'Пётр Жаринов',
//                  status: '2 минуты назад',
//                  onTap: () {},
//                ),
//                ChatItemWidget(
//                  gradient: AppColors.redGradient,
//                  login: 'АЖ',
//                  message: 'Я вышел',
//                  name: 'Алина Жукова',
//                  status: '09:23',
//                  onTap: () {},
//                )