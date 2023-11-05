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
              itemColor: _familyController.relationStatusId.value == index ? cPrimaryTint3Color : cWhiteColor,
              onPressed: () {
                _familyController.relationStatusId.value = index;
                if (_familyController.relationStatusId.value == -1) {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                } else {
                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                }
              },
              title: _familyController.familyRelationList[index].name,
              borderColor: _familyController.relationStatusId.value == index ? cPrimaryColor : cLineColor,
              trailing: CustomRadioButton(
                onChanged: () {
                  _familyController.relationStatusId.value = index;
                },
                isSelected: _familyController.relationStatusId.value == index,
              ),
            ),
          ),
        );
      },
    );
  }
}