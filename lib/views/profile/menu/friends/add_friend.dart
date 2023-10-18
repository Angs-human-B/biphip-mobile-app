import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/friends/friends.dart';

class AddFriend extends StatelessWidget {
  AddFriend({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();

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
              ),
              SizedBox(
                height: height - kAppBarSize - MediaQuery.of(context).padding.top - 44,
                child: SingleChildScrollView(
                  child: Padding(
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
                                  backgroundImage: _profileController.addFriendLists[index]['image'].toString(),
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
