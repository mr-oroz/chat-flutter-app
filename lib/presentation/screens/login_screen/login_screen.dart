import 'package:chat_flutter_app/presentation/services/auth/auth_service.dart';
import 'package:chat_flutter_app/presentation/widgets/app_button/app_button.dart';
import 'package:chat_flutter_app/presentation/widgets/center_column_widget/center_column_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/my_text_field/my_text_field.dart';
import 'package:chat_flutter_app/presentation/widgets/padding_x16_y10/padding_x16_y10.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInUser(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Войти'),
      ),
      body: SafeArea(
        child: PaddingX16Y10(
          child: CenterColumnWidget(
            children: [
              const Text(
                "Войти",
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
              AppButton(
                title: 'Войти',
                onPressed: signIn,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('если нет аккаунт?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onPressed,
                    child: const Text(
                      'Зарегистрироваться',
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
