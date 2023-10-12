import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/friends/friends.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class Family extends StatelessWidget {
  Family({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          action: [
            Padding(
              padding: const EdgeInsets.only(right: k20Padding),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () {
                  _profileController.initializeRelationText();
                  Get.toNamed(krAddFamily);
                  // _globalController.commonBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true,
                  //   isSearchShow: true,
                  //   bottomSheetHeight: height * .6,
                  //   content: AddFamilyMemberBottomSheetContent(),
                  //   onPressCloseButton: () {
                  //     Get.back();
                  //   },
                  //   onPressRightButton: () {
                  //     Get.back();
                  //   },
                  //   rightText: ksSend.tr,
                  //   rightTextStyle: medium14TextStyle(cPrimaryColor),
                  //   title: ksAddFamilyMember.tr,
                  //   isRightButtonShow: true,
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
                        '${ksTotalFamilyMembers.tr}: 55',
                        style: semiBold14TextStyle(cBlackColor),
                      )
                    : Text(
                        '${ksFamilyRequests.tr}: 33',
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
            Expanded(
              child: SingleChildScrollView(
                child: _profileController.allReceivedPendingFamilyView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//*All friend list
class AllFamilyList extends StatelessWidget {
  AllFamilyList({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k20Padding),
      child: ListView.builder(
        itemCount: _profileController.allFamilyLists.length,
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
                child: CustomListViewItem(
                  backgroundImage: AssetImage(_profileController.allFriendsLists[index]['image']),
                  name: _profileController.allFriendsLists[index]['name'],
                  icon: BipHip.love,
                  subTitle: ksBrother.tr,
                  firstButtonText: ksMessage.tr,
                  secondButtonText: ksRemove.tr,
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

//*Received family list
class ReceivedFamilyList extends StatelessWidget {
  ReceivedFamilyList({super.key});
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
                  subTitle: ksGotRequestToBeABrother.tr,
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

//*Pending family request list
class PendingFamilyList extends StatelessWidget {
  PendingFamilyList({super.key});
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
            padding: const EdgeInsets.only(bottom: k10Padding),
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
                  subTitle: ksBrotherPending.tr,
                  buttonText: ksCancelRequest.tr,
                  buttonOnPressed: () {},
                  buttonColor: cWhiteColor,
                  borderColor: cRedColor,
                  textStyle: semiBold14TextStyle(cRedColor),
                  buttonWidth: 147,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//*add friend request list in bottom sheet
class AddFamilyMemberBottomSheetContent extends StatelessWidget {
  const AddFamilyMemberBottomSheetContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => CustomSelectionButton(
              hintText: ksSelectRelation.tr,
              text: Get.find<ProfileController>().relation.value == "" ? '' : Get.find<ProfileController>().relation.value,
              onPressed: () {
                unFocus(context);
                Get.find<ProfileController>().initializeSelectedRelationText();
                Get.find<GlobalController>().commonBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isSearchShow: false,
                  bottomSheetHeight: height * .9,
                  content: RelationContent(),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: () {
                    Get.find<ProfileController>().selectRelationTextChange();
                    Get.back();
                  },
                  rightText: ksOk.tr,
                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                  title: ksSelectRelation.tr,
                  isRightButtonShow: true,
                );
              },
            ),
          ),
          kH20sizedBox,
          Row(
            children: [
              Obx(
                () => CustomElevatedButton(
                  isCustomButton: true,
                  label: Get.find<CreatePostController>().postType.value,
                  prefixIcon: Get.find<CreatePostController>().postTypeIcon.value,
                  onPressed: () {
                    unFocus(context);
                    Get.find<CreatePostController>().initializeAudienceText();
                    Get.find<CreatePostController>().showAudienceSheet(context);
                  },
                  buttonHeight: 40,
                  buttonWidth: width * .5,
                  suffixIcon: BipHip.downArrow,
                  buttonColor: cGreyBoxColor,
                  prefixIconColor: cBlackColor,
                  suffixIconColor: cBlackColor,
                  textStyle: medium14TextStyle(cBlackColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RelationContent extends StatelessWidget {
  RelationContent({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _profileController.relationList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: k10Padding),
          child: Obx(
            () => CustomListTile(
              itemColor: _profileController.relationListState[index] ? cPrimaryTint3Color : cWhiteColor,
              onPressed: () {
                _profileController.relationStatusChange(index);
              },
              title: _profileController.relationList[index],
              borderColor: _profileController.relationListState[index] ? cPrimaryColor : cLineColor,
              trailing: CustomRadioButton(
                onChanged: () {
                  _profileController.relationStatusChange(index);
                },
                isSelected: _profileController.relationListState[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
