import 'package:flutter/material.dart';

import 'package:dormigram/home/home_view.dart';
import 'package:dormigram/notification/notification_view.dart';
import 'package:dormigram/profile/profile_view.dart';
import 'package:dormigram/task/task_view.dart';

class WrapperView extends StatefulWidget {
  const WrapperView({super.key});

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView> {
  int _currentIndex = 0;

  void goToProfile() {
    setState(() {
      _currentIndex = 3;
    });
  }

  Widget body() {
    switch (_currentIndex) {
      case 0:
        return HomeView(goToProfile: goToProfile);
      case 1:
        return const TaskView();
      case 2:
        return const NotificationView();
      case 3:
        return ProfileView();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedIconTheme: const IconThemeData(color: Color.fromRGBO(202, 205, 219, 1)),
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        items: const [
          BottomNavigationBarItem(label: "Главная", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Задачи", icon: Icon(Icons.task)),
          BottomNavigationBarItem(label: "Сообщения", icon: Icon(Icons.message)),
          BottomNavigationBarItem(label: "Профиль", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
