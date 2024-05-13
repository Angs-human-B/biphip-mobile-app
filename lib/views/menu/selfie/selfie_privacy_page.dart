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
          child: Column(
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: selfieController.privacyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: k8Padding),
                      child: CustomListTile(
                        leading: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: cNeutralColor,
                          ),
                          height: h28,
                          width: h28,
                          child: Icon(
                            selfieController.privacyList[index]['icon'],
                            color: cBlackColor,
                            size: isDeviceScreenLarge() ? h18 : h14,
                          ),
                        ),
                        title: selfieController.privacyList[index]['action'].toString().tr,
                        titleTextStyle: semiBold16TextStyle(cBlackColor),
                        subTitleTextStyle: regular14TextStyle(cBlackColor),
                        itemColor:
                            selfieController.temporarySelectedPrivacyId.value == selfieController.privacyList[index]['id'] ? cPrimaryTint2Color : cWhiteColor,
                        onPressed: () {
                          selfieController.selectedPrivacy.value = selfieController.privacyList[index]['action'];
                          selfieController.temporarySelectedPrivacyId.value = selfieController.privacyList[index]['id'];
                        },
                        trailing: CustomRadioButton(
                          onChanged: () {
                            selfieController.selectedPrivacy.value = selfieController.privacyList[index]['action'];
                            selfieController.temporarySelectedPrivacyId.value = selfieController.privacyList[index]['id'];
                          },
                          isSelected: selfieController.temporarySelectedPrivacyId.value == selfieController.privacyList[index]['id'],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
              Obx(() => CustomElevatedButton(
                    label: ksSave.tr,
                    onPressed: selfieController.temporarySelectedPrivacyId.value != -1
                        ? () async{
                            selfieController.selectedPrivacyId.value = selfieController.temporarySelectedPrivacyId.value;
                            if (selfieController.selectedPrivacyId.value == 5) {
                              Get.toNamed(krSelectPeoplePage);
                              await Get.find<FriendController>().getFriendList();
                            } else {
                              Get.back();
                            }
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
    );
  }
}
