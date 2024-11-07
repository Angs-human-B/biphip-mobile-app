import '../../../../controllers/menu/menu_section_controller.dart';
import '../../../../utils/constants/imports.dart';

class ChangeNameBottomSheetContent extends StatelessWidget {
  const ChangeNameBottomSheetContent({super.key, required this.menuController});
  final MenuSectionController menuController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ksFirstName.tr,
          style: medium16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
          controller: menuController.firstNameEditingController,
          hint: ksFirstName.tr,
          onChanged: (v) {
            menuController.checkCanChangeName();
          },
        ),
        Text(
          ksLastName.tr,
          style: medium16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
          controller: menuController.lastNameEditingController,
          hint: ksLastName.tr,
          onChanged: (v) {
            menuController.checkCanChangeName();
          },
        ),
        kH8sizedBox,
        RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: ksNameChangeWarning.tr,
                  style: regular12TextStyle(cBlackColor)),
              TextSpan(
                  text: ' ${ksLearnMoreAboutStars.tr}',
                  style: regular12TextStyle(cPrimaryColor))
            ]))
      ],
    );
  }
}
