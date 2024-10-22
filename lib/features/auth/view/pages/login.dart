import 'package:busha_interview/shared/shared.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const route = '/auth/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Log in to your account'),
            Text(
              'Welcome back! Please enter your registered email address to continue',
            ),
            EmailTextFormField(),
            16.verticalSpace,
            PasswordTextFormField(),
          ],
        ),
      ),
    );
  }
}
