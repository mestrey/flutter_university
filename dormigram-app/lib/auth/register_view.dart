import 'package:flutter/material.dart';

import 'package:dormigram/auth/login_register_view.dart';
import 'package:dormigram/auth/auth_viewmodel.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    super.key,
    required AuthViewModel viewModel,
    required this.registerLastController,
    required this.registerFirstController,
    required this.registerMiddleController,
    required this.registerEmailController,
    required this.registerPasswordController,
    required this.registerConfirmPasswordController,
  }) : _viewModel = viewModel;

  final AuthViewModel _viewModel;
  final TextEditingController registerLastController;
  final TextEditingController registerFirstController;
  final TextEditingController registerMiddleController;
  final TextEditingController registerEmailController;
  final TextEditingController registerPasswordController;
  final TextEditingController registerConfirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return TabWidget(
      submit: 'Зарегистрироваться',
      onSubmit: () => _viewModel.registerSubmit(
        registerLastController.text,
        registerFirstController.text,
        registerMiddleController.text,
        registerEmailController.text,
        registerPasswordController.text,
        registerConfirmPasswordController.text,
      ),
      children: [
        Text(
          'Форма для студентов',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Если не являетесь студентом, учетная запись должна быть создана администрацией',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Text(
          '* Пометка обязательных полей',
          style: TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 20),
        TextFieldWidget(
          label: 'Фамилия',
          required: true,
          validator: _viewModel.validateNonNullField,
          controller: registerLastController,
        ),
        TextFieldWidget(
          label: 'Имя',
          required: true,
          validator: _viewModel.validateNonNullField,
          controller: registerFirstController,
        ),
        TextFieldWidget(
          label: 'Отчество',
          required: false,
          validator: (String? _) => null,
          controller: registerMiddleController,
        ),
        const SizedBox(height: 20),
        TextFieldWidget(
          label: 'Электронная почта',
          required: true,
          validator: _viewModel.validateEmail,
          controller: registerEmailController,
        ),
        TextFieldWidget(
          label: 'Пароль',
          required: true,
          obscureText: true,
          validator: _viewModel.validatePassword,
          controller: registerPasswordController,
        ),
        TextFieldWidget(
          label: 'Подтвердите пароль',
          required: true,
          obscureText: true,
          validator: (String? str) => _viewModel.validateConfirmPassword(str, registerPasswordController.text),
          controller: registerConfirmPasswordController,
        ),
      ],
    );
  }
}
