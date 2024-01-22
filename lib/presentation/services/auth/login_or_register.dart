import 'package:chat_flutter_app/presentation/screens/login_screen/login_screen.dart';
import 'package:chat_flutter_app/presentation/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showRegisterPage = false;

  void  togglePages() {
    setState(() {
      showRegisterPage = !showRegisterPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showRegisterPage) {
      return RegisterScreen(onPressed: togglePages);
    } else {
      return LoginScreen(onPressed: togglePages);
    }
  }
}