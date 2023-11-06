import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profiler_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class GenderSection extends StatelessWidget {
  GenderSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            kH16sizedBox,
            Text(
              ksGender.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            CustomSelectionButton(
              prefixIcon: BipHip.gender,
              onPressed: () async {
                _editProfileHelper.selectGender(context);
              },
              text: _profileController.selectedGender.value != ''
                  ? _profileController.selectedGender.value
                  : checkNullOrStringNull(_profileController.userData.value!.gender) ?? ksSelectGender.tr,
              hintText: ksSelectGender.tr,
            ),
            if (_profileController.isGenderSelected.value) kH12sizedBox,
            if (_profileController.isGenderSelected.value)
              CancelSaveButton(
                onPressedCancel: () {
                  _editProfileHelper.resetGender();
                },
                onPressedSave: () async {
                  _editProfileHelper.saveGender();
                },
              ),
            kH16sizedBox,
          ]),
        ),
      ),
    );
  }
}

class GenderListContent extends StatelessWidget {
  const GenderListContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            profileController.genderList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.genderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(bottom: k8Padding),
                          child: CustomListTile(
                            borderColor: profileController.tempSelectedGender.value == profileController.genderList[index] ? cPrimaryColor : cLineColor,
                            title: profileController.genderList[index],
                            trailing: CustomRadioButton(
                              onChanged: () {
                                profileController.tempSelectedGender.value = profileController.genderList[index];
                              },
                              isSelected: profileController.tempSelectedGender.value == profileController.genderList[index],
                            ),
                            itemColor: profileController.tempSelectedGender.value == profileController.genderList[index] ? cPrimaryTint3Color : cWhiteColor,
                            onPressed: () {
                              profileController.tempSelectedGender.value = profileController.genderList[index];
                            },
                          ),
                        ),
                      );
                    },
                  )
                : EmptyView(
                    height: isDeviceScreenLarge() ? 185 : 170,
                    title: ksNoDataAvailable.tr,
                  ),
          ],
        ));
  }
}
