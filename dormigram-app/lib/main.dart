import 'package:flutter/material.dart';

import 'package:dormigram/auth/startup_view.dart';

void main() {
  runApp(const Dormigram());
}

class Dormigram extends StatelessWidget {
  const Dormigram({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dormigram',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(17, 82, 253, 1),
      ),
      debugShowCheckedModeBanner: false,
      home: const StartupPage(),
    );
  }
}
