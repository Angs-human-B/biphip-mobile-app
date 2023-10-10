import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/controllers/profile_controllers/menu_section_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final MenuSectionController _menuController = Get.find<MenuSectionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cGreyBoxColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cGreyBoxColor,
              title: ksMenu.tr,
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
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Icon(
                      BipHip.search,
                      color: cIconColor,
                      size: isDeviceScreenLarge() ? 24 : 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                      CustomMenuContainer(
                        height: 64,
                        onPressed: () async {
                          Get.toNamed(krProfile);
                          await _profileController.getProfileOverview();
                        },
                        leading: ClipOval(
                          child: Container(
                            height: h40,
                            width: h40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              kiProfilePicImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        text: 'Aminul Islam Rana',
                        textStyle: semiBold18TextStyle(cBlackColor),
                      ),
                      kH25sizedBox,
                      Text(
                        ksAllShortcuts.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH16sizedBox,
                      Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 17.0,
                        children: [
                          for (int i = 0; i < _menuController.shortcutButtonContent.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: CustomMenuContainer(
                                height: 64,
                                width: (width / 2) - (kHorizontalPadding + 9),
                                leading: Icon(
                                  _menuController.shortcutButtonContent[i]['icon'],
                                  color: cPrimaryColor,
                                ),
                                text: _menuController.shortcutButtonContent[i]['text'],
                                textStyle: semiBold16TextStyle(cBlackColor),
                                onPressed: () {
                                  _menuController.menuPressFunction(i);
                                },
                              ),
                            ),
                        ],
                      ),
                      kH4sizedBox,
                      Container(
                        width: width,
                        height: 1,
                        color: cLineColor,
                      ),
                      CustomExpandableMenuButton(
                        height: h50,
                        text: ksHelpSupport.tr,
                        icon: BipHip.helpFill,
                        onPressed: () {
                          _profileController.isSupportButtonPressed.value = !_profileController.isSupportButtonPressed.value;
                        },
                      ),
                      if (_profileController.isSupportButtonPressed.value || _profileController.isSettingButtonPressed.value)
                        Container(
                          width: width,
                          height: 1,
                          color: cLineColor,
                        ),
                      if (_profileController.isSupportButtonPressed.value)
                        ListOfButtons(
                          list: _menuController.supportButtonContent,
                        ),
                      if (_profileController.isSupportButtonPressed.value) kH10sizedBox,
                      if (_profileController.isSupportButtonPressed.value || !_profileController.isSettingButtonPressed.value)
                        Container(
                          width: width,
                          height: 1,
                          color: cLineColor,
                        ),
                      CustomExpandableMenuButton(
                        onPressed: () {
                          _profileController.isSettingButtonPressed.value = !_profileController.isSettingButtonPressed.value;
                        },
                        height: h50,
                        text: ksSettingsPrivacy.tr,
                        icon: BipHip.setting,
                      ),
                      Container(
                        width: width,
                        height: 1,
                        color: cLineColor,
                      ),
                      if (_profileController.isSettingButtonPressed.value)
                        ListOfButtons(
                          list: _menuController.settingsButtonContent,
                        ),
                      kH20sizedBox,
                      CustomElevatedButton(
                        label: ksLogout.tr,
                        onPressed: () async {
                          var status = await SpController().getRememberMe();
                          if (status == true) {
                            await Get.find<AuthenticationController>().getSavedUsers();
                            Get.offAllNamed(krSavedUserLogin);
                            await SpController().onLogout();
                            Get.find<AuthenticationController>().resetLoginScreen();
                          } else {
                            await Get.find<AuthenticationController>().logout();
                          }
                        },
                        buttonHeight: 42,
                        buttonWidth: width - 40,
                        buttonColor: cWhiteColor,
                        textStyle: semiBold14TextStyle(cPrimaryColor),
                      ),
                      kHBottomSizedBox
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            width: width,
            isFirstButtonClicked: false,
            isSecondButtonClicked: false,
            isThirdButtonClicked: false,
            isFourthButtonClicked: false,
            isFifthButtonClicked: true,
          ),
        ),
      ),
    );
  }
}

class CustomMenuContainer extends StatelessWidget {
  const CustomMenuContainer({super.key, required this.leading, required this.text, required this.textStyle, this.height, this.width, this.onPressed});

  final Widget leading;
  final double? height, width;
  final VoidCallback? onPressed;
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k12CircularBorderRadius, border: Border.all(color: cLineColor)),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k12Padding),
              child: leading,
            ),
            Text(
              text,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}

class CustomExpandableMenuButton extends StatelessWidget {
  const CustomExpandableMenuButton({super.key, required this.text, this.height, this.onPressed, required this.icon});

  final String text;
  final VoidCallback? onPressed;
  final double? height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPressed,
      child: Container(
        height: height,
        width: width,
        color: cGreyBoxColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: k10Padding),
          child: Row(
            children: [
              Icon(
                icon,
                color: cIconColor,
                size: isDeviceScreenLarge() ? 22 : 18,
              ),
              kW8sizedBox,
              Text(
                text,
                style: semiBold16TextStyle(cBlackColor),
              ),
              const Spacer(),
              Icon(
                BipHip.downArrow,
                color: cIconColor,
                size: isDeviceScreenLarge() ? h28 : h24,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfButtons extends StatelessWidget {
  const ListOfButtons({super.key, required this.list});

  final List list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var item = list[index];
        return Padding(
          padding: const EdgeInsets.only(top: k10Padding),
          child: CustomMenuContainer(
            height: 48,
            onPressed: item['onPressed'],
            leading: Icon(
              item['icon'],
              color: cIconColor,
              size: isDeviceScreenLarge() ? h20 : h16,
            ),
            text: item['text'],
            textStyle: semiBold14TextStyle(cBlackColor),
          ),
        );
      },
    );
  }
}
