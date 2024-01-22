import 'package:chat_flutter_app/presentation/services/auth/auth_check.dart';
import 'package:chat_flutter_app/presentation/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0.5,
            centerTitle: false,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 32,
            ),
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      home: const AuthCheck(),
    );
  }
}
