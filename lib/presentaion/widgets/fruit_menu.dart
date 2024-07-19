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
      return SizedBox(
        height: h * 0.1,
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
          homeProvider.isDragStarted = true;
          debugPrint("isDargStarted ==${homeProvider.isDragStarted}");
        },
        onDraggableCanceled: (velocity, offset) {
          homeProvider.isDragStarted = false;
          debugPrint("isDargCancelled ==${homeProvider.isDragStarted}");
        },
        child: Container(
          width: w * 0.15,
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //       color: AppColors.black.withOpacity(0.5),
            //       blurStyle: BlurStyle.normal,
            //       blurRadius: w * 9,
            //       spreadRadius: 8,
            //       offset: Offset(h * 0.03, w * 0.1)),
            // ],
            // color: Colors.amber,
            image: DecorationImage(
                image: AssetImage(fruitModal.fruitImg), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
