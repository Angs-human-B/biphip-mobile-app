import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/shimmers/menu/kids/kid_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile.dart';
import 'package:flutter_svg/svg.dart';

class KidsListView extends StatelessWidget {
  KidsListView({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => kidsController.isKidsListLoading.value
        ? const StoreKidsShimmer()
        : kidsController.kidList.isNotEmpty
            ? Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding).copyWith(bottom: k0Padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => kH12sizedBox,
                          itemCount: kidsController.kidList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                ll(kidsController.kidList[index].id);
                                await Get.find<HomeController>().getTimelinePostList();
                                Get.to(() => KidProfile(
                                      userName: kidsController.kidList[index].name ?? ksNA.tr,
                                      profilePicture: kidsController.kidList[index].profilePicture.toString(),
                                      coverPhoto: kidsController.kidList[index].coverPhoto.toString(),
                                    ));
                              },
                              child: CustomListTile(
                                padding: const EdgeInsets.only(left: k8Padding, top: k8Padding, bottom: k8Padding),
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
                                      kidsController.kidList[index].profilePicture.toString(),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(kiProfileDefaultImageUrl);
                                      },
                                      loadingBuilder: imageLoadingBuilder,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  kidsController.kidList[index].name ?? ksNA.tr,
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                subtitle: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: cPrimaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    kW4sizedBox,
                                    Text(
                                      '2 Notifications',
                                      style: regular14TextStyle(cBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        kH12sizedBox,
                      ],
                    ),
                  ),
                ),
              )
            : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      kikidImage,
                      height: 200,
                      width: 200,
                    ),
                    kH10sizedBox,
                    Text(
                      ksNoKidsAddedYet.tr,
                      style: semiBold20TextStyle(cSmallBodyTextColor),
                    ),
                    kH20sizedBox,
                    CustomElevatedButton(
                      buttonWidth: 120,
                      buttonHeight: h44,
                      label: ksAddKid.tr,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                      onPressed: () {
                        kidsController.resetKidsData();
                        Get.toNamed(krAddKidBasicInfo);
                      },
                      prefixIcon: BipHip.plus,
                      prefixIconSize: kIconSize20,
                    ),
                  ],
                ),
              ));
  }
}
