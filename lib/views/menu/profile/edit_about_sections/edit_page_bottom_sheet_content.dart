import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class EducationBackgroundContent extends StatelessWidget {
  EducationBackgroundContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
                            borderColor: profileController.tempEducationBackground.value == profileController.educationBackgroundList[index]
                                ? cPrimaryColor
                                : cLineColor,
                            trailing: CustomRadioButton(
                              onChanged: () {
                                profileController.tempEducationBackground.value = profileController.educationBackgroundList[index];
                              },
                              isSelected: profileController.tempEducationBackground.value == profileController.educationBackgroundList[index],
                            ),
                            itemColor: profileController.tempEducationBackground.value == profileController.educationBackgroundList[index]
                                ? cPrimaryTint3Color
                                : cWhiteColor,
                            onPressed: () {
                              _editProfileHelper.onSelectEducationBottomSheet(index);
                            },
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
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
                          borderColor: profileController.tempLinkSource.value == profileController.linkSourceList[index] ? cPrimaryColor : cLineColor,
                          trailing: CustomRadioButton(
                            onChanged: () {
                              profileController.tempLinkSource.value = profileController.linkSourceList[index];
                            },
                            isSelected: profileController.tempLinkSource.value == profileController.linkSourceList[index],
                          ),
                          itemColor: profileController.tempLinkSource.value == profileController.linkSourceList[index] ? cPrimaryTint3Color : cWhiteColor,
                          onPressed: () {
                            _editProfileHelper.onSelectLinkBottomSheet(index);
                          },
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
