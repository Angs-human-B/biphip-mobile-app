import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class EditKidGenderSection extends StatelessWidget {
  EditKidGenderSection({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

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
                appBarColor: cWhiteColor,
                title: ksSelectGender.tr,
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                kH16sizedBox,
                Text(
                  ksGender.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH12sizedBox,
                CustomSelectionButton(
                  prefixIcon: BipHip.gender,
                  onPressed: () async {
                    // editProfileHelper.selectGender(context);
                  },
                  text: kidsController.kidGender.value != '' ? kidsController.kidGender.value : ksSelectGender.tr,
                  hintText: ksSelectGender.tr,
                ),
                const Spacer(),
                CustomElevatedButton(
                    buttonWidth: width - 40,
                    buttonHeight: h32,
                    label: ksSave.tr,
                    onPressed: () {
                      Get.back();
                    }),
                kH16sizedBox,
              ]),
            ),
          )),
    );
  }
}
