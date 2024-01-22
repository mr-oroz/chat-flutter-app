import 'package:chat_flutter_app/presentation/screens/auth_screen/auth_screen.dart';
import 'package:chat_flutter_app/presentation/screens/home_screen/home_screen.dart';
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
          return const HomeScreen();
        } else {
          return const AuthScreen();
        }
      },),
    );
  }
}