import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/menu.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final MenuSectionController menuController = Get.find<MenuSectionController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: ksSettings.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      CustomMenuContainer(
                        height: 49,
                        trailing: const Icon(
                          BipHip.downArrow,
                          color: cIconColor,
                        ),
                        onPressed: () {
                          menuController.firstNameEditingController.text = globalController.userFirstName.value ?? '';
                          menuController.lastNameEditingController.text = globalController.userLastName.value ?? '';
                          menuController.changeNameBottomSheetButtonState.value = false;
                          globalController.commonBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isBottomSheetRightButtonActive: menuController.changeNameBottomSheetButtonState,
                              content: ChangeNameBottomSheetContent(
                                menuController: menuController,
                              ),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () async {
                                menuController.changeNameBottomSheetButtonState.value = false;
                                unfocus(context);
                                Get.back();
                                await menuController.changeName();
                              },
                              rightText: ksDone.tr,
                              rightTextStyle: medium14TextStyle(cPrimaryColor),
                              title: ksChangeName.tr,
                              isRightButtonShow: true);
                        },
                        text: ksChangeName.tr,
                        textStyle: semiBold16TextStyle(cBlackColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (menuController.isChangeNameLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (menuController.isChangeNameLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

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
          TextSpan(text: ksNameChangeWarning.tr, style: regular12TextStyle(cBlackColor)),
          TextSpan(text: ' ${ksLearnMoreAboutStars.tr}', style: regular12TextStyle(cPrimaryColor))
        ]))
      ],
    );
  }
}
