import 'package:flutter/material.dart';
import 'package:game/presentaion/themes/app_assets.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:game/presentaion/themes/app_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

import '../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _scaleAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();
    Future.delayed(Duration(seconds: 1), () {
      GoRouter.of(context).go(AppPages.homepage);
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: h * 0.7,
            child: RiveAnimation.asset(
              AppAssets.splash,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Text(
                "Fresh Juice",
                style: TextStyle(
                    fontFamily: AppFonts.mistiv,
                    fontSize: w * 0.09,
                    color: AppColors.darkOrange),
              )),
        ],
      ),
    ));
  }
}
