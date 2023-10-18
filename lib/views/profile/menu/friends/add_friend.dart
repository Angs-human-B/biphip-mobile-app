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
                  if (_profileController.searchController.text == '') {
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
                                backgroundImage: Environment.imageBaseUrl + _friendController.addFriendRequestList[index].profilePicture.toString(),
                                name: _friendController.addFriendRequestList[index].fullName ?? ksNA.tr,
                                buttonText: ksSendRequest.tr,
                                buttonColor: cPrimaryColor,
                                buttonOnPressed: () async {
                                  // _friendController.userId.value = _friendController.addFriendRequestList[index].id!;
                                  // await _friendController.sendFriendRequest();
                                },
                                textStyle: semiBold14TextStyle(cWhiteColor),
                                buttonWidth: 147,
                              )),
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
