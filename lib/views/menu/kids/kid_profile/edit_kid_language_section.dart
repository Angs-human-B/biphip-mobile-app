import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_edit_about.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class EditKidLanguageSection extends StatelessWidget {
  EditKidLanguageSection({super.key});
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
            child: Obx(() => CustomAppBar(
                  appBarColor: cWhiteColor,
                  title: kidsController.userLanguages.isEmpty ? ksSelectLanguage.tr : ksEditLanguage.tr,
                  hasBackButton: true,
                  isCenterTitle: true,
                  onBack: () {
                    Get.back();
                  },
                )),
          ),
          body: Obx(
            () => Column(
              children: [
                Container(
                  color: cWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoContainer(
                          suffixText: ksLanguage.tr,
                          suffixTextStyle: semiBold18TextStyle(cBlackColor),
                          isAddButton: true,
                          suffixOnPressed: () async {
                            KidHelper().clearAddLanguagePage();
                            await kidsController.getLanguageList();
                            Get.toNamed(krKidAddLanguage);
                          },
                        ),
                        kH16sizedBox,
                      ],
                    ),
                  ),
                ),
                if (kidsController.kidsData.value!.languages.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomSelectionButton(
                          prefixIcon: BipHip.language,
                          trailingIcon: BipHip.cross,
                          onPressSuffixButton: () async {
                          },
                          text: kidsController.kidsData.value!.languages[index],
                        );
                      },
                      separatorBuilder: (context, index) => kH16sizedBox,
                      itemCount: kidsController.kidsData.value!.languages.length,
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
