import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/views/dashboard/dashboard_fund_transfer/dashboard_fund_transfer_amount.dart';

class DashboardSelectPeople extends StatelessWidget {
  DashboardSelectPeople({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();
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
              title: ksSelectPeople.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                unFocus(context);
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                SizedBox(
                  child: CustomModifiedTextField(
                    prefixIcon: BipHip.search,
                    hint: ksSearch.tr,
                    contentPadding: const EdgeInsets.only(top: k12Padding, bottom: k8Padding),
                    controller: dashboardController.selectPeopleTextEditingController,
                  ),
                ),
                kH8sizedBox,
                Obx(
                  () => (Get.find<FriendController>().isFriendListLoading.value)
                      ? const AllPendingFriendShimmer(
                          isBottomSheetShimmer: true,
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            // controller: friendController.friendListScrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  itemCount: friendController.friendList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => kH16sizedBox,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        dashboardController.resetDashboardFundTransferData();
                                        Get.to(() => DashboardFundTransferAmount(
                                              userImage: friendController.friendList[index].profilePicture,
                                              userName: friendController.friendList[index].fullName,
                                              familyRelationStatus: friendController.friendList[index].familyRelationStatus,
                                            ));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(k8BorderRadius),
                                        child: Obx(
                                          () => CustomListTile(
                                            padding: const EdgeInsets.only(left: k8Padding, top: k8Padding, bottom: k8Padding),
                                            borderColor: cLineColor,
                                            leading: Container(
                                              height: h40,
                                              width: h40,
                                              decoration: const BoxDecoration(
                                                color: cWhiteColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipOval(
                                                child: Image.network(
                                                  friendController.friendList[index].profilePicture.toString(),
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: imageLoadingBuilder,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(kiProfileDefaultImageUrl);
                                                  },
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              friendController.friendList[index].fullName ?? ksNA.tr,
                                              style: semiBold16TextStyle(cBlackColor),
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Icon(
                                                  friendController.friendList[index].familyRelationStatus == null ? BipHip.friends : BipHip.relation,
                                                  size: kIconSize12,
                                                  color: friendController.friendList[index].familyRelationStatus == null ? cBlackColor : cRedColor,
                                                ),
                                                kW4sizedBox,
                                                Text(
                                                  friendController.friendList[index].familyRelationStatus ?? ksFriend.tr,
                                                  style: regular12TextStyle(cSmallBodyTextColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                //   if (friendController.friendList.isNotEmpty &&
                                //       friendController.friendListScrolled.value &&
                                //       friendController.friendListSubLink.value != null)
                                //     const Center(child: CircularProgressIndicator()),
                              ],
                            ),
                          ),
                        ),

                  // ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
