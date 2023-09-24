import 'dart:io';
import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/post_widgets/biding_insight.dart';
import 'package:bip_hip/views/profile/post_widgets/biding_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/comment_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/like_section_widget.dart';
import 'package:bip_hip/views/profile/profile_widgets/stories_widget.dart';
import 'package:bip_hip/widgets/common/custom_filter_chips.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
              appBarColor: cWhiteColor,
              title: 'Monjurul Sharker Omi'.tr,
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
                          color: cTransparentColor,
                        ),
                        SizedBox(
                          height: 150,
                          width: width,
                          child: Image.file(
                            _profileController.newCoverImageFile.value,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/images/coverPic.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 20,
                          child: Stack(
                            children: [
                              Container(
                                height: height > kSmallDeviceSizeLimit ? kProfileImageSize : (kProfileImageSize - h10),
                                width: height > kSmallDeviceSizeLimit ? kProfileImageSize : (kProfileImageSize - h10),
                                decoration: BoxDecoration(
                                  color: cGreyBoxColor,
                                  borderRadius: BorderRadius.circular(90),
                                  border: Border.all(color: cGreyBoxColor.withAlpha(500), width: 2),
                                ),
                                child: ClipOval(
                                  child: Image.file(
                                    _profileController.newProfileImageFile.value,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => ClipOval(
                                      child: Image.asset(
                                        'assets/images/profileDefault.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
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
                                        title: 'Upload image',
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
                                  title: 'Upload image',
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
                      ],
                    ),
                    kH10sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Text(
                        'Monjurul Sharker Omi',
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
                            label: 'Add Selfie',
                            buttonHeight: 44,
                            buttonWidth: (width / 2) - 28,
                            prefixIcon: BipHip.camera,
                            textStyle: semiBold18TextStyle(cWhiteColor),
                            onPressed: () {},
                          ),
                          CustomElevatedButton(
                            label: 'Edit Profile',
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
                    for (int i = 0; i < profileInfoContent.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: LinkUpIconTextRow(
                          icon: profileInfoContent[i]['icon'],
                          text: profileInfoContent[i]['text'],
                          isLink: profileInfoContent[i]['isLink'],
                          onPressed: profileInfoContent[i]['onPressed'],
                        ),
                      ),
                    kH12sizedBox,
                    Container(
                      height: h8,
                      width: width,
                      color: cGreyBoxColor,
                    ),
                    FriendsFamilyGridView(header: 'Friends', count: friendList.length.toString(), friendList: friendList),
                    kH12sizedBox,
                    Container(
                      height: h8,
                      width: width,
                      color: cGreyBoxColor,
                    ),
                    FriendsFamilyGridView(header: 'Family', count: familyList.length.toString(), friendList: familyList),
                    Container(
                      height: h8,
                      width: width,
                      color: cGreyBoxColor,
                    ),
                    CustomPostButton(
                      name: 'Monjurul',
                      profilePic: 'assets/images/profilePic.png',
                      onPressed: () {
                        ll('post');
                        Get.toNamed(krCreatePost);
                      },
                    ),
                    Container(
                      height: h8,
                      width: width,
                      color: cGreyBoxColor,
                    ),
                    kH12sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Text(
                        'Catagories',
                        style: semiBold14TextStyle(cBlackColor),
                      ),
                    ),
                    // kH12sizedBox,
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
                                isSelected: (_profileController.interestCatagoriesIndex.value == i && _profileController.isInterestSelected.value),
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
                    Container(
                      height: h8,
                      width: width,
                      color: cGreyBoxColor,
                    ),
                    // kH12sizedBox,
                    const StoriesWidget(),
                    kH12sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: BiddingWidget(
                        totalBids: 25,
                        bidingAmount: 300,
                        bidingOnPressed: () {
                          _globalController.commonBottomSheet(
                              context: context,
                              content: _PlaceBidContent(),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                Get.back();
                              },
                              rightText: 'Send',
                              rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                              title: 'Place a Bid',
                              isRightButtonShow: true,
                              isScrollControlled: true,
                              bottomSheetHeight: height * .4);
                        },
                      ),
                    ),
                    kH12sizedBox,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: CustomDivider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                      ),
                      child: LikeSectionWidget(
                        giftOnPressed: () {
                          _globalController.commonBottomSheet(
                              context: context,
                              content: _BiddingInsightsContent(
                                comment: bidingComments,
                              ),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: null,
                              rightText: '',
                              rightTextStyle: regular10TextStyle(cBlackColor),
                              title: 'Biding Insights',
                              isRightButtonShow: false,
                              isScrollControlled: true,
                              bottomSheetHeight: bidingComments.length <= 3 ? null : height * .7);
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: CustomDivider(),
                    ),
                    kH12sizedBox,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: CommentWidget(
                          profileImage: 'assets/images/pic5.jpeg',
                          comment:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam nisi, cras neque, lorem vel vulputate vitae aliquam. Pretium tristique nisi, ut commodo fames. Porttitor et sagittis egestas vitae metus, odio tristique amet, duis.',
                          timePassed: '30',
                          isLikeButtonShown: true,
                          commentLink: 'https://itnext.io/showing-url-preview-in-flutter-a3ad4ff9927e',
                          isReplyButtonShown: true,
                          isReactButtonShown: true,
                          isLink: true,
                          reactCount: 1234,
                          userName: 'Monjurul Sharker Omi',
                          isSendMessageShown: false,
                          isHideButtonShown: true),
                    ),
                    kH12sizedBox,
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
              CustomTextButton(onPressed: seeAll, text: 'See All', textStyle: semiBold14TextStyle(cPrimaryColor)),
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

class CustomPostButton extends StatelessWidget {
  const CustomPostButton({super.key, this.onPressed, required this.name, required this.profilePic, this.prefixWidget});

  final VoidCallback? onPressed;
  final String name, profilePic;
  final Widget? prefixWidget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPressed,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: k12Padding),
          child: Row(
            children: [
              kW20sizedBox,
              ClipOval(
                child: Container(
                  height: h40,
                  width: h40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    profilePic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              kW12sizedBox,
              Text(
                'What\'s on your mind, $name?',
                style: regular14TextStyle(cIconColor),
              ),
              const Spacer(),
              prefixWidget ?? const SizedBox(),
              kW12sizedBox
            ],
          ),
        ),
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
          label: 'Add photo',
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await _globalController.selectImageSource(isImageChanged, imagePath, imageFile, 'camera');
            if (isImageChanged.value) {
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
          label: 'Choose from gallery',
          prefixIcon: BipHip.photo,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await _globalController.selectImageSource(isImageChanged, imagePath, imageFile, 'gallery');
            if (isImageChanged.value) {
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

class _BiddingInsightsContent extends StatelessWidget {
  const _BiddingInsightsContent({super.key, required this.comment});

  final List comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BidingInsight(highest: 500, lowest: 150),
        kH16sizedBox,
        Text(
          'Bids',
          style: semiBold16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comment.length,
            itemBuilder: (context, index) {
              return CommentWidget(
                  profileImage: comment[index]['image'],
                  timePassed: '5',
                  isLikeButtonShown: true,
                  isReplyButtonShown: false,
                  isReactButtonShown: true,
                  comment: comment[index]['comment'],
                  isLink: false,
                  reactCount: 440,
                  userName: comment[index]['userName'],
                  isSendMessageShown: true,
                  isHideButtonShown: false);
            })
      ],
    );
  }
}

class _PlaceBidContent extends StatelessWidget {
  _PlaceBidContent({super.key});

  final CreatePostController _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended',
              style: regular12TextStyle(cPlaceHolderColor),
            ),
            kH8sizedBox,
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: 10.0,
              children: [
                for (int i = 0; i < recommendedBid.length; i++)
                  CustomChoiceChips(
                    label: '\$${recommendedBid[i]}',
                    borderRadius: k8CircularBorderRadius,
                    isSelected: (_createPostController.selectedBidIndex.value == i),
                    onSelected: (value) {
                      _createPostController.selectedBidIndex.value = i;
                      _createPostController.bidingTextEditingController.text = recommendedBid[i];
                    },
                  )
              ],
            ),
            kH24sizedBox,
            Text(
              'Bid amount',
              style: semiBold14TextStyle(cBlackColor),
            ),
            kH8sizedBox,
            CustomModifiedTextField(
                prefixIcon: Icons.attach_money_rounded, borderRadius: k8BorderRadius, controller: _createPostController.bidingTextEditingController)
          ],
        ));
  }
}
