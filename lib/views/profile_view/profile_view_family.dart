import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewFamily extends StatelessWidget {
  ProfileViewFamily({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final FamilyController familyController = Get.find<FamilyController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: cWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                title: ksFamily.tr,
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: SizedBox(
                height: height - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH16sizedBox,
                    Text(
                      "${ksTotalFamilyMembers.tr}: 30",
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                    kH16sizedBox,
                    CustomModifiedTextField(
                        borderRadius: h8,
                        controller: profileViewController.friendSearchController,
                        prefixIcon: BipHip.search,
                        // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,//! use it later
                        // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                        hint: ksSearch.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                        textInputStyle: regular16TextStyle(cBlackColor),
                        onSuffixPress: () {
                          // friendHelper.friendSearchReset();//!craete a new function
                        },
                        onSubmit: (v) {
                          unfocus(context);
                          // friendController.isFriendSuffixIconVisible.value = false;//!Use it later
                        },
                        onChanged: (v) {
                          // friendHelper.searchFriends();//!craete a new function
                        }),
                    Expanded(
                      child: SingleChildScrollView(
                        // controller: .sendFamilyListScrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH16sizedBox,
                            ListView.separated(
                              itemCount: familyController.familyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                  child: Obx(() => ProfileViewFamilyListWidget(
                                        backgroundImage: familyController.familyList[index].profilePicture.toString(),
                                        imageSize: h50,
                                        name: familyController.familyList[index].fullName ?? ksNA.tr,
                                        icon: BipHip.relation,
                                        subTitle: familyController.familyList[index].familyRelationStatus ?? ksNA.tr,
                                      )),
                                );
                              },
                            ),
                            kH16sizedBox,
                            if (familyController.familyList.isNotEmpty &&
                                familyController.familyListScrolled.value &&
                                familyController.familyListSubLink.value != null)
                              const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileViewFamilyListWidget extends StatelessWidget {
  const ProfileViewFamilyListWidget({
    super.key,
    required this.backgroundImage,
    required this.name,
    this.icon,
    this.subTitle,
    this.imageSize,
  });
  final String backgroundImage;
  final double? imageSize;
  final String name;
  final IconData? icon;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: cLineColor,
        ),
        borderRadius: k8CircularBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: imageSize ?? h40,
              width: imageSize ?? h40,
              decoration: const BoxDecoration(
                color: cWhiteColor,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(kiProfileDefaultImageUrl);
                  },
                  loadingBuilder: imageLoadingBuilder,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: k12Padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  Row(
                    children: [
                      icon == null
                          ? const SizedBox()
                          : Icon(
                              icon,
                              size: kIconSize12,
                              color: cRedColor,
                            ),
                      if (icon != null) kW4sizedBox,
                      subTitle == null
                          ? const SizedBox()
                          : Text(
                              subTitle ?? '',
                              style: regular12TextStyle(cSmallBodyTextColor),
                            ),
                    ],
                  ),
                  kH4sizedBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
