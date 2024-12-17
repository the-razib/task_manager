import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/splas_screen_controller.dart';
import 'package:task_manager_with_getx/ui/screens/main_bottom_nav_ber_screen.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/utils/asstes_path.dart';
import 'package:task_manager_with_getx/ui/widgets/background_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String name = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final SplashScreenController splashScreenController =
  Get.put(SplashScreenController());

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  Future<void> _moveToNextScreen() async {
    final bool result = await splashScreenController.moveToNextScreen();
    if (result) {
      Get.offAllNamed(MainBottomNavBerScreen.name);
    } else {
      Get.offAllNamed(SignInScreen.name);
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define a scale animation
    _scaleAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack);

    // Start the animation
    _animationController.forward();

    // Move to the next screen after the animation completes
    _moveToNextScreen();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset(
                  AssetsPath.logoSVG,
                  width: 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
