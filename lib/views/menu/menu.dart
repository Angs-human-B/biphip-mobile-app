import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/helpers/menu_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final MenuSectionController menuController = Get.find<MenuSectionController>();
  final MenuHelper menuHelper = MenuHelper();

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
                            menuHelper.menuSearch();
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
                body: Obx(
                  () => SizedBox(
                    height: height,
                    width: width,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isDeviceScreenLarge() ? kH16sizedBox : kH8sizedBox,
                            CustomMenuContainer(
                              height: 64,
                              onPressed: () async {
                                Get.toNamed(krProfile);
                                await profileController.getProfileOverview();
                              },
                              leading: ClipOval(
                                child: Container(
                                  height: h40,
                                  width: h40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    Environment.imageBaseUrl + Get.find<GlobalController>().userImage.value.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => ClipOval(
                                      child: Image.asset(
                                        kiProfileDefaultImageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    loadingBuilder: imageLoadingBuilder,
                                  ),
                                ),
                              ),
                              text: Get.find<GlobalController>().userName.value.toString(),
                              textStyle: semiBold18TextStyle(cBlackColor),
                            ),
                            kH16sizedBox,
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
                                for (int i = 0; i < menuController.shortcutButtonContent.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: k16Padding),
                                    child: CustomMenuContainer(
                                      height: 64,
                                      width: (width / 2) - (kHorizontalPadding + 9),
                                      leading: Icon(
                                        menuController.shortcutButtonContent[i]['icon'],
                                        color: cPrimaryColor,
                                      ),
                                      text: menuController.shortcutButtonContent[i]['text'],
                                      textStyle: semiBold16TextStyle(cBlackColor),
                                      onPressed: () {
                                        menuHelper.menuPressFunction(i);
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
                                menuController.isSupportButtonPressed.value = !menuController.isSupportButtonPressed.value;
                              },
                            ),
                            if (menuController.isSupportButtonPressed.value || menuController.isSettingButtonPressed.value)
                              Container(
                                width: width,
                                height: 1,
                                color: cLineColor,
                              ),
                            if (menuController.isSupportButtonPressed.value)
                              ListOfButtons(
                                list: menuController.supportButtonContent,
                              ),
                            if (menuController.isSupportButtonPressed.value) kH10sizedBox,
                            if (menuController.isSupportButtonPressed.value || !menuController.isSettingButtonPressed.value)
                              Container(
                                width: width,
                                height: 1,
                                color: cLineColor,
                              ),
                            CustomExpandableMenuButton(
                              onPressed: () {
                                menuController.isSettingButtonPressed.value = !menuController.isSettingButtonPressed.value;
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
                            if (menuController.isSettingButtonPressed.value)
                              ListOfButtons(
                                list: menuController.settingsButtonContent,
                              ),
                            kH20sizedBox,
                            CustomElevatedButton(
                              label: ksLogout.tr,
                              onPressed: () {
                                menuHelper.logout();
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
            if (Get.find<AuthenticationController>().isLogoutLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (Get.find<AuthenticationController>().isLogoutLoading.value) {
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

class CustomMenuContainer extends StatelessWidget {
  const CustomMenuContainer({super.key, this.leading, required this.text, required this.textStyle, this.height, this.width, this.onPressed, this.trailing});

  final Widget? leading, trailing;
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
            Expanded(
              child: Text(
                text,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: k12Padding),
                child: trailing,
              ),
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
