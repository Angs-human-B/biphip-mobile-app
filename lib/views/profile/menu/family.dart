import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/friends.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/custom_tapable_container.dart';

class Family extends StatelessWidget {
  Family({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
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
                padding: const EdgeInsets.only(right: k10Padding),
                child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      _globalController.commonBottomSheet(
                          context: context,
                          // bottomSheetColor: cWhiteColor,
                          bottomSheetHeight: height,
                          content: AddFamilyMemberBottomSheetContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: null,
                          rightText: '',
                          rightTextStyle: regular10TextStyle(cWhiteColor),
                          title: ksAddFamilyMember.tr,
                          isRightButtonShow: false);
                    },
                    child: Text(
                      ksAdd.tr,
                      style: medium12TextStyle(cPrimaryColor),
                    ))),
          ],
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TapAbleButtonContainer(
                  firstText: ksAll.tr,
                  secondText: ksReceived.tr,
                  thirdText: ksPending.tr,
                  firstButtonOnPressed: () {
                    _profileController.toggleTypeFamily(1);
                  },
                  secondButtonOnPressed: () {
                    _profileController.toggleTypeFamily(2);
                  },
                  thirdButtonOnPressed: () {
                    _profileController.toggleTypeFamily(3);
                  },
                  firstButtonClicked: _profileController.isAllButtonClickedFamily,
                  secondButtonClicked: _profileController.isReceivedButtonClickedFamily,
                ),
                kH12sizedBox,
                _profileController.isAllButtonClickedFamily.value
                    ? Text(
                        '${ksTotalFamilyMembers.tr}: 55',
                        style: semiBold14TextStyle(cBlackColor),
                      )
                    : Text(
                        '${ksFamilyRequests.tr}: 33',
                        style: semiBold14TextStyle(cBlackColor),
                      ),
                kH16sizedBox,
                _profileController.allReceivedPendingFamilyView(),
              ],
            ),
          ),
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
    return SizedBox(
      height: height / 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: k10Padding),
        child: ListView.builder(
          itemCount: _profileController.allFamilyLists.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // var _item = _profileController.allFriendsList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
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
    return SizedBox(
      height: height / 1.5,
      child: ListView.builder(
        itemCount: _profileController.receivedFriendLists.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
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
    return SizedBox(
      height: height / 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: k10Padding),
        child: ListView.builder(
          itemCount: _profileController.pendingFriendLists.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }
}

//*add friend request list in bottom sheet
class AddFamilyMemberBottomSheetContent extends StatelessWidget {
  const AddFamilyMemberBottomSheetContent({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          kH20sizedBox,
          CustomSelectionButton(
            text: ksSelectRelation.tr,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}