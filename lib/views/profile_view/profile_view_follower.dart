import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';

class ProfileViewFollower extends StatelessWidget {
  ProfileViewFollower({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final FriendController friendController = Get.find<FriendController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksFollowers.tr,
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
                kH16sizedBox,
                CustomModifiedTextField(
                    borderRadius: h8,
                    controller: profileViewController.followerSearchController,
                    prefixIcon: BipHip.search,
                    // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,//! use it later
                    // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,//! use it later
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
                          itemCount: friendController.friendList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => kH16sizedBox,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                              child: ProfileViewFollowerListWidget(
                                backgroundImage: friendController.friendList[index].profilePicture.toString(),
                                imageSize: h45,
                                name: friendController.friendList[index].fullName ?? ksNA.tr,
                                buttonText: friendController.friendList[index].followStatus == 0 ? ksFollow.tr : ksFollowing.tr,
                                buttonOnPressed: friendController.friendList[index].followStatus == 0 ? null : () async {},
                                buttonColor: cPrimaryColor,
                                textStyle: semiBold12TextStyle(cWhiteColor),
                              ),
                            );
                          },
                        ),
                        kH16sizedBox,
                        if (friendController.friendList.isNotEmpty &&
                            friendController.friendListScrolled.value &&
                            friendController.friendListSubLink.value != null)
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
    );
  }
}

class ProfileViewFollowerListWidget extends StatelessWidget {
  const ProfileViewFollowerListWidget({
    super.key,
    required this.backgroundImage,
    required this.name,
    required this.buttonText,
    required this.buttonOnPressed,
    this.buttonColor,
    this.textStyle,
    this.buttonWidth,
    this.borderColor,
    this.buttonHeight,
    this.subTitle,
    this.imageSize,
  });
  final String backgroundImage;
  final String name;
  final String buttonText;
  final VoidCallback? buttonOnPressed;
  final Color? buttonColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? subTitle;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            kW12sizedBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  subTitle == null
                      ? const SizedBox()
                      : Text(
                          subTitle ?? '',
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                ],
              ),
            ),
            kW20sizedBox,
            CustomElevatedButton(
              label: buttonText,
              onPressed: buttonOnPressed,
              buttonColor: buttonColor,
              textStyle: textStyle,
              buttonHeight: buttonHeight ?? 32,
              buttonWidth: buttonWidth ?? (isDeviceScreenLarge() ? 108 : 112),
              borderColor: borderColor,
            ),
          ],
        ),
      ],
    );
  }
}
