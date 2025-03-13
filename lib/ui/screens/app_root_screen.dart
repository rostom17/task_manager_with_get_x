import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/authentication_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/log_in_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/main_bottom_navigation_screen.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class AppRootScreen extends StatefulWidget {
  const AppRootScreen({super.key});

  @override
  State<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends State<AppRootScreen> {
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = await AuthenticationController.checkAuthenticationState();

    if (mounted) {
      isLoggedIn
          ? Get.offAll(() => const MainBottomNavigationScreen())
          : Get.off(() => const LogInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      backGroundChildWidget: Center(
        child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(AssetPathsAndUrls.appIcon)),
      ),
    );
  }
}
