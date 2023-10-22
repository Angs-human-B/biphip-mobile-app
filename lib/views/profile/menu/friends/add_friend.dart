import 'package:bip_hip/controllers/friend_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/friends/friends.dart';

class AddFriend extends StatelessWidget {
  AddFriend({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FriendController _friendController = Get.find<FriendController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksAddFriend.tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            _profileController.searchController.clear();
            FocusScope.of(context).unfocus();
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomModifiedTextField(
                borderRadius: h8,
                controller: _profileController.searchController,
                prefixIcon: BipHip.search,
                suffixIcon: BipHip.voiceFill, // todo:: icon will be changed
                hint: ksSearch.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding),
                textInputStyle: regular16TextStyle(cBlackColor),
                onChanged: (v) async {
                  // _profileController.searchController.text = v.toString().trim();
                  if (_profileController.searchController.text.trim() != '') {
                    await _friendController.getAddFriendRequestList();
                  }
                  if (_profileController.searchController.text.trim() == '') {
                    _friendController.addFriendRequestList.clear();
                  }
                },
              ),
              kH8sizedBox,
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _friendController.addFriendRequestList.length,
                    itemBuilder: (context, index) {
                      ll(_friendController.addFriendRequestList.length);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: k10Padding),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                          child: Obx(
                            () => CustomSingleButtonListViewItem(
                              backgroundImage: Environment.imageBaseUrl + _friendController.addFriendRequestList[index].profilePicture.toString(),
                              name: _friendController.addFriendRequestList[index].fullName ?? ksNA.tr,
                              buttonText: _friendController.isSendRequest[index] ? ksSendRequest.tr : ksCancelRequest.tr,
                              buttonColor: _friendController.isSendRequest[index] ? cPrimaryColor : cWhiteColor,
                              borderColor: _friendController.isSendRequest[index] ? null : cRedColor,
                              textStyle: _friendController.isSendRequest[index] ? semiBold14TextStyle(cWhiteColor) : semiBold14TextStyle(cRedColor),
                              buttonWidth: 147,
                              buttonOnPressed: () async {
                                // _friendController.isSendOrCancelRequest.value = !_friendController.isSendOrCancelRequest.value;
                                _friendController.userId.value = _friendController.addFriendRequestList[index].id!;
                                _friendController.isSendRequest[index] = !_friendController.isSendRequest[index];
                                bool status;
                                if (!_friendController.isSendRequest[index]) {
                                  status = await _friendController.sendFriendRequest();
                                } else {
                                  status = await _friendController.cancelFriendRequest();
                                }
                                if (status == false) {
                                  _friendController.isSendRequest[index] = !_friendController.isSendRequest[index];
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
