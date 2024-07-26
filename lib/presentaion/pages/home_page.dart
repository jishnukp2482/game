import 'package:flutter/material.dart';
import 'package:game/presentaion/manager/home_provider.dart';
import 'package:game/presentaion/themes/app_assets.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:game/presentaion/themes/local_storage_keys.dart';
import 'package:game/presentaion/widgets/fruit_menu.dart';
import 'package:game/presentaion/widgets/mixer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
   
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);
        homeProvider.setNextLevel(context);
      },
    );

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeProvider>(builder: (context, value, child) {
          return Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(AppAssets.bg))),
            child: Stack(
              children: [
                Positioned(
                  top: -h * 0.04,
                  left: w * 0.25,
                  child: Container(
                    height: h * 0.3,
                    width: w * 0.5,
                    decoration: BoxDecoration(
                        // color: AppColors.black,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.board))),
                    child: Consumer<HomeProvider>(
                        builder: (context, value, child) {
                      if (value.currentUserLevelList.isEmpty) {
                        return SizedBox.shrink();
                      } else {
                        return Center(
                          child: Text(
                            value.currentUserLevelList.first.levelMsg,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.teko(
                              fontSize: w * 0.075,
                              color: AppColors.brown,
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ),
                Positioned(
                  top: h * 0.28,
                  left: w * 0.25,
                  child: Container(
                    height: h * 0.3,
                    width: w * 0.5,
                    decoration: BoxDecoration(
                        // color: AppColors.black,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.mixer))),
                  ),
                ),
                Positioned(
                  bottom: h * 0.08,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: h * 0.3,
                    width: w,
                    decoration: BoxDecoration(
                        //color: AppColors.black,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.table2))),
                  ),
                ),
                Positioned(bottom: h * 0.33, child: FruitMenu()),
                Positioned(
                  left: h * 0.135,
                  bottom: h * 0.471,
                  child: Mixer(),
                ),
                Positioned(
                  bottom: -h * 0.0001,
                  right: -w * 0.08,
                  child: Container(
                    height: h * 0.2,
                    width: w * 0.5,
                    decoration: BoxDecoration(
                        //  color: AppColors.black,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              AppAssets.board2,
                            ),
                            opacity: 1)),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: w * 0.03, bottom: h * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Level",
                            style: GoogleFonts.teko(
                              // fontFamily: AppFonts.,
                              fontSize: w * 0.075,
                              fontWeight: FontWeight.bold,
                              color: AppColors.brown,
                            ),
                          ),
                          Consumer<HomeProvider>(
                              builder: (context, value, child) {
                            return Text(
                              value.levelOfUser == "6"
                                  ? "0"
                                  : value.levelOfUser,
                              style: GoogleFonts.teko(
                                // fontFamily: AppFonts.mistiv,
                                fontSize: w * 0.09,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brown,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
