import 'package:flutter/material.dart';
import 'package:game/presentaion/manager/home_provider.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../../domain/enitites/fruit_modal.dart';

class Mixer extends StatelessWidget {
  const Mixer({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final shapePainter = ShapePainter();
    return Consumer<HomeProvider>(builder: (context, value, child) {
      print("Value in Ui==${value.levelofMixer}");
      return DragTarget<FruitModal>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            height: h * 0.20,
            width: w * 0.4,
            // color: AppColors.blue,
            child: CustomPaint(
                painter: shapePainter,
                child: LiquidCustomProgressIndicator(
                  value: value.isMixerValueLoading
                      ? value.levelofMixer
                      : value.previouslevelofMixer,
                  valueColor: AlwaysStoppedAnimation(value.colorOfMixer),
                  backgroundColor: Colors.transparent,
                  direction: Axis.vertical,
                  shapePath: shapePainter.path,
                )),
          );
        },
        onAcceptWithDetails: (fruitModal) {
          debugPrint("success");
          value.getColor(fruitModal.data, context);
        },
      );
    });
  }
}

class ShapePainter extends CustomPainter {
  final Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    path.reset(); // Reset path to start fresh

    // Start drawing from the top left corner
    path.moveTo(size.width * 0.1, size.height * 0.15);

    // Draw top edge
    path.lineTo(size.width * 0.88, size.height * 0.15);

    // Draw right curve
    path.quadraticBezierTo(size.width * 0.88, size.height * 0.24,
        size.width * 0.77, size.height * 0.78);

    // Draw right bottom curve
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.85,
        size.width * 0.65, size.height * 0.85);

    // Draw bottom edge
    path.lineTo(size.width * 0.35, size.height * 0.85);

    // Draw left bottom curve
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.85,
        size.width * 0.23, size.height * 0.78);

    // Draw left curve
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.2,
        size.width * 0.1, size.height * 0.15);

    // Close the path
    path.close();

    // Draw the path on canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
