import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidsAllRelationContent extends StatelessWidget {
  KidsAllRelationContent({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kidsController.relationList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: k10Padding),
          child: Obx(
            () => CustomListTile(
              itemColor: kidsController.temporaryRelation.value == kidsController.relationList[index].name ? cPrimaryTint3Color : cWhiteColor,
              onPressed: () {
                kidsController.temporaryRelation.value = kidsController.relationList[index].name;
                if (kidsController.temporaryRelation.value == '') {
                  kidsController.relationBottomSheetRightButtonState.value = false;
                } else {
                 kidsController.relationBottomSheetRightButtonState.value= true;
                }
              },
              title: kidsController.relationList[index].name,
              borderColor: kidsController.temporaryRelation.value == kidsController.relationList[index].name ? cPrimaryColor : cLineColor,
              trailing: CustomRadioButton(
                onChanged: () {
                  kidsController.temporaryRelation.value = kidsController.relationList[index].name;
                  if (kidsController.temporaryRelation.value == '') {
                    kidsController.relationBottomSheetRightButtonState.value= false;
                  } else {
                    kidsController.relationBottomSheetRightButtonState.value= true;
                  }
                },
                isSelected: kidsController.temporaryRelation.value == kidsController.relationList[index].name,
              ),
            ),
          ),
        );
      },
    );
  }
}