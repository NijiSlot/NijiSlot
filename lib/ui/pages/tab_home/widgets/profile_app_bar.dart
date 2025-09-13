import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rains/commons/app_dimens.dart';

class ProfileAppBar extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leading;

  final double height;

  const ProfileAppBar({
    Key? key,
    this.title = "",
    this.titleWidget,
    this.leading,

    this.height = AppDimens.appBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        child: Center(child: titleWidget ?? Text(title)),
      ),
    );
  }
}
