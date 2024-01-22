// ignore_for_file: use_build_context_synchronously

import 'package:chat_flutter_app/presentation/services/auth/auth_service.dart';
import 'package:chat_flutter_app/presentation/widgets/app_button/app_button.dart';
import 'package:chat_flutter_app/presentation/widgets/center_column_widget/center_column_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/my_text_field/my_text_field.dart';
import 'package:chat_flutter_app/presentation/widgets/padding_x16_y10/padding_x16_y10.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  void signUpUser() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    // надо проверяет до регистрация пароль совпадает подтвердающий паролем 
    if (passwordController.text == confirmPassController.text) {
      try {
        await authService.signUpUser(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пароль не совпадает'),
          ),
        );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: SafeArea(
        child: PaddingX16Y10(
          child: CenterColumnWidget(
            children: [
              const Text(
                "Регистрация",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 50),
              MyTextField(
                hintText: 'Почта',
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Пароль',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Подтвердить пароль',
                obscureText: true,
                controller: confirmPassController,
              ),
              const SizedBox(height: 10),
              AppButton(
                title: 'Зарегистрировать',
                onPressed: signUpUser,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('если есть аккаунт?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onPressed,
                    child: const Text(
                      'Войти',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
