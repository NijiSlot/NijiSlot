import 'package:flutter/material.dart';
import 'package:rains/ui/pages/tab_home/home_tab_view.dart';
import 'package:rains/ui/pages/tab_profile/profile_tab_view.dart';

import 'package:get/get.dart';

class MainState {
  ///Select index- responsive
  late RxInt selectedIndex;

  ///PageView page
  late List<Widget> pageList;
  late PageController pageController;

  MainState() {
    //Initialize index
    selectedIndex = 0.obs;
    //PageView page
    pageList = [HomeTabPage(), ProfileTabView()];
    //Page controller
    pageController = PageController();
  }
}
