import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_logic.dart';
import 'main_state.dart';
import 'tab/main_tab.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainLogic logic = Get.put(MainLogic());
  final MainState state = Get.find<MainLogic>().state;

  final tabs = [MainTab.home, MainTab.profile];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: state.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: state.pageList,
      onPageChanged: (index) {
        logic.switchTap(index);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    return Obx(() {
      return Theme(
        data: theme.copyWith(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          currentIndex: state.selectedIndex.value,
          items: tabs.map((e) => e.tab).toList(),
          onTap: logic.switchTap,
        ),
      );
    });
  }

  @override
  void dispose() {
    Get.delete<MainLogic>();
    super.dispose();
  }
}
