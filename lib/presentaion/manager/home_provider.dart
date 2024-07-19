import 'package:flutter/material.dart';
import 'package:game/presentaion/themes/app_assets.dart';
import 'package:game/presentaion/themes/app_colors.dart';

import '../../domain/enitites/fruit_modal.dart';

class HomeProvider extends ChangeNotifier {
  final fruitList = <FruitModal>[
    FruitModal("Red Apple", AppColors.red, AppAssets.redApple),
    FruitModal("Green Apple", AppColors.green, AppAssets.greenApple),
    FruitModal("WaterMelon", AppColors.red, AppAssets.waterMelon),
    FruitModal("Mango", AppColors.yellow, AppAssets.mango),
    FruitModal("Green Tomato", AppColors.green, AppAssets.greenTomato),
  ];

  bool isDragStarted = false;
}
