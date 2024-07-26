import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:game/presentaion/routes/app_pages.dart';
import 'package:game/presentaion/themes/app_assets.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:game/presentaion/themes/local_storage_keys.dart';
import 'package:game/presentaion/widgets/custom_alert.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import '../../domain/enitites/fruit_modal.dart';
import '../../domain/enitites/level_modal.dart';

class HomeProvider extends ChangeNotifier {
  GetStorage getStorage = GetStorage();
  String levelOfUser = "1";
  getLeveOfUser() {
    levelOfUser =
        getStorage.read(LocalStorageKeys.currentLevelOfUser).toString();
    notifyListeners();
  }

  ///Level list
  final levelList = <LevelModal>[
    LevelModal(
        levelID: "1",
        levelMsg: "Put Red Apple inside the Mixer",
        levelFruits: ["Red Apple"],
        levelStatus: false),
    LevelModal(
        levelID: "2",
        levelMsg: "Put Green Apple inside the Mixer",
        levelFruits: ["Green Apple"],
        levelStatus: false),
    LevelModal(
        levelID: "3",
        levelMsg: "Put Mango inside the Mixer",
        levelFruits: ["Mango"],
        levelStatus: false),
    LevelModal(
        levelID: "4",
        levelMsg: "Put WaterMelon inside the Mixer",
        levelFruits: ["WaterMelon"],
        levelStatus: false),
    LevelModal(
        levelID: "5",
        levelMsg: "Put Tomato inside the Mixer",
        levelFruits: ["Tomato"],
        levelStatus: false),
  ];

  ///Fruit List
  final fruitList = <FruitModal>[
    FruitModal("Red Apple", const Color.fromARGB(255, 119, 61, 68),
        AppAssets.redApple),
    FruitModal(
        "Green Apple", Color.fromARGB(255, 18, 90, 56), AppAssets.greenApple),
    FruitModal(
        "WaterMelon", Color.fromARGB(255, 207, 89, 103), AppAssets.waterMelon),
    FruitModal("Mango", Color.fromARGB(255, 176, 160, 17), AppAssets.mango),
    FruitModal(
        "Tomato", Color.fromARGB(255, 170, 56, 7), AppAssets.greenTomato),
    FruitModal("Red Apple", const Color.fromARGB(255, 119, 61, 68),
        AppAssets.redApple),
    FruitModal(
        "Green Apple", Color.fromARGB(255, 18, 90, 56), AppAssets.greenApple),
    FruitModal(
        "WaterMelon", Color.fromARGB(255, 207, 89, 103), AppAssets.waterMelon),
    FruitModal("Mango", Color.fromARGB(255, 176, 160, 17), AppAssets.mango),
    FruitModal(
        "Tomato", Color.fromARGB(255, 170, 56, 7), AppAssets.greenTomato),
  ];

  List<LevelModal> currentUserLevelList = [];
  setNextLevel(context) {
    String currentlevelOfUser =
        (getStorage.read(LocalStorageKeys.currentLevelOfUser)?.toString()) ??
            "0";
    debugPrint("current level of user==${currentlevelOfUser}");
    int tempNextLevelOfUser = int.parse(currentlevelOfUser) + 1;
    debugPrint("temp Next Level Of User==${tempNextLevelOfUser}");
    levelOfUser = tempNextLevelOfUser.toString();
    notifyListeners();

    getStorage.write(LocalStorageKeys.currentLevelOfUser, levelOfUser);
    notifyListeners();

    List<LevelModal> temp = levelList
        .where(
          (element) => element.levelID == levelOfUser,
        )
        .toList();
    currentUserLevelList.clear();
    notifyListeners();
    currentUserLevelList.addAll(temp);
    notifyListeners();
    if (levelOfUser == "6") {
      GoRouter.of(context).go(AppPages.completePage);
      debugPrint("level of user 6");
    }
  }

  bool isDragStarted = false;
  bool isDragging = false;

  void startDragging() {
    isDragging = true;
    notifyListeners();
  }

  void stopDragging() {
    isDragging = false;
    notifyListeners();
  }

  double levelofMixer = 0.0;
  double previouslevelofMixer = 0.0;
  Color colorOfMixer = AppColors.transparent;
  bool isMixerValueLoading = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  getColor(FruitModal fruitModal, context) async {
    debugPrint("Fruite name==${fruitModal.fruitName}");
    isMixerValueLoading = true;
    notifyListeners();
    playMIxerSound();
    levelofMixer = 0.0;
    notifyListeners();
    colorOfMixer = fruitModal.fruitColor;
    for (double i = 0.3; i <= 0.8; i += 0.1) {
      isMixerValueLoading = true;
      previouslevelofMixer = levelofMixer;
      debugPrint("levelofMixer BEFORE update: ${levelofMixer}");
      levelofMixer = i;
      debugPrint("levelofMixer AFTER update: ${levelofMixer}");

      notifyListeners();
      await Future.delayed(Duration(milliseconds: 250));
      isMixerValueLoading = false;
    }
    audioPlayer.stop();
    if (currentUserLevelList.first.levelFruits.contains(fruitModal.fruitName)) {
      showSuccessDialog(context, AppAssets.success, () {
        setNextLevel(context);
        Navigator.of(context).pop();
      }, "Success!", 'Your Level was completed successfully.', AppColors.green,
          "Next");
    } else {
      showSuccessDialog(context, AppAssets.failed, () {
        Navigator.of(context).pop();
      }, "Failed!", 'Level Failed', AppColors.red, "Retry");
    }
  }

  playMIxerSound() {
    audioPlayer.play(AssetSource(AppAssets.mixerMusic));
  }

  restartAll(context) {
    isMixerValueLoading = true;
    levelofMixer = 0.0;
    notifyListeners();
    getStorage.write(LocalStorageKeys.currentLevelOfUser, "0");

    previouslevelofMixer = 0.0;
    isMixerValueLoading = false;
    notifyListeners();
    GoRouter.of(context).go(AppPages.homepage);
  }
}
