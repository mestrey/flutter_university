import 'package:dormigram/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:dormigram/wrapper/wrapper_view.dart';
import 'package:dormigram/auth/login_register_view.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  final AuthViewModel _authVM = AuthViewModel();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  _checkToken() async {
    bool isLoggedIn = await _authVM.isLoggedIn();

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? const WrapperView() : LoginRegisterPage(viewModel: _authVM),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Подождите...',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
