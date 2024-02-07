import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:bip_hip/views/menu/profile/edit_about/birthday_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about/gender_section.dart';

class EditBasicInfoPage extends StatelessWidget {
  EditBasicInfoPage({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

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
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: ksEditBasicInfo.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ),
                body: Column(
                  children: [
                    GenderSection(),
                    BirthdaySection(),
                    Container(
                      color: cWhiteColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoContainer(
                              suffixText: ksLanguage.tr,
                              suffixTextStyle: semiBold18TextStyle(cBlackColor),
                              isAddButton: true,
                              suffixOnPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (profileController.isEditProfileLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (profileController.isEditProfileLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
