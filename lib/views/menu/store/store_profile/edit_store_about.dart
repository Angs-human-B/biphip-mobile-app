import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_edit_about.dart';

class StoreEditAbout extends StatelessWidget {
  StoreEditAbout({super.key});
  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksAbout.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            children: [
              StoreCategoryContent(),
              kH8sizedBox,
              StoreLocationContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class StoreCategoryContent extends StatelessWidget {
  StoreCategoryContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            Obx(() => InfoContainer(
                  suffixText: ksCategory.tr,
                  subtitlePrefixText: storeController.storeCategory.value ?? ksCategory.tr,
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: false,
                  suffixOnPressed: () {
                    // KidHelper().resetKidRelationEditPage();
                    // Get.toNamed(krKidEditRelation);
                  },
                )),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class StoreLocationContent extends StatelessWidget {
  StoreLocationContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            InfoContainer(
              suffixText: ksStoreLocation.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              isAddButton: true,
              suffixOnPressed: () {
                // kidHelper.addKidEducationBackground();
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.storeLocationList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.storeLocationList[i]), //*Use here api
                  // suffixText: kidsController.schoolList[i], //! Using api
                  // prefixText: kidsController.kidSchoolList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,

                  // subtitlePrefixText: kidHelper.schoolSubtitleText(
                  // kidsController.kidSchoolList[i].started ?? DateTime.now(), kidsController.kidSchoolList[i].ended ?? DateTime.now()),
                  // subtitlePrefixText: 'Started at and End at',
                  isAddButton: false,
                  suffixOnPressed: () async {
                    // kidHelper.editKidSchool(i);
                    // editProfileHelper.editSchool(i);//! write this function
                  },
                ),
              ),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}
