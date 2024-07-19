import 'package:flutter/material.dart';
import 'package:game/domain/enitites/fruit_modal.dart';
import 'package:game/presentaion/themes/app_assets.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:game/presentaion/widgets/fruit_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppAssets.bg))),
        child: Padding(
          padding: EdgeInsets.only(top: h * 0.2),
          child: Stack(
            children: [
              Positioned(
                top: h * 0.08,
                left: w * 0.25,
                child: DragTarget<FruitModal>(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      height: h * 0.3,
                      width: w * 0.5,
                      decoration: BoxDecoration(
                          // color: AppColors.black,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AppAssets.mixer))),
                    );
                  },
                  onAcceptWithDetails: (fruitModal) {
                    debugPrint("success");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text(
                              'The fruit has been successfully dropped into the mixer!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
              CustomPaint(
                size: Size(w * 0.4, h * 0.25),
                painter: MixerPainter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MixerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Top-left corner
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width * 0.75,
        size.height - 10); // Bottom-right corner before the arc
    path.arcToPoint(
      Offset(size.width * 0.75 - 10, size.height),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.lineTo(size.width * 0.25 + 10,
        size.height); // Bottom-left corner before the arc
    path.arcToPoint(
      Offset(size.width * 0.25, size.height - 10),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
