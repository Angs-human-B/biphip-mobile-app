import 'dart:io';
import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/controllers/profile_controllers/menu_section_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/common_post_widget.dart';
import 'package:bip_hip/views/profile/profile_widgets/post_button_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final MenuSectionController _menuController = Get.find<MenuSectionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => _profileController.isProfileLoading.value
            ? const ProfilePageShimmer()
            : SafeArea(
                top: false,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: cGreyBoxColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kAppBarSize),
                    //* info:: appBar
                    child: CustomAppBar(
                      appBarColor: cWhiteColor,
                      title: '${(_profileController.userData.value?.firstName)} ${_profileController.userData.value?.lastName}',
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: SizedBox(
                    height: height,
                    width: width,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 225,
                                  color: cWhiteColor,
                                ),
                                Container(
                                  color: cBlackColor,
                                  height: 150,
                                  width: width,
                                  child: Image.network(
                                    Environment.imageBaseUrl + _profileController.userData.value!.coverPhoto.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      BipHip.imageFile,
                                      size: kIconSize120,
                                      color: cIconColor,
                                    ),
                                    loadingBuilder: imageLoadingBuilder,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 20,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                        width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                        decoration: BoxDecoration(
                                          color: cBlackColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: cWhiteColor.withAlpha(500), width: 2),
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            Environment.imageBaseUrl + _profileController.userData.value!.profilePicture.toString(),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => ClipOval(
                                              child: Image.asset(
                                                kiProfileDefaultImageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            loadingBuilder: imageLoadingBuilder,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 8,
                                        bottom: 15,
                                        child: TextButton(
                                          style: kTextButtonStyle,
                                          onPressed: () {
                                            _profileController.isProfilePicEditor.value = true;
                                            _profileController.resetImage();
                                            _globalController.commonBottomSheet(
                                                context: context,
                                                onPressCloseButton: () {
                                                  Get.back();
                                                },
                                                onPressRightButton: () {},
                                                rightText: '',
                                                rightTextStyle: regular14TextStyle(cBiddingColor),
                                                title: ksUploadImage.tr,
                                                isRightButtonShow: false,
                                                isScrollControlled: false,
                                                bottomSheetHeight: 170,
                                                content: PictureUploadContent(
                                                  isImageChanged: _profileController.isProfileImageChanged,
                                                  imagePath: _profileController.profileImageLink,
                                                  imageFile: _profileController.profileImageFile,
                                                ));
                                          },
                                          child: Container(
                                            height: h28,
                                            width: h28,
                                            decoration: BoxDecoration(
                                              color: cGreyBoxColor,
                                              borderRadius: BorderRadius.circular(26),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: cBlackColor.withAlpha(100),
                                                  offset: const Offset(
                                                    1.0,
                                                    1.0,
                                                  ),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              // border: Border.all(color: cGreyBoxColor.withAlpha(500), width: 2),
                                            ),
                                            child: const Icon(
                                              BipHip.camera,
                                              color: cBlackColor,
                                              size: kIconSize14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //todo: badge
                                      // Positioned(
                                      //   right: 6,
                                      //   top: 10,
                                      //   child: Container(
                                      //       height: h28,
                                      //       width: h28,
                                      //       decoration: BoxDecoration(
                                      //         color: cGreyBoxColor,
                                      //         borderRadius: BorderRadius.circular(26),
                                      //         border: Border.all(color: cPrimaryColor, width: 1),
                                      //       ),
                                      //       child: SvgPicture.asset(kiBadge1SvgImageUrl)),
                                      // ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 16,
                                  bottom: 60,
                                  child: TextButton(
                                    style: kTextButtonStyle,
                                    onPressed: () {
                                      _profileController.isProfilePicEditor.value = false;
                                      _profileController.resetImage();
                                      _globalController.commonBottomSheet(
                                          context: context,
                                          onPressCloseButton: () {
                                            Get.back();
                                          },
                                          onPressRightButton: () {},
                                          rightText: '',
                                          rightTextStyle: regular14TextStyle(cBiddingColor),
                                          title: ksUploadImage.tr,
                                          isRightButtonShow: false,
                                          isScrollControlled: false,
                                          bottomSheetHeight: 170,
                                          content: PictureUploadContent(
                                            isImageChanged: _profileController.isCoverImageChanged,
                                            imagePath: _profileController.coverImageLink,
                                            imageFile: _profileController.coverImageFile,
                                          ));
                                    },
                                    child: Container(
                                      height: h28,
                                      width: h28,
                                      decoration: BoxDecoration(
                                        color: cGreyBoxColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: cBlackColor.withAlpha(100),
                                            offset: const Offset(
                                              0.0,
                                              1.0,
                                            ),
                                            blurRadius: 5.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                      child: const Icon(
                                        BipHip.camera,
                                        color: cBlackColor,
                                        size: kIconSize14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: cWhiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  kH10sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: Text(
                                      '${_profileController.profileData.value!.user!.firstName} ${_profileController.profileData.value!.user!.lastName}',
                                      style: semiBold20TextStyle(cBlackColor),
                                    ),
                                  ),
                                  kH12sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomElevatedButton(
                                          label: ksAddSelfie.tr,
                                          buttonHeight: 44,
                                          buttonWidth: (width / 2) - 28,
                                          prefixIcon: BipHip.camera,
                                          textStyle: semiBold18TextStyle(cWhiteColor),
                                          onPressed: () {},
                                        ),
                                        CustomElevatedButton(
                                          label: ksEditProfile.tr,
                                          onPressed: () {
                                            Get.toNamed(krEditProfile);
                                          },
                                          prefixIcon: BipHip.edit,
                                          prefixIconColor: cBlackColor,
                                          buttonHeight: 44,
                                          buttonWidth: (width / 2) - 28,
                                          buttonColor: cWhiteColor,
                                          textStyle: semiBold18TextStyle(cBlackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  kH16sizedBox,
                                  if (_profileController.currentCityData.value?.city != null && _profileController.currentCityData.value?.isCurrent == 1)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.address,
                                        text: 'Lives in ${_profileController.currentCityData.value?.city}',
                                        isLink: false,
                                        onPressed: null,
                                      ),
                                    ),
                                  if (_profileController.hometownData.value != null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.location,
                                        text: 'From ${_profileController.hometownData.value?.city}',
                                        isLink: false,
                                        onPressed: null,
                                      ),
                                    ),
                                  if (_profileController.profileData.value!.user!.relation != null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.love,
                                        text: checkNullOrStringNull(_profileController.profileData.value!.user!.relation),
                                        isLink: false,
                                        onPressed: null,
                                      ),
                                    ),
                                  if (_profileController.schoolDataList.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.school,
                                        text: checkNullOrStringNull(_profileController.schoolDataList[0].school),
                                        isLink: false,
                                        onPressed: null,
                                      ),
                                    ),
                                  if (_profileController.collegeDataList.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.school,
                                        text: checkNullOrStringNull(_profileController.collegeDataList[0].school),
                                        isLink: false,
                                        onPressed: null,
                                      ),
                                    ),
                                  if (_profileController.workplaceDataList.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.work,
                                        text: checkNullOrStringNull(_profileController.workplaceDataList[0].company),
                                        isLink: false,
                                        onPressed: null,
                                      ),
                                    ),
                                  if (_profileController.emailDataList.isNotEmpty)
                                    // for (int i = 0; i < _profileController.contactDataList.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.mail,
                                        text: checkNullOrStringNull(_profileController.emailDataList[0].value),
                                        isLink: true,
                                        onPressed: null,
                                      ),
                                    ),

                                  //! see more
                                  if (_profileController.emailDataList.isNotEmpty &&
                                      _profileController.contactDataList.length > 1 &&
                                      _profileController.isProfileSeeMore.value)
                                    for (int i = 1; i < _profileController.emailDataList.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                        child: LinkUpIconTextRow(
                                          icon: BipHip.mail,
                                          text: checkNullOrStringNull(_profileController.emailDataList[i].value),
                                          isLink: true,
                                          onPressed: null,
                                        ),
                                      ),
                                  if (_profileController.phoneDataList.isNotEmpty)
                                    // for (int i = 0; i < _profileController.contactDataList.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                      child: LinkUpIconTextRow(
                                        icon: BipHip.phoneFill,
                                        text: checkNullOrStringNull(_profileController.phoneDataList[0].value),
                                        isLink: true,
                                        onPressed: null,
                                      ),
                                    ),
                                  //! see more
                                  if (_profileController.phoneDataList.isNotEmpty &&
                                      _profileController.contactDataList.length > 1 &&
                                      _profileController.isProfileSeeMore.value)
                                    for (int i = 1; i < _profileController.phoneDataList.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                        child: LinkUpIconTextRow(
                                          icon: BipHip.phoneFill,
                                          text: checkNullOrStringNull(_profileController.phoneDataList[i].value),
                                          isLink: true,
                                          onPressed: null,
                                        ),
                                      ),
                                  if (_profileController.linkDataList.isNotEmpty )
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                        child: LinkUpIconTextRow(
                                          icon: _profileController.getLinkIcon(_profileController.linkDataList[0].type.toString()),
                                          text: checkNullOrStringNull(_profileController.linkDataList[0].link),
                                          isLink: true,
                                          onPressed: null,
                                        ),
                                      ),
                                  if (_profileController.linkDataList.isNotEmpty && _profileController.isProfileSeeMore.value)
                                    for (int i = 1; i < _profileController.linkDataList.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                        child: LinkUpIconTextRow(
                                          icon: _profileController.getLinkIcon(_profileController.linkDataList[i].type.toString()),
                                          text: checkNullOrStringNull(_profileController.linkDataList[i].link),
                                          isLink: true,
                                          onPressed: null,
                                        ),
                                      ),
                                  if (_profileController.showSeeMore())
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: k12Padding),
                                      child: CustomElevatedButton(
                                          label: _profileController.isProfileSeeMore.value ? ksShowLess : ksSeeMore,
                                          suffixIcon: _profileController.isProfileSeeMore.value ? BipHip.upArrow : BipHip.downArrow,
                                          suffixIconColor: cBlackColor,
                                          buttonHeight: h28,
                                          buttonWidth: width - 40,
                                          buttonColor: cLineColor,
                                          textStyle: semiBold12TextStyle(cBlackColor),
                                          onPressed: () {
                                            ll(_profileController.phoneDataList.length);
                                            ll(_profileController.contactDataList.length);
                                            ll(_profileController.isProfileSeeMore.value);
                                            _profileController.isProfileSeeMore.value = !_profileController.isProfileSeeMore.value;
                                          }),
                                    ),
                                  // kH12sizedBox
                                ],
                              ),
                            ),
                            kH12sizedBox,
                            Container(
                              color: cWhiteColor,
                              child: FriendsFamilyGridView(
                                header: ksFriends.tr,
                                count: _menuController.friendList.length.toString(),
                                friendList: _menuController.friendList,
                              ),
                            ),
                            kH12sizedBox,
                            Container(
                              color: cWhiteColor,
                              child: FriendsFamilyGridView(
                                header: ksFamily.tr,
                                count: _menuController.familyList.length.toString(),
                                friendList: _menuController.familyList,
                              ),
                            ),
                            kH12sizedBox,
                            Container(
                              color: cWhiteColor,
                              child: CustomPostButton(
                                name: checkNullOrStringNull(_profileController.profileData.value!.user!.firstName) ??
                                    _profileController.profileData.value!.user!.firstName,
                                profilePic: _profileController.profileData.value!.user!.profilePicture.toString(),
                                onPressed: () {
                                  ll('post');
                                  Get.find<CreatePostController>().resetData();
                                  Get.toNamed(krCreatePost);
                                },
                              ),
                            ),
                            kH12sizedBox,
                            Container(
                              color: cWhiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
                                    child: Text(
                                      ksCatagories.tr,
                                      style: semiBold14TextStyle(cBlackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width,
                                    height: 50,
                                    child: ListView.builder(
                                      itemCount: interestProfile.length,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, i) {
                                        return Obx(
                                          () => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                                            child: CustomChoiceChips(
                                              label: interestProfile[i],
                                              isSelected:
                                                  (_profileController.interestCatagoriesIndex.value == i && _profileController.isInterestSelected.value),
                                              onSelected: (value) {
                                                _profileController.interestCatagoriesIndex.value = i;
                                                _profileController.isInterestSelected.value = value;
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kH12sizedBox,
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => kH20sizedBox,
                                itemCount: homePagePost.length,
                                itemBuilder: (context, index) {
                                  var item = homePagePost[index];
                                  return Container(
                                    color: cWhiteColor,
                                    width: width,
                                    child: CommonPostWidget(
                                      isCommented: item['isCommented'],
                                      isLiked: item['isLiked'],
                                      isSharedPost: item['isSharedPost'],
                                      showBottomSection: item['showBottomSection'],
                                      userName: item['userName'],
                                      postTime: item['postTime'],
                                      isCategorized: item['isCategorized'],
                                      isTextualPost: item['isTextualPost'],
                                      category: item['category'],
                                      categoryIcon: item['categoryIcon'],
                                      categoryIconColor: item['categoryIconColor'],
                                      privacy: item['privacy'],
                                      brandName: item['brandName'],
                                      kidName: item['kidName'],
                                      kidAge: item['kidAge'],
                                      title: item['item'],
                                      price: item['price'],
                                      postText: item['postText'],
                                      mediaList: item['mediaList'],
                                      isSelfPost: item['isSelfPost'],
                                      isCommentShown: item['isCommentShown'],
                                    ),
                                  );
                                }),
                            //! comment textfield
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            //   child: CommentTextField(),
                            // ),
                            kHBottomSizedBox
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

//-------------------
//! LinkUpIconTextRow
//-------------------
class LinkUpIconTextRow extends StatelessWidget {
  const LinkUpIconTextRow({super.key, required this.icon, required this.text, required this.isLink, this.onPressed});

  final IconData icon;
  final String text;
  final bool isLink;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: k12Padding),
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: cIconColor,
            ),
            kW12sizedBox,
            Text(
              text,
              style: regular14TextStyle(isLink ? cPrimaryColor : cBlackColor),
            )
          ],
        ),
      ),
    );
  }
}

class FriendsFamilyGridView extends StatelessWidget {
  const FriendsFamilyGridView({super.key, required this.header, required this.count, this.seeAll, required this.friendList});

  final String header;
  final String count;
  final VoidCallback? seeAll;
  final List friendList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          kH12sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                header,
                style: semiBold18TextStyle(cBlackColor),
              ),
              kW8sizedBox,
              Text(
                '$count $header',
                style: regular12TextStyle(cSmallBodyTextColor),
              ),
              const Spacer(),
              CustomTextButton(onPressed: seeAll, text: ksSeeAll.tr, textStyle: semiBold14TextStyle(cPrimaryColor)),
            ],
          ),
          kH12sizedBox,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 3,
              crossAxisSpacing: k10Padding,
              mainAxisSpacing: k4Padding,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = friendList[index];
              return ClipRRect(
                borderRadius: k8CircularBorderRadius,
                child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () {},
                  child: CustomGridViewContainer(
                    item: item,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomGridViewContainer extends StatelessWidget {
  const CustomGridViewContainer({
    Key? key,
    required item,
  })  : _item = item,
        super(key: key);

  final Map _item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: k8CircularBorderRadius,
            child: Image.asset(
              _item['image'],
              height: 100,
              width: ((width - 72) / 3),
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
            ),
          ),
          kH4sizedBox,
          Text(
            _item['name'],
            style: medium12TextStyle(cBlackColor),
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class PictureUploadContent extends StatelessWidget {
  PictureUploadContent({super.key, required this.isImageChanged, required this.imageFile, required this.imagePath});

  final GlobalController _globalController = Get.find<GlobalController>();
  final RxBool isImageChanged;
  final Rx<File> imageFile;
  final RxString imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            var status = await _globalController.selectImageSource(isImageChanged, imagePath, imageFile, 'camera');
            if (status) {
              Get.toNamed(krPhotoPreview);
            }
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CustomElevatedButton(
          label: ksChooseFromGallery.tr,
          prefixIcon: BipHip.photo,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            var status = await _globalController.selectImageSource(isImageChanged, imagePath, imageFile, 'gallery');
            if (status) {
              Get.toNamed(krPhotoPreview);
            }
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}

class ProfilePageShimmer extends StatelessWidget {
  const ProfilePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: cGreyBoxColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kAppBarSize),
          //* info:: appBar
          child: CustomAppBar(
            appBarColor: cWhiteColor,
            title: Shimmer.fromColors(
              baseColor: cWhiteColor,
              highlightColor: Colors.grey,
              child: Container(decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius), height: h20, width: width * 0.6),
            ),
            hasBackButton: true,
            onBack: () {
              Get.back();
            },
          ),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 225,
                      color: cWhiteColor,
                    ),
                    SizedBox(
                        height: 150,
                        width: width,
                        child: Shimmer.fromColors(
                          baseColor: cWhiteColor,
                          highlightColor: Colors.grey,
                          child: Container(
                            color: cWhiteColor,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: Stack(
                        children: [
                          Container(
                            height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                            width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                            decoration: BoxDecoration(
                              color: cGreyBoxColor,
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(color: cGreyBoxColor.withAlpha(500), width: 2),
                            ),
                            child: ClipOval(
                                child: Shimmer.fromColors(
                              baseColor: cWhiteColor,
                              highlightColor: Colors.grey,
                              child: Container(
                                color: cWhiteColor,
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: cWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH10sizedBox,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Shimmer.fromColors(
                            baseColor: cWhiteColor,
                            highlightColor: Colors.grey,
                            child: Container(
                              height: h20,
                              width: width * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          )),
                      kH12sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Shimmer.fromColors(
                              baseColor: cWhiteColor,
                              highlightColor: Colors.grey,
                              child: Container(
                                height: 44,
                                width: (width / 2) - 28,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: cWhiteColor,
                              highlightColor: Colors.grey,
                              child: Container(
                                height: 44,
                                width: (width / 2) - 28,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      kH16sizedBox,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Shimmer.fromColors(
                            baseColor: cWhiteColor,
                            highlightColor: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: Container(
                                height: h20,
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Shimmer.fromColors(
                            baseColor: cWhiteColor,
                            highlightColor: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: Container(
                                height: h20,
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Shimmer.fromColors(
                            baseColor: cWhiteColor,
                            highlightColor: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: Container(
                                height: h20,
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Shimmer.fromColors(
                          baseColor: cWhiteColor,
                          highlightColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: k12Padding),
                            child: Container(
                              height: h20,
                              width: width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                kH12sizedBox,
                Container(
                  color: cWhiteColor,
                  child: const GridViewShimmer(),
                ),
                kH12sizedBox,
                Container(
                  color: cWhiteColor,
                  child: const GridViewShimmer(),
                ),
                kH12sizedBox,
                Container(
                  color: cWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: k12Padding),
                    child: Row(
                      children: [
                        kW20sizedBox,
                        Shimmer.fromColors(
                          baseColor: cWhiteColor,
                          highlightColor: Colors.grey,
                          child: ClipOval(
                            child: Container(
                              height: h40,
                              width: h40,
                              decoration: const BoxDecoration(
                                color: cWhiteColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        kW12sizedBox,
                        Shimmer.fromColors(
                          baseColor: cWhiteColor,
                          highlightColor: Colors.grey,
                          child: Container(
                            height: h20,
                            width: width * 0.6,
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kH12sizedBox,
                Container(
                  color: cWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
                        child: Shimmer.fromColors(
                          baseColor: cWhiteColor,
                          highlightColor: Colors.grey,
                          child: Container(
                            height: h20,
                            width: width * 0.2,
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: 50,
                        child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                              child: Shimmer.fromColors(
                                baseColor: cWhiteColor,
                                highlightColor: Colors.grey,
                                child: CustomChoiceChips(
                                  label: '     ',
                                  isSelected: false,
                                  onSelected: (value) {},
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                kHBottomSizedBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kH12sizedBox,
          Shimmer.fromColors(
            baseColor: cWhiteColor,
            highlightColor: Colors.grey,
            child: Container(
              height: h20,
              width: 60,
              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
            ),
          ),
          kH12sizedBox,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 3,
              crossAxisSpacing: k10Padding,
              mainAxisSpacing: k4Padding,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: k8CircularBorderRadius,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: k8CircularBorderRadius,
                        child: Shimmer.fromColors(
                          baseColor: cWhiteColor,
                          highlightColor: Colors.grey,
                          child: Container(
                            color: cWhiteColor,
                            height: 100,
                            width: ((width - 72) / 3),
                          ),
                        ),
                      ),
                      kH4sizedBox,
                      Shimmer.fromColors(
                        baseColor: cWhiteColor,
                        highlightColor: Colors.grey,
                        child: Container(
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                          height: 12,
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
