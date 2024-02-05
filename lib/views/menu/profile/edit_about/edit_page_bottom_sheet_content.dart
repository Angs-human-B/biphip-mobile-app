import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class EducationBackgroundContent extends StatelessWidget {
  EducationBackgroundContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;
  final EditProfileHelper editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          profileController.educationBackgroundList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileController.educationBackgroundList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: k8Padding),
                      child: Obx(() => CustomListTile(
                            title: profileController.educationBackgroundList[index],
                            borderColor: profileController.temporaryEducationBackground.value == profileController.educationBackgroundList[index]
                                ? cPrimaryColor
                                : cLineColor,
                            onPressed: () {
                              editProfileHelper.onSelectEducationBottomSheet(index);
                            },
                            trailing: CustomRadioButton(
                              onChanged: () {
                                editProfileHelper.onSelectEducationBottomSheet(index);
                              },
                              isSelected: profileController.temporaryEducationBackground.value == profileController.educationBackgroundList[index],
                            ),
                            itemColor: profileController.temporaryEducationBackground.value == profileController.educationBackgroundList[index]
                                ? cPrimaryTint3Color
                                : cWhiteColor,
                          )),
                    );
                  },
                )
              : EmptyView(
                  height: 140,
                  title: ksNoDataAvailable.tr,
                ),
        ],
      ),
    );
  }
}

class LinkListContent extends StatelessWidget {
  LinkListContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;
  final EditProfileHelper editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          profileController.linkSourceList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileController.linkSourceList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(bottom: k8Padding),
                        child: CustomListTile(
                          title: profileController.linkSourceList[index],
                          borderColor: profileController.temporaryLinkSource.value == profileController.linkSourceList[index] ? cPrimaryColor : cLineColor,
                          onPressed: () {
                            editProfileHelper.onSelectLinkBottomSheet(index);
                          },
                          trailing: CustomRadioButton(
                            onChanged: () {
                              // profileController.tempLinkSource.value = profileController.linkSourceList[index];
                              editProfileHelper.onSelectLinkBottomSheet(index);
                            },
                            isSelected: profileController.temporaryLinkSource.value == profileController.linkSourceList[index],
                          ),
                          itemColor: profileController.temporaryLinkSource.value == profileController.linkSourceList[index] ? cPrimaryTint3Color : cWhiteColor,
                        ),
                      ),
                    );
                  },
                )
              : EmptyView(
                  height: height * 0.8,
                  title: ksNoDataAvailable.tr,
                ),
        ],
      ),
    );
  }
}
