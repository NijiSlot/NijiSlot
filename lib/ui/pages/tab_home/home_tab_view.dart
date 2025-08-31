import 'package:flutter/material.dart';
import 'package:rains/services/app_service.dart';
import 'package:rains/ui/pages/tab_home/enums/home_section.dart';
import 'package:rains/ui/pages/tab_home/movies_section/movies_section_view.dart';
import 'package:rains/ui/pages/tab_home/widgets/home_app_bar.dart';
import 'package:get/get.dart';
import 'package:rains/commons/app_images.dart';
import 'package:rains/commons/app_colors.dart';
import 'home_tab_logic.dart';
import 'home_tab_state.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  final HomeTabLogic logic = Get.put(HomeTabLogic());
  final AppService _appService = Get.put(AppService());
  final HomeTabState state = Get.find<HomeTabLogic>().state;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeTabLogic>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return Scaffold(
        appBar: HomeAppBar(avatarUrl: _appService.user.value?.avatarUrl ?? ""),
        body: Stack(
          children: [
            SafeArea(
              child: RefreshIndicator(
                onRefresh: _onRefreshData,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 852,
                        child: Image.asset(
                          AppImages.backgroundImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 852,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(color: AppColors.backgroundDarker),
                      ),

                      Column(
                        children: [
                          _buildTrendingMovies(),
                          _buildTrendingTvShows(),
                          _buildNowPlayingMovies(),
                          _buildUpcomingMovies(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTrendingMovies() {
    return MoviesSectionPage(HomeSection.trendingMovies);
  }

  Widget _buildTrendingTvShows() {
    return MoviesSectionPage(HomeSection.trendingTvShows);
  }

  Widget _buildNowPlayingMovies() {
    return MoviesSectionPage(HomeSection.nowPlayingMovies);
  }

  Widget _buildUpcomingMovies() {
    return MoviesSectionPage(HomeSection.upcomingMovies);
  }

  Future<void> _onRefreshData() async {
    // _trendingMoviesCubit.fetchInitialMovies();
    // _trendingTvShowsCubit.fetchInitialMovies();
    // _nowPlayingMoviesCubit.fetchInitialMovies();
    // _upcomingMoviesCubit.fetchInitialMovies();
  }
}
