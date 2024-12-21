import 'package:flutter/material.dart';

import 'package:dormigram/auth/login_register_view.dart';
import 'package:dormigram/auth/auth_viewmodel.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    required AuthViewModel viewModel,
    required this.loginEmailController,
    required this.loginPasswordController,
  }) : _viewModel = viewModel;

  final AuthViewModel _viewModel;
  final TextEditingController loginEmailController;
  final TextEditingController loginPasswordController;

  @override
  Widget build(BuildContext context) {
    return TabWidget(
      submit: 'Войти',
      onSubmit: () => _viewModel.loginSubmit(loginEmailController.text, loginPasswordController.text),
      children: [
        Text(
          'С возвращением!',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextFieldWidget(
          label: 'Электронная почта',
          required: true,
          controller: loginEmailController,
          validator: _viewModel.validateEmail,
        ),
        TextFieldWidget(
          label: 'Пароль',
          required: true,
          obscureText: true,
          controller: loginPasswordController,
          validator: _viewModel.validatePassword,
        ),
      ],
    );
  }
}
