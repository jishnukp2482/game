import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game/presentaion/manager/home_provider.dart';
import 'package:game/presentaion/routes/app_routes.dart';
import 'package:game/presentaion/widgets/custom_print.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkForUpdate();
    super.initState();
  }

  bool inAppUpdateProgress = false;
  Future<void> checkForUpdate() async {
    if (Platform.isAndroid) {
      try {
        final info = await InAppUpdate.checkForUpdate();
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          await InAppUpdate.performImmediateUpdate();
          setState(() {
            inAppUpdateProgress = true;
          });
        }
      } catch (e) {
        customPrint("Update check failed: $e");
      } finally {
        setState(() {
          inAppUpdateProgress = false;
        });
      }
    } else if (Platform.isIOS) {
      UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
      );
    } else {
      customPrint("NO Updates");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
