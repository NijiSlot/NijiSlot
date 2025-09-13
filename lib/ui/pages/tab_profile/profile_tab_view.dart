import 'package:flutter/material.dart';

import 'package:rains/ui/pages/tab_home/enums/home_section.dart';
import 'package:rains/ui/pages/tab_home/movies_section/movies_section_view.dart';
import 'package:rains/ui/pages/tab_home/widgets/profile_app_bar.dart';
import 'package:get/get.dart';
import 'package:rains/commons/app_images.dart';
import 'package:rains/commons/app_colors.dart';
import 'package:rains/commons/app_text_styles.dart';
import '../tab_profile/profile_tab_logic.dart';
import '../tab_profile/profile_tab_state.dart';
import 'package:rains/ui/pages/main/tab/main_tab.dart';
import 'package:rains/ui/pages/main/main_logic.dart';

class ProfileTabView extends StatefulWidget {
  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabView>
    with AutomaticKeepAliveClientMixin {
  final ProfileTabLogic logic = Get.put(ProfileTabLogic());

  final ProfileTabState state = Get.find<ProfileTabLogic>().state;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ProfileTabLogic>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    AppImages.backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    _buildAppBar(),
                    _buildTrendingMovies(),
                    _buildTrendingTvShows(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return ProfileAppBar(
      titleWidget: Obx(
        () => Text(
          MainTab.values[Get.find<MainLogic>().state.selectedIndex.value].title,

          style: AppTextStyle.whiteS18Bold,
        ),
      ),
    );
  }

  Widget _buildTrendingMovies() {
    return MoviesSectionPage(HomeSection.trendingMovies);
  }

  Widget _buildTrendingTvShows() {
    return MoviesSectionPage(HomeSection.trendingTvShows);
  }

  Future<void> _onRefreshData() async {
    // _trendingMoviesCubit.fetchInitialMovies();
    // _trendingTvShowsCubit.fetchInitialMovies();
    // _nowPlayingMoviesCubit.fetchInitialMovies();
    // _upcomingMoviesCubit.fetchInitialMovies();
  }
}
