import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: 'BipHip'.tr,
              titleColor: cPrimaryColor,
              hasBackButton: false,
              isCenterTitle: false,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () async {
                      final spController = SpController();
                      Get.find<GlobalController>().recentSearch.value = await spController.getRecentSearchList();
                      // FirebaseCrashlytics.instance.crash();
                      Get.find<GlobalController>().searchController.clear();
                      Get.to(
                        () => Search(
                          searchController: Get.find<GlobalController>().searchController,
                          recentSearchList: Get.find<GlobalController>().recentSearch,
                          onSubmit: () {},
                        ),
                        transition: Transition.noTransition,
                      );
                    },
                    child: Icon(
                      BipHip.search,
                      color: cIconColor,
                      size: isDeviceScreenLarge() ? 24 : 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {},
                    child: Icon(
                      BipHip.chatOutline,
                      color: cIconColor,
                      size: isDeviceScreenLarge() ? 24 : 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            width: width,
            isFirstButtonClicked: true,
            isSecondButtonClicked: false,
            isThirdButtonClicked: false,
            isFourthButtonClicked: false,
            isFifthButtonClicked: false,
          ),
          body: SizedBox(
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}
