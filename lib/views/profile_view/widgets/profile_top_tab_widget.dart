import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class ProfileTopTabWidget extends StatelessWidget {
  ProfileTopTabWidget({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Column(
          children: [
            Container(
              color: cWhiteColor,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: cLineColor, width: 1),
                    ),
                  ),
                  child: TabBar(
                    onTap: (value) {
                      ProfileViewHelper().showProfileViewTabSection(value);
                    },
                    indicatorColor: cPrimaryColor,
                    indicatorWeight: 1,
                    unselectedLabelColor: cSmallBodyTextColor,
                    unselectedLabelStyle: medium14TextStyle(cSmallBodyTextColor),
                    labelStyle: medium14TextStyle(cPrimaryColor),
                    labelColor: cPrimaryColor,
                    tabs: [
                      Text(
                        ksPosts.tr,
                      ),
                      Text(
                        ksPhotos.tr,
                      ),
                      Text(
                        ksVideos.tr,
                      ),
                      if (profileViewController.profileViewType.value != "store")
                        Text(
                          ksAwards.tr,
                        ),
                      if (profileViewController.profileViewType.value == "store")
                        Text(
                          ksReview.tr,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
