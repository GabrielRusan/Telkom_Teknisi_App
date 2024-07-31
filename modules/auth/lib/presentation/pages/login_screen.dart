import 'package:auth/presentation/widgets/login_button.dart';
import 'package:auth/presentation/widgets/text_field_password.dart';
import 'package:core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
                child: Image.asset(
              'assets/icons/logo_telkom.png',
              package: 'auth',
              height: 200,
              width: 200,
            )),
            const SizedBox(
              height: 22,
            ),
            const TextFieldWidget(),
            const SizedBox(
              height: 16,
            ),
            const TextFieldPassword(),
            const SizedBox(
              height: 32,
            ),
            const LoginButton(),
          ],
        ),
      ),
    );
  }
}
