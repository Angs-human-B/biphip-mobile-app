import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class Friends extends StatelessWidget {
  Friends({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksFriends.tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
          },
          action: [
            Padding(
              padding: const EdgeInsets.only(right: k20Padding),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () {
                  //*Common bottom sheet for add friend
                  _profileController.searchController.clear();
                  Get.toNamed(krAddFriend);
                  // _globalController.commonBottomSheet(
                  //   context: context,
                  //   isSearchShow: true,
                  //   isScrollControlled: true,
                  //   content: BottomSheetContent(),
                  //   onPressCloseButton: () {
                  //     Get.back();
                  //   },
                  //   onPressRightButton: null,
                  //   rightText: '',
                  //   rightTextStyle: semiBold10TextStyle(cWhiteColor),
                  //   title: ksAddFriend.tr,
                  //   isRightButtonShow: false,
                  //   bottomSheetHeight: height * .9,
                  // );
                },
                child: Text(
                  ksAdd.tr,
                  style: medium14TextStyle(cPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH4sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: TapAbleButtonContainer(
                buttonText: _profileController.tapAbleButtonText,
                buttonState: _profileController.tapAbleButtonState,
                buttonPress: RxList([
                  () {
                    _profileController.toggleType(0);
                  },
                  () {
                    _profileController.toggleType(1);
                  },
                  () {
                    _profileController.toggleType(2);
                  },
                ]),
              ),
            ),
            if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH12sizedBox,
            if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1])
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                child: _profileController.tapAbleButtonState[0]
                    ? Text(
                        '${ksTotalFriends.tr}: 557',
                        style: semiBold14TextStyle(cBlackColor),
                      )
                    : Text(
                        '${ksFriendRequests.tr}: 33',
                        style: semiBold14TextStyle(cBlackColor),
                      ),
              ),
            kH12sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: CustomModifiedTextField(
                borderRadius: h8,
                controller: Get.find<ProfileController>().searchController,

                prefixIcon: BipHip.search,
                suffixIcon: BipHip.voiceFill, // todo:: icon will be changed
                hint: ksSearch.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding),
                textInputStyle: regular16TextStyle(cBlackColor),
              ),
            ),
            kH12sizedBox,
            //*All friend, Receive friend request and Pending friend request ui
            Expanded(
              child: SingleChildScrollView(
                child: _profileController.allReceivedPendingFriendsView(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        width: width,
        isFirstButtonClicked: false,
        isSecondButtonClicked: true,
        isThirdButtonClicked: false,
        isFourthButtonClicked: false,
        isFifthButtonClicked: false,
      ),
    );
  }
}

//*List item content for two button
class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({
    super.key,
    required this.backgroundImage,
    required this.name,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.firstButtonOnPressed,
    required this.secondButtonOnPressed,
    this.icon,
    this.subTitle,
  });
  final ImageProvider backgroundImage;
  final String name;
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback firstButtonOnPressed;
  final VoidCallback secondButtonOnPressed;
  final IconData? icon;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: backgroundImage,
        ),
        Padding(
          padding: const EdgeInsets.only(left: k12Padding),
          child: SizedBox(
            width: width - 105,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: medium16TextStyle(cBlackColor),
                ),
                Row(
                  children: [
                    icon == null
                        ? const SizedBox()
                        : Icon(
                            icon,
                            size: h10,
                            color: cRedColor,
                          ),
                    if (icon != null) kW4sizedBox,
                    subTitle == null
                        ? const SizedBox()
                        : Text(
                            subTitle ?? '',
                            style: regular10TextStyle(cSmallBodyTextColor),
                          ),
                  ],
                ),
                kH4sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      buttonWidth: (width / 2) - h60,
                      buttonHeight: 30,
                      label: firstButtonText,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                      onPressed: () {},
                    ),
                    CustomElevatedButton(
                      buttonWidth: (width / 2) - h60,
                      buttonHeight: 30,
                      label: secondButtonText,
                      onPressed: secondButtonOnPressed,
                      buttonColor: cWhiteColor,
                      borderColor: cRedColor,
                      textStyle: semiBold16TextStyle(cRedColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//*List item content for single button
class CustomSingleButtonListViewItem extends StatelessWidget {
  const CustomSingleButtonListViewItem({
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
  });
  final ImageProvider backgroundImage;
  final String name;
  final String buttonText;
  final VoidCallback buttonOnPressed;
  final Color? buttonColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? subTitle;
  // final BoxDecoration boxDecoration;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: backgroundImage,
            ),
            kW12sizedBox,
            Column(
              children: [
                Text(
                  name,
                  style: medium16TextStyle(cBlackColor),
                ),
                subTitle == null
                    ? const SizedBox()
                    : Text(
                        subTitle ?? '',
                        style: regular10TextStyle(cSmallBodyTextColor),
                      ),
              ],
            ),
            const Spacer(),
            CustomElevatedButton(
              label: buttonText,
              onPressed: buttonOnPressed,
              buttonColor: buttonColor,
              textStyle: textStyle,
              buttonHeight: buttonHeight ?? 32,
              buttonWidth: buttonWidth,
              borderColor: borderColor,
            ),
          ],
        ),
      ],
    );
  }
}

//*All friend list
class AllFriendList extends StatelessWidget {
  AllFriendList({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k20Padding),
      child: ListView.builder(
        itemCount: _profileController.allFriendsLists.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // var _item = _profileController.allFriendsList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: k16Padding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(k8BorderRadius),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () async {
                  // ll(index);
                },
                child: CustomListTile(
                  borderColor: cLineColor,
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(_profileController.allFriendsLists[index]['image']),
                  ),
                  title: Text(
                    _profileController.allFriendsLists[index]['name'],
                    style: semiBold14TextStyle(cBlackColor),
                  ),
                  trailing: CustomIconButton(onPress: () {
                    _globalController.commonBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    content: _FriendActionContent(
                      profileController: _profileController,
                    ),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: null,
                    rightText: ksDone.tr,
                    rightTextStyle: regular14TextStyle(cPrimaryColor),
                    title: ksAddFriend.tr,
                    isRightButtonShow: true,
                    bottomSheetHeight: height * .4,
                  );
                  }, icon: BipHip.system),
                ),
                // child: CustomListViewItem(
                //   backgroundImage: AssetImage(_profileController.allFriendsLists[index]['image']),
                //   name: _profileController.allFriendsLists[index]['name'],
                //   firstButtonText: ksMessage.tr,
                //   secondButtonText: ksRemove.tr,
                //   firstButtonOnPressed: () {},
                //   secondButtonOnPressed: () {},
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//*Received friend list
class ReceivedFriendList extends StatelessWidget {
  ReceivedFriendList({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k20Padding),
      child: ListView.builder(
        itemCount: _profileController.receivedFriendLists.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: k16Padding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(k8BorderRadius),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () async {
                  // ll(index);
                },
                child: CustomListViewItem(
                  backgroundImage: AssetImage(_profileController.allFriendsLists[index]['image']),
                  name: _profileController.allFriendsLists[index]['name'],
                  firstButtonText: ksConfirm.tr,
                  secondButtonText: ksCancel.tr,
                  firstButtonOnPressed: () {},
                  secondButtonOnPressed: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//*Pending friend request list
class PendingFriendList extends StatelessWidget {
  PendingFriendList({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k20Padding),
      child: ListView.builder(
        itemCount: _profileController.pendingFriendLists.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: k16Padding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(k8BorderRadius),
              child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () async {
                    // ll(index);
                  },
                  child: CustomSingleButtonListViewItem(
                    backgroundImage: AssetImage(_profileController.pendingFriendLists[index]['image']),
                    name: _profileController.pendingFriendLists[index]['name'],
                    buttonText: ksCancelRequest.tr,
                    buttonOnPressed: () {},
                    buttonColor: cWhiteColor,
                    borderColor: cRedColor,
                    textStyle: semiBold14TextStyle(cRedColor),
                    buttonWidth: 147,
                  )),
            ),
          );
        },
      ),
    );
  }
}

//*add friend request list in bottom sheet
class BottomSheetContent extends StatelessWidget {
  BottomSheetContent({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _profileController.addFriendLists.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: k10Padding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(k8BorderRadius),
              child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () async {
                    // ll(index);
                  },
                  child: CustomSingleButtonListViewItem(
                    backgroundImage: AssetImage(_profileController.addFriendLists[index]['image']),
                    name: _profileController.addFriendLists[index]['name'],
                    buttonText: ksSendRequest.tr,
                    buttonColor: cPrimaryColor,
                    buttonOnPressed: () {},
                    textStyle: semiBold14TextStyle(cWhiteColor),
                    buttonWidth: 147,
                  )),
            ),
          );
        },
      ),
    );
  }
}



class _FriendActionContent extends StatelessWidget {
  const _FriendActionContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: profileController.linkSourceList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => CustomListTile(
                title: Text(profileController.linkSourceList[index]),
                trailing: CustomRadioButton(
                  onChanged: () {
                    profileController.tempLinkSource.value = profileController.linkSourceList[index];
                  },
                  isSelected: profileController.tempLinkSource.value == profileController.linkSourceList[index],
                ),
                itemColor: profileController.tempLinkSource.value == profileController.linkSourceList[index] ? cPrimaryTint3Color : cWhiteColor,
                onPressed: () {
                  profileController.tempLinkSource.value = profileController.linkSourceList[index];
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
