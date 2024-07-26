import 'package:flutter/material.dart';
import 'package:game/domain/enitites/fruit_modal.dart';
import 'package:game/presentaion/manager/home_provider.dart';
import 'package:game/presentaion/themes/app_colors.dart';
import 'package:provider/provider.dart';

class FruitMenu extends StatelessWidget {
  const FruitMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return Container(
        // color: AppColors.black,
        height: h * 0.1,
        width: w,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: value.fruitList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return FruitItem(fruitModal: value.fruitList[index]);
          },
        ),
      );
    });
  }
}

class FruitItem extends StatelessWidget {
  const FruitItem({super.key, required this.fruitModal});
  final FruitModal fruitModal;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Draggable<FruitModal>(
        data: fruitModal,
        feedback: Container(
          height: h * 0.1,
          width: w * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(fruitModal.fruitImg), fit: BoxFit.contain),
          ),
        ),
        childWhenDragging: SizedBox(
          height: h * 0.1,
          width: w * 0.15,
        ),
        onDragStarted: () {
          if (!homeProvider.isDragging) {
            homeProvider.isDragStarted = true;
            homeProvider.startDragging();
            debugPrint("isDargStarted ==${homeProvider.isDragStarted}");
          }
        },
        onDraggableCanceled: (velocity, offset) {
          homeProvider.stopDragging();
          homeProvider.isDragStarted = false;
          debugPrint("isDargCancelled ==${homeProvider.isDragStarted}");
        },
        onDragEnd: (details) {
          homeProvider.stopDragging();
          homeProvider.isDragStarted = false;
          debugPrint("isDragEnd ==${homeProvider.isDragStarted}");
        },
        child: Container(
          width: w * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(fruitModal.fruitImg), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
