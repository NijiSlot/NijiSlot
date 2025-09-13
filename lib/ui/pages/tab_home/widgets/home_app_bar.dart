import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rains/commons/app_dimens.dart';
import 'package:rains/ui/widgets/images/app_cache_image.dart';
import 'package:rains/commons/app_colors.dart';
import 'package:rains/commons/app_text_styles.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({
    Key? key,
    String avatarUrl = "",
    VoidCallback? onSearchPressed,
    VoidCallback? onSettingPressed,
  }) : super(
         key: key,
         backgroundColor: AppColors.appBar,
         centerTitle: false,
         titleSpacing: 0.0,
         title: Padding(
           padding: const EdgeInsets.only(left: 25.0),
           child: Text("虹スロ", style: AppTextStyle.sfProS17Semibold),
         ),
         bottom: PreferredSize(
           preferredSize: const Size.fromHeight(1),
           child: Container(height: 0.5, color: AppColors.backgroundDarker),
         ),

         toolbarHeight: AppDimens.appBarHeight,
         actions: [
           IconButton(
             onPressed: () {},
             icon: Icon(Icons.search, size: 26),
             color: Colors.white,
           ),
         ],
       );
}
