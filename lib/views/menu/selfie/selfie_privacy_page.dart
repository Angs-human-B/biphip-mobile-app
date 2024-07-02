import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SelfiePrivacyPage extends StatelessWidget {
  SelfiePrivacyPage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cWhiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kAppBarSize),
          //* info:: appBar
          child: CustomAppBar(
            title: ksSelfiePrivacy.tr,
            hasBackButton: true,
            isCenterTitle: true,
            onBack: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH16sizedBox,
                Text(
                  "${ksWhoCanSeeYourSelfie.tr}?",
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  ksYourSelfieWillBeVisibleFor24Hour.tr,
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
                kH16sizedBox,
                CustomListTile(
                  leading: Center(
                    child: Icon(
                      BipHip.world,
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: ksPublic.tr,
                  subtitle: ksAnyoneOnBipHip.tr,
                  onPressed: () {
                    selfieController.temporarySelectedPrivacyId.value = 1;
                    selfieController.temporarySelectedPrivacyIcon.value = BipHip.world;
                  },
                  itemColor: selfieController.temporarySelectedPrivacyId.value == 1 ? cPrimaryTint2Color : cWhiteColor,
                  trailing: Center(
                    child: CustomRadioButton(
                      onChanged: () {
                        selfieController.temporarySelectedPrivacyId.value = 1;
                        selfieController.temporarySelectedPrivacyIcon.value = BipHip.world;
                      },
                      isSelected: selfieController.temporarySelectedPrivacyId.value == 1,
                    ),
                  ),
                ),
                kH8sizedBox,
                CustomListTile(
                  leading: Icon(
                    BipHip.friends,
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  ),
                  title: ksFriends.tr,
                  subtitle: ksOnlyYourBipHipFriends.tr,
                  onPressed: () {
                    selfieController.temporarySelectedPrivacyId.value = 2;
                    selfieController.temporarySelectedPrivacyIcon.value = BipHip.friends;
                  },
                  itemColor: selfieController.temporarySelectedPrivacyId.value == 2 ? cPrimaryTint2Color : cWhiteColor,
                  trailing: Center(
                    child: CustomRadioButton(
                      onChanged: () {
                        selfieController.temporarySelectedPrivacyId.value = 2;
                        selfieController.temporarySelectedPrivacyIcon.value = BipHip.friends;
                      },
                      isSelected: selfieController.temporarySelectedPrivacyId.value == 2,
                    ),
                  ),
                ),
                kH8sizedBox,
                CustomListTile(
                  leading: Icon(
                    BipHip.addFamily,
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  ),
                  title: ksFamily.tr,
                  subtitle: ksOnlyYourBipHipFamily.tr,
                  onPressed: () {
                    selfieController.temporarySelectedPrivacyId.value = 3;
                    selfieController.temporarySelectedPrivacyIcon.value = BipHip.addFamily;
                  },
                  itemColor: selfieController.temporarySelectedPrivacyId.value == 3 ? cPrimaryTint2Color : cWhiteColor,
                  trailing: Center(
                    child: CustomRadioButton(
                      onChanged: () {
                        selfieController.temporarySelectedPrivacyId.value = 3;
                        selfieController.temporarySelectedPrivacyIcon.value = BipHip.addFamily;
                      },
                      isSelected: selfieController.temporarySelectedPrivacyId.value == 3,
                    ),
                  ),
                ),
                kH8sizedBox,
                CustomListTile(
                  leading: Icon(
                    BipHip.addFamily,
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  ),
                  title: ksFriendsAndFamily.tr,
                  subtitle: ksOnlyYourBipHipFriendsAndFamily.tr,
                  onPressed: () {
                    selfieController.temporarySelectedPrivacyId.value = 4;
                    selfieController.temporarySelectedPrivacyIcon.value = BipHip.addFamily;
                  },
                  itemColor: selfieController.temporarySelectedPrivacyId.value == 4 ? cPrimaryTint2Color : cWhiteColor,
                  trailing: Center(
                    child: CustomRadioButton(
                      onChanged: () {
                        selfieController.temporarySelectedPrivacyId.value = 4;
                        selfieController.temporarySelectedPrivacyIcon.value = BipHip.addFamily;
                      },
                      isSelected: selfieController.temporarySelectedPrivacyId.value == 4,
                    ),
                  ),
                ),
                kH8sizedBox,
                CustomListTile(
                  leading: Center(
                      child: Icon(
                    BipHip.friends,
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  )),
                  title: ksCustom.tr,
                  alignLeadingWithTitle: false,
                  subtitle: selfieController.customPeopleNames.isNotEmpty ? selfieController.customUserName() : null,
                  onPressed: () async {
                    selfieController.temporarySelectedPrivacyId.value = 5;
                    selfieController.temporarySelectedPrivacyIcon.value = BipHip.friends;
                    Get.toNamed(krSelectPeoplePage);
                    await Get.find<FriendController>().getFriendList();
                    for (int i = 0; i < Get.find<FriendController>().friendList.length; i++) {
                      selfieController.isCustomPeopleSelected.add(false);
                    }
                  },
                  itemColor: selfieController.temporarySelectedPrivacyId.value == 5 ? cPrimaryTint2Color : cWhiteColor,
                  trailing: CustomRadioButton(
                    onChanged: () async {
                      selfieController.temporarySelectedPrivacyId.value = 5;
                      selfieController.temporarySelectedPrivacyIcon.value = BipHip.friends;
                      Get.toNamed(krSelectPeoplePage);
                      await Get.find<FriendController>().getFriendList();
                      for (int i = 0; i < Get.find<FriendController>().friendList.length; i++) {
                        selfieController.isCustomPeopleSelected.add(false);
                      }
                    },
                    isSelected: selfieController.temporarySelectedPrivacyId.value == 5,
                  ),
                ),
                const Spacer(),
                Obx(() => CustomElevatedButton(
                      label: ksSave.tr,
                      onPressed: (selfieController.temporarySelectedPrivacyId.value != 5 || selfieController.customPeopleIds.isNotEmpty)
                          ? () async {
                              selfieController.selectedPrivacyId.value = selfieController.temporarySelectedPrivacyId.value;
                              selfieController.selectedPrivacyIcon.value = selfieController.temporarySelectedPrivacyIcon.value;
                              Get.back();
                            }
                          : null,
                      buttonWidth: width - 40,
                      buttonHeight: h40,
                      textStyle: semiBold14TextStyle(cWhiteColor),
                    )),
                kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
