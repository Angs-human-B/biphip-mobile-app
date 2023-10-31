import 'package:bip_hip/utils/constants/imports.dart';

class HomePostDetails extends StatelessWidget {
  const HomePostDetails({super.key});
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
              title: 'Wahid Murad',
              hasBackButton: true,
              isCenterTitle: false,
              onBack: () {
                Get.back();
              },
              action: [
              Row(
                children: [
                  
                ],
              ),
              ],
              
              // action: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: k20Padding),
              //     child: TextButton(
              //       style: kTextButtonStyle,
              //       onPressed: () async {
              //         //*Common bottom sheet for add friend
              //         // _profileController.searchController.clear();
              //         // _friendController.isAddFriendSuffixIconVisible.value = false;
              //         // _friendController.isFriendSuffixIconVisible.value = false;
              //         // FocusScope.of(context).unfocus();
              //         // _friendController.addFriendRequestList.clear();
              //         // Get.toNamed(krAddFriend);
              //         // _profileController.toggleType(0);
              //       },
              //       child: Text(
              //         ksAdd.tr,
              //         style: semiBold16TextStyle(cPrimaryColor),
              //       ),
              //     ),
              //   ),
              // ],
            ),
          ),
        ),
      ),
    );
  }
}
