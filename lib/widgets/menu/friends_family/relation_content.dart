import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class RelationContent extends StatelessWidget {
  RelationContent({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _familyController.familyRelationList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: k10Padding),
          child: Obx(
            () => CustomListTile(
              itemColor: _familyController.tempRelation.value == _familyController.familyRelationList[index].name ? cPrimaryTint3Color : cWhiteColor,
              onPressed: () {
                _familyController.tempRelation.value = _familyController.familyRelationList[index].name;
                if (_familyController.tempRelation.value == '') {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                } else {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                }
              },
              title: _familyController.familyRelationList[index].name,
              borderColor: _familyController.tempRelation.value == _familyController.familyRelationList[index].name ? cPrimaryColor : cLineColor,
              trailing: CustomRadioButton(
                onChanged: () {
                  _familyController.tempRelation.value = _familyController.familyRelationList[index].name;
                },
                isSelected: _familyController.tempRelation.value == _familyController.familyRelationList[index].name,
              ),
            ),
          ),
        );
      },
    );
  }
}
