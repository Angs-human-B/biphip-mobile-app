import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/menu.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
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
                  height: 48,
                  onPressed: () {
                    _profileController.firstNameEditingController.text = _profileController.userData.value!.firstName!;
                    _profileController.lastNameEditingController.text = _profileController.userData.value!.lastName!;
                    _globalController.commonBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        content: _ChangeNameBottomSheetContent(
                          profileController: _profileController,
                        ),
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () async {
                          Get.back();
                          await _profileController.changeName();
                        },
                        rightText: ksDone.tr,
                        rightTextStyle: medium14TextStyle(cPrimaryColor),
                        title: ksChangeName.tr,
                        isRightButtonShow: true);
                  },
                  text: 'Change Name',
                  textStyle: semiBold16TextStyle(cBlackColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChangeNameBottomSheetContent extends StatelessWidget {
  const _ChangeNameBottomSheetContent({super.key, required this.profileController});
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ksFirstName.tr,
          style: regular16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
          controller: profileController.firstNameEditingController,
          hint: ksFirstName.tr,
        ),
        Text(
          ksLastName.tr,
          style: regular16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
          controller: profileController.lastNameEditingController,
          hint: ksLastName.tr,
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
