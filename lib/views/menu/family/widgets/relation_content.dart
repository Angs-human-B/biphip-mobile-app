import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class RelationContent extends StatelessWidget {
  RelationContent({super.key});
  final FamilyController familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: familyController.familyRelationList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: k10Padding),
          child: Obx(
            () => CustomListTile(
              itemColor: familyController.tempRelation.value == familyController.familyRelationList[index].name ? cPrimaryTint3Color : cWhiteColor,
              onPressed: () {
                familyController.tempRelation.value = familyController.familyRelationList[index].name;
                if (familyController.tempRelation.value == '') {
                  familyController.familyRelationBottomSheetRightButtonState.value = false;
                } else {
                 familyController.familyRelationBottomSheetRightButtonState.value= true;
                }
              },
              title: familyController.familyRelationList[index].name,
              borderColor: familyController.tempRelation.value == familyController.familyRelationList[index].name ? cPrimaryColor : cLineColor,
              trailing: CustomRadioButton(
                onChanged: () {
                  familyController.tempRelation.value = familyController.familyRelationList[index].name;
                  if (familyController.tempRelation.value == '') {
                    familyController.familyRelationBottomSheetRightButtonState.value= false;
                  } else {
                    familyController.familyRelationBottomSheetRightButtonState.value= true;
                  }
                },
                isSelected: familyController.tempRelation.value == familyController.familyRelationList[index].name,
              ),
            ),
          ),
        );
      },
    );
  }
}
