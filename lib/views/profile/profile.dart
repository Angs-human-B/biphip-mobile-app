import 'dart:io';
import 'package:bip_hip/controllers/post_reaction_controller.dart';

import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/post_widgets/biding_insight.dart';
import 'package:bip_hip/views/profile/post_widgets/biding_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/comment_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/like_section_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/post_activity_status_widget.dart';
import 'package:bip_hip/views/profile/profile_widgets/stories_widget.dart';
import 'package:bip_hip/widgets/common/custom_filter_chips.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                              Positioned(
                                right: 8,
                                top: 15,
                                child: Container(
                                    height: h28,
                                    width: h28,
                                    decoration: BoxDecoration(
                                      color: cGreyBoxColor,
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(color: cPrimaryColor, width: 1),
                                    ),
                                    child: SvgPicture.asset('assets/svg/badge1.svg')),
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
                        Get.find<CreatePostController>().resetData();
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
                        isPlaceBid: true,
                      ),
                    ),
                    kH12sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: BiddingWidget(
                        totalBids: 25,
                        bidingAmount: 300,
                        isPlaceBid: false,
                        bidingOnPressed: () {
                          _globalController.blankBottomSheet(
                              context: context,
                              content: _BiddingInsightsContent(
                                comment: bidingComments,
                              ),
                              isScrollControlled: true,
                              bottomSheetHeight: height * 0.6);
                        },
                      ),
                    ),
                    kH12sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: PostActivityStatusWidget(
                        reactCount: 440,
                        reactionOnPressed: () {
                          // _postReactionController.initalize();
                          _postReactionController.giftFilter(0);
                          _globalController.blankBottomSheet(
                              context: context, content: _BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                        },
                        giftCount: 50,
                        commentCount: 200,
                        shareCount: 340,
                        isGiftShown: true,
                        giftOnPressed: () {
                          _postReactionController.giftFilter(0);
                          _globalController.blankBottomSheet(
                              context: context, content: _BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                        },
                      ),
                    ),
                    kH8sizedBox,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: CustomDivider(),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                      ),
                      child: LikeSectionWidget(
                        isGiftShown: true,
                        giftOnPressed: () {
                          _globalController.blankBottomSheet(
                              context: context, content: _GiftContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: CustomDivider(),
                    ),
                    kH12sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: CommentWidget(
                        profileImage: 'assets/images/pic5.jpeg',
                        comment:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam nisi, cras neque, lorem vel vulputate vitae aliquam. Pretium tristique nisi, ut commodo fames. Porttitor et sagittis egestas vitae metus, odio tristique amet, duis.',
                        timePassed: '30',
                        isLikeButtonShown: true,
                        commentLink: 'https://itnext.io/showing-url-preview-in-flutter-a3ad4ff9927e',
                        isReplyButtonShown: true,
                        isReactButtonShown: true,
                        isImageComment: true,
                        image: kiDummyImage3ImageUrl,
                        isLink: false,
                        reactCount: 1234,
                        userName: 'Monjurul Sharker Omi',
                        isSendMessageShown: false,
                        isHideButtonShown: true,
                        replyList: replyComment,
                      ),
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
        SizedBox(
          height: 350,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
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
                  isImageComment: false,
                  isSendMessageShown: true,
                  isHideButtonShown: false,
                  replyList: [],
                );
              }),
        )
      ],
    );
  }
}

class _PlaceBidContent extends StatelessWidget {
  _PlaceBidContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();

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
                    isSelected: (_postReactionController.selectedBidIndex.value == i),
                    onSelected: (value) {
                      _postReactionController.selectedBidIndex.value = i;
                      _postReactionController.bidingTextEditingController.text = recommendedBid[i];
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
                prefixIcon: Icons.attach_money_rounded, borderRadius: k8BorderRadius, controller: _postReactionController.bidingTextEditingController)
          ],
        ));
  }
}

class _GiftContent extends StatelessWidget {
  _GiftContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h40,
                  width: h40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset('assets/images/profileDefault.png'),
                ),
                kW12sizedBox,
                SizedBox(
                  height: 40,
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Support ', style: regular12TextStyle(cBlackColor)),
                          //TODO: Referal name here
                          TextSpan(
                            text: 'Monjurul Sharker Omi',
                            style: semiBold12TextStyle(cBlackColor),
                          ),
                          TextSpan(
                            text: '\nby sending stars',
                            style: regular12TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            kH8sizedBox,
            Text(
              'Stars let this creator earn money so that they can continue \nmaking content that you love.',
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Text(
              'All Stars',
              style: semiBold14TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            SizedBox(
              height: 380,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: giftPackages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .8,
                  crossAxisCount: 3,
                  crossAxisSpacing: k16Padding,
                  mainAxisSpacing: k16Padding,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      _postReactionController.selectedPackage.value = giftPackages[index];
                      _postReactionController.selectedGiftIndex.value = index;
                      _postReactionController.isPackageSelected.value = true;
                    },
                    child: PackageGridViewContainer(
                      index: index,
                    ),
                  );
                },
              ),
            ),
            kH24sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset('assets/images/profileDefault.png'),
                  ),
                ),
                kW12sizedBox,
                SizedBox(
                  width: 315,
                  child: CustomModifiedTextField(
                      hint: 'Add a comment....',
                      inputAction: TextInputAction.done,
                      contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
                      borderRadius: 8,
                      controller: _postReactionController.giftTextEditingController),
                ),
              ],
            ),
            kH16sizedBox,
            CustomElevatedButton(
                label: 'Get Stars',
                buttonWidth: width - 40,
                onPressed: _postReactionController.isPackageSelected.value
                    ? () {
                        _globalController.commonBottomSheet(
                            context: context,
                            content: _PurchaseStarContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: null,
                            rightText: '',
                            rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                            title: 'Purchase Star',
                            isRightButtonShow: false,
                            isScrollControlled: true,
                            bottomSheetHeight: height * .9);
                      }
                    : null)
          ],
        ));
  }
}

class PackageGridViewContainer extends StatelessWidget {
  PackageGridViewContainer({
    Key? key,
    required index,
  })  : _index = index,
        super(key: key);

  final int _index;
  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: k8CircularBorderRadius,
            color: (_postReactionController.selectedGiftIndex.value == _index) ? cPrimaryTint3Color : cWhiteColor,
            border: Border.all(color: (_postReactionController.selectedGiftIndex.value == _index) ? cPrimaryColor : cLineColor)),
        child: Padding(
          padding: const EdgeInsets.all(k16Padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: k8CircularBorderRadius,
                child: SvgPicture.asset(
                  giftPackages[_index]['badge'],
                  fit: BoxFit.fill,
                ),
              ),
              kH4sizedBox,
              Text(
                giftPackages[_index]['packageName'],
                style: semiBold14TextStyle(cBlackColor),
              ),
              kH4sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    BipHip.giftNew,
                    color: cSecondaryColor,
                    size: kIconSize12,
                  ),
                  kW4sizedBox,
                  Text(
                    giftPackages[_index]['amount'],
                    style: regular10TextStyle(cBlackColor),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurchaseStarContent extends StatelessWidget {
  _PurchaseStarContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Your current balance (${_postReactionController.balance} of 200)',
                style: regular12TextStyle(cIconColor),
              ),
              IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    BipHip.info,
                    size: kIconSize14,
                    color: cIconColor,
                  ))
            ],
          ),
          kH4sizedBox,
          Container(
            height: 44,
            width: width,
            decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  BipHip.giftNew,
                  color: cSecondaryColor,
                  size: kIconSize16,
                ),
                Text(
                  '${_postReactionController.balance}',
                  style: semiBold20TextStyle(cBlackColor).copyWith(foreground: Paint()..shader = linearGradient),
                ),
                Text(
                  ' Stars',
                  style: regular12TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
          ),
          kH24sizedBox,
          const CustomDivider(),
          kH16sizedBox,
          Text(
            'Your current balance (${_postReactionController.balance} of 200)',
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          CustomListTile(
            title: '${_postReactionController.selectedPackage.value!['amount']} stars',
            borderColor: cPrimaryColor,
            itemColor: cPrimaryTint2Color,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$${_postReactionController.selectedPackage.value!['cost']}',
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Radio(
                  value: 0,
                  groupValue: 0,
                  onChanged: (v) {},
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                ),
              ],
            ),
          ),
          kH16sizedBox,
          const CustomDivider(),
          kH16sizedBox,
          Text(
            'All stars',
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Stars that you purchase here are kept in your balance. You can send stars from your balance at any time. ',
                  style: regular12TextStyle(cBlackColor),
                ),
                TextSpan(
                  text: 'Learn more about Stars.',
                  style: regular12TextStyle(cPrimaryColor),
                ),
              ],
            ),
          ),
          kH16sizedBox,
          SizedBox(
            height: 230,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      title: '${packages[index]['amount']} stars',
                      borderColor: _postReactionController.selectedPackage.value == packages[index] ? cPrimaryColor : cLineColor,
                      itemColor: _postReactionController.selectedPackage.value == packages[index] ? cPrimaryTint3Color : cWhiteColor,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${packages[index]['cost']}',
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                          Radio(
                            value: packages[index],
                            groupValue: _postReactionController.selectedPackage.value,
                            onChanged: (v) {
                              _postReactionController.selectedPackage.value = v;
                            },
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          kH20sizedBox,
          const CustomDivider(),
          kH8sizedBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _postReactionController.giftCheckBox.value,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (v) {
                  _postReactionController.giftCheckBox.value = !_postReactionController.giftCheckBox.value;
                },
              ),
              kW8sizedBox,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'I agree with the ', style: regular12TextStyle(cBlackColor)),
                    TextSpan(text: 'terms & condition', style: regular12TextStyle(cPrimaryColor))
                  ],
                ),
              ),
            ],
          ),
          kH10sizedBox,
          CustomElevatedButton(
              label: _postReactionController.balance < int.parse(_postReactionController.selectedPackage.value!['amount'])
                  ? 'Buy ${_postReactionController.selectedPackage.value!['amount']} stars'
                  : 'Give ${_postReactionController.selectedPackage.value!['amount']} stars',
              buttonHeight: 42,
              buttonWidth: width - 40,
              onPressed: () {})
        ],
      ),
    );
  }
}

class _BadgeTabViewContent extends StatelessWidget {
  _BadgeTabViewContent({super.key});

  final PostReactionController _postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Obx(
        () => Column(
          children: [
            TabBar(
              controller: _postReactionController.tabController,
              // onTap: (index) {
              //   _postReactionController.giftFilter(index);

              //   // ll(i);
              // },
              isScrollable: true,
              tabs: [
                const ReactionBottomSheetTab(
                  isReactionImageShown: false,
                  reactionImage: '',
                  text: 'All',
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge1.svg',
                  text: _postReactionController.badgeCount1.value.toString(),
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge2.svg',
                  text: _postReactionController.badgeCount2.value.toString(),
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge3.svg',
                  text: _postReactionController.badgeCount3.value.toString(),
                ),
                ReactionBottomSheetTab(
                  isReactionImageShown: true,
                  reactionImage: 'assets/svg/badge4.svg',
                  text: _postReactionController.badgeCount4.value.toString(),
                ),
              ],
            ),
            SizedBox(
              height: (height * 0.9) - 90,
              width: width - 40,
              child: TabBarView(controller: _postReactionController.tabController, children: [
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
                ReactionTabPage(list: _postReactionController.gift1),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionBottomSheetTab extends StatelessWidget {
  const ReactionBottomSheetTab({super.key, required this.isReactionImageShown, required this.reactionImage, required this.text});

  final bool isReactionImageShown;
  final String reactionImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          if (isReactionImageShown)
            SvgPicture.asset(
              reactionImage,
              width: 20,
            ),
          if (isReactionImageShown) kW8sizedBox,
          Text(
            text,
            style: isReactionImageShown ? regular12TextStyle(cBlackColor) : semiBold12TextStyle(cBlackColor),
          )
        ],
      ),
    );
  }
}

class ReactionTabPage extends StatelessWidget {
  const ReactionTabPage({super.key, required this.list});
  final List list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var item = list[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                leading: Stack(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipOval(
                        child: Image.asset(item['image']),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          item['giftImage'],
                          height: 16,
                          width: 16,
                        ))
                  ],
                ),
                title: Text(
                  item['name'],
                  style: semiBold14TextStyle(cBlackColor),
                ),
                trailing: item['isFriend']
                    ? Text(
                        'Message',
                        style: regular14TextStyle(cPrimaryColor),
                      )
                    : Text(
                        'Add Friend',
                        style: regular14TextStyle(cPrimaryColor),
                      ),
              ),
            );
          }),
    );
  }
}
