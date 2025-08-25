import 'package:flutter/material.dart';

enum MainTab { home, profile }

extension MainTabExtension on MainTab {
  Widget get page {
    switch (this) {
      case MainTab.home:
      // return HomeTabPage();
      // return Container(color: Colors.red,);

      case MainTab.profile:
      // return ProfileTabPage();
    }
    return Container();
  }

  BottomNavigationBarItem get tab {
    switch (this) {
      case MainTab.home:
        return BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'ホーム',
        );

      case MainTab.profile:
        return BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'マイページ',
        );
    }
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.profile:
        return 'Profile';
    }
  }
}
