import 'package:flutter/material.dart';
import 'package:game/presentaion/manager/home_provider.dart';
import 'package:game/presentaion/themes/app_assets.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.yellow,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.8,
                  width: w,
                  child: RiveAnimation.asset(
                    AppAssets.restart,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                ElevatedButton(
                  
                  onPressed: () {
                    homeProvider.restartAll(context);
                  },
                  child: Text("Restart"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white),
                ),
              ],
            )));
  }
}
