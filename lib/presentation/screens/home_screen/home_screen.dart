import 'dart:math';
import 'package:chat_flutter_app/presentation/services/auth/auth_service.dart';
import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:chat_flutter_app/presentation/widgets/search_widget/search_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/user_list/user_list.dart';
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

  // выйти из аккаунта
  void logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.logout();
  }

  //  список градиент цвет
  final List<Gradient> gradients = [
    AppColors.greenGradient,
    AppColors.redGradient,
    AppColors.blueGradient,
  ];

  //   рандом градиент цвет
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
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
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
            UserList(
              getRandomGradient: getRandomGradient,
            ),
          ],
        ),
      ),
    );
  }
}
