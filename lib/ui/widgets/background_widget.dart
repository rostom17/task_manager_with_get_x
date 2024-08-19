import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key, required this.backGroundChildWidget});

  final Widget backGroundChildWidget;

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetPathsAndUrls.backgroundSVG,
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.fill,
          ),
          widget.backGroundChildWidget,
        ],
      ),
    );
  }
}
