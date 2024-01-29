import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/widgets/kid_listview.dart';

class KidsPage extends StatelessWidget {
  KidsPage({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();
  final CreatePostHelper createPostHelper = CreatePostHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    title: ksKids.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      if (kidsController.kidList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: k20Padding),
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              kidsController.resetKidsData();
                              Get.toNamed(krAddKidBasicInfo);
                            },
                            child: Text(
                              ksAddKid.tr,
                              style: semiBold16TextStyle(cPrimaryColor),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH8sizedBox,
                    // const CustomDivider(
                    //   thickness: 1,
                    // ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: kidsController.isKidsListLoading.value
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: k12Padding),
                                  child: ShimmerCommon(
                                    widget: Container(
                                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                      height: 16,
                                      width: 120,
                                    ),
                                  ),
                                )
                              : kidHelper.totalKidShow(),
                        )),
                    KidsListView(),
                  ],
                ),
              ),
            ),
            if (kidsController.isKidDeleteLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (kidsController.isKidDeleteLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
