import 'package:chat_flutter_app/presentation/screens/home_screen/home_screen.dart';
import 'package:chat_flutter_app/presentation/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        if(snapshot.hasData) {
          // если пользователь авторизован направляем homescreen
          return const HomeScreen();
        } else {
          // если пользователь  не авторизован тогда направляем LoginOrRegister
          return const LoginOrRegister();
        }
      },),
    );
  }
}