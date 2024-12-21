import 'package:dormigram/wrapper/wrapper_view.dart';
import 'package:flutter/material.dart';

import 'package:dormigram/auth/auth_viewmodel.dart';
import 'package:dormigram/auth/login_view.dart';
import 'package:dormigram/auth/register_view.dart';
import 'package:dormigram/widgets/primary_button.dart';

class LoginRegisterPage extends StatefulWidget {
  final AuthViewModel viewModel;

  const LoginRegisterPage({super.key, required this.viewModel});

  @override
  // ignore: library_private_types_in_public_api
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AuthViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _viewModel = widget.viewModel;
  }

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerFirstController = TextEditingController();
  final registerLastController = TextEditingController();
  final registerMiddleController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          labelColor: Theme.of(context).primaryColor,
          indicatorColor: Theme.of(context).primaryColor,
          controller: _tabController,
          tabs: const [Tab(text: 'Вход'), Tab(text: 'Регистрация')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LoginWidget(
            viewModel: _viewModel,
            loginEmailController: loginEmailController,
            loginPasswordController: loginPasswordController,
          ),
          RegisterWidget(
            viewModel: _viewModel,
            registerLastController: registerLastController,
            registerFirstController: registerFirstController,
            registerMiddleController: registerMiddleController,
            registerEmailController: registerEmailController,
            registerPasswordController: registerPasswordController,
            registerConfirmPasswordController: registerConfirmPasswordController,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerFirstController.dispose();
    registerLastController.dispose();
    registerMiddleController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
  }
}

class TextFieldWidget extends StatelessWidget {
  final String label;
  final bool required;
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.required,
    this.obscureText = false,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const text = Text('*', style: TextStyle(color: Colors.red));

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, suffix: required ? text : null),
      obscureText: obscureText,
      validator: (String? str) => validator(str),
    );
  }
}

class TabWidget extends StatelessWidget {
  final List<Widget> children;
  final String submit;
  final Function onSubmit;

  TabWidget({super.key, required this.children, required this.submit, required this.onSubmit});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...children,
                  const SizedBox(height: 40),
                  SubmitButtonWidget(submit: submit, formKey: _formKey, onSubmit: onSubmit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({
    super.key,
    required this.submit,
    required GlobalKey<FormState> formKey,
    required this.onSubmit,
  }) : _formKey = formKey;

  final String submit;
  final GlobalKey<FormState> _formKey;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: submit,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Подождите...'),
            duration: Duration(seconds: 1),
          ));

          bool success = await onSubmit();

          if (success) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WrapperView(),
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ошибка произошла, свяжите с администрацией'),
              duration: Duration(seconds: 3),
            ));
          }
        }
      },
    );
  }
}
