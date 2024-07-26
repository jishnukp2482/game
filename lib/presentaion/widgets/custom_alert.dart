import 'package:flutter/material.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:rive/rive.dart';

void showSuccessDialog(
  BuildContext context,
  final String filePath,
  final void Function()? onPressed,
  final String title,
  final String content,
  final Color buttonColor,
  final String buttonName,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double h = MediaQuery.of(context).size.height;
      double w = MediaQuery.of(context).size.width;
      return AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: h * 0.15,
              width: w * 0.5,
              child: RiveAnimation.asset(
                filePath, // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onPressed!(); // Close the dialog
                // Add your "Next" action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  buttonName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
