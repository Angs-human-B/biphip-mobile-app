import 'package:bip_hip/controllers/settings/privacy_settings_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/views/dashboard/dashboard_fund_transfer/dashboard_fund_transfer_amount.dart';

import '../../../models/common/common_friend_family_user_model.dart';

class SelectCustomAudience extends StatelessWidget {
  SelectCustomAudience({super.key});

  final DashboardController dashboardController = Get.find<DashboardController>();
  final FriendController friendController = Get.find<FriendController>();
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();


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
            child: CustomAppBar(
              title: ksSelectCustomAudience.tr,
              hasBackButton: true,
              isCenterTitle: true,
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      unFocus(context);
                      privacySettingsController.updateCustomAudience();
                      Get.back();
                    },
                    child: Text(
                      ksDone.tr,
                      style: medium16TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],              onBack: () {
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
                    contentPadding: const EdgeInsets.only(
                        top: k12Padding, bottom: k8Padding),
                    controller: dashboardController.selectPeopleTextEditingController,
                  ),
                ),
                kH8sizedBox,
                Obx(
                      () => (friendController.isFriendListLoading.value)
                      ? const AllPendingFriendShimmer(
                    isBottomSheetShimmer: true,
                  )
                      : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            itemCount: friendController.friendList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (context, index) {
                              final friend = friendController.friendList[index];
                              return InkWell(
                                onTap: () {
                                  // Print the list of selected friends
                                  print(privacySettingsController.selectedCustomAudience.map((f) => f.id).toList());
                                  print(privacySettingsController.selectedCustomAudienceId);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                  child: CustomListTile(
                                      padding: const EdgeInsets.only(
                                          left: k8Padding,
                                          top: k8Padding,
                                          bottom: k8Padding),
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
                                            friend.profilePicture ?? '',
                                            fit: BoxFit.cover,
                                            loadingBuilder: imageLoadingBuilder,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(kiProfileDefaultImageUrl);
                                            },
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        friend.fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      trailing: Obx(
                                            () => Checkbox(
                                          value: privacySettingsController.selectedCustomAudienceId.contains(friend.id),
                                          onChanged: (isChecked) {
                                            if (isChecked == true) {
                                              if (!privacySettingsController.selectedCustomAudienceId.contains(friend.id)) {
                                                privacySettingsController.selectedCustomAudienceId.add(friend.id);
                                              }
                                            } else {
                                              privacySettingsController.selectedCustomAudienceId.remove(friend.id);
                                            }
                                            // print(privacySettingsController.selectedCustomAudienceId.first);
                                          },
                                        ),
                                      ),
                                    ),

                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
