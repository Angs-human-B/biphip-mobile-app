import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SelectHobbiesPage extends StatelessWidget {
  SelectHobbiesPage({super.key});

  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return SizedBox(
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              isCenterTitle: true,
              title: kidsController.selectedHobbies.isNotEmpty ? ksEditHobbies.tr : ksAddHobbies.tr,
              appBarColor: cWhiteColor,
              onBack: () {
                Get.back();
              },
            ),
          ),
          backgroundColor: cWhiteColor,
          body: Obx(
            () => SizedBox(
              width: width,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopTitleAndSubtitle(
                        title: "",
                        subTitle: ksHobbiesSubtitle.tr,
                      ),
                      kH16sizedBox,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 8.0,
                          children: [
                            for (int i = 0; i < kidsController.temporaryHobbiesList.length; i++)
                              CustomChoiceChips(
                                label: kidsController.temporaryHobbiesList[i],
                                isSelected: (kidsController.temporarySelectedHobbies.contains(kidsController.temporaryHobbiesList[i])),
                                onSelected: (value) {
                                  kidHelper.onSelectHobbies(i);
                                },
                              )
                          ],
                        ),
                      ),
                      kH16sizedBox,
                      CustomElevatedButton(
                        label: ksSave.tr,
                        onPressed: () {
                          kidsController.selectedHobbies.clear();
                          kidsController.selectedHobbies.addAll(kidsController.temporarySelectedHobbies);
                          kidHelper.saveHobbies();
                        },
                        buttonWidth: width - 40,
                        textStyle: semiBold16TextStyle(cWhiteColor),
                      ),
                      kHBottomSizedBox
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
