import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

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
                Padding(padding: const EdgeInsets.only(right: 8.0), child: IconButton(onPressed: () {}, icon: const Icon(BipHip.search))),
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
                      kH20sizedBox,
                      CustomMenuContainer(
                        height: 64,
                        leading: ClipOval(
                          child: Container(
                            height: h40,
                            width: h40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/profilePic.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        text: 'Aminul Islam Rana',
                        textStyle: semiBold18TextStyle(cBlackColor),
                      ),
                      kH25sizedBox,
                      Text(
                        'All shortcuts',
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH16sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.friends,
                              color: cPrimaryColor,
                            ),
                            text: 'Friends',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          ),
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.removeFamily,
                              color: cPrimaryColor,
                            ),
                            text: 'Family',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          )
                        ],
                      ),
                      kH16sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.imageFile,
                              color: cPrimaryColor,
                            ),
                            text: 'Images',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          ),
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.playNew,
                              color: cPrimaryColor,
                            ),
                            text: 'Videos',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          )
                        ],
                      ),
                      kH16sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.giftNew,
                              color: cPrimaryColor,
                            ),
                            text: 'Stars',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          ),
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.friends,
                              color: cPrimaryColor,
                            ),
                            text: 'Badges',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          )
                        ],
                      ),
                      kH16sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.selling,
                              color: cPrimaryColor,
                            ),
                            text: 'Earnings',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          ),
                          CustomMenuContainer(
                            height: 64,
                            width: (width / 2) - (kHorizontalPadding + 9),
                            leading: const Icon(
                              BipHip.kids,
                              color: cPrimaryColor,
                            ),
                            text: 'Kids',
                            textStyle: semiBold16TextStyle(cBlackColor),
                          )
                        ],
                      ),
                      kH16sizedBox,
                      CustomMenuContainer(
                        height: 64,
                        width: (width / 2) - (kHorizontalPadding + 9),
                        leading: const Icon(
                          BipHip.world,
                          color: cPrimaryColor,
                        ),
                        text: 'Shop',
                        textStyle: semiBold16TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      Container(
                        width: width,
                        height: 1,
                        color: cLineColor,
                      ),
                      CustomExpandableMenuButton(
                        height: h50,
                        text: 'Help & support',
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
                          list: _profileController.supportButtonContent,
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
                          text: 'Settings & privacy'),
                      Container(
                        width: width,
                        height: 1,
                        color: cLineColor,
                      ),
                      if (_profileController.isSettingButtonPressed.value)
                        ListOfButtons(
                          list: _profileController.settingsButtonContent,
                        ),
                      kH20sizedBox,
                      CustomElevatedButton(
                        label: 'Logout',
                        onPressed: () {},
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
  const CustomExpandableMenuButton({super.key, required this.text, this.height, this.onPressed});

  final String text;
  final VoidCallback? onPressed;
  final double? height;

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
              const Icon(
                BipHip.info,
                color: cIconColor,
              ),
              kW8sizedBox,
              Text(
                text,
                style: semiBold16TextStyle(cBlackColor),
              ),
              const Spacer(),
              const Icon(
                BipHip.downArrow,
                color: cIconColor,
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
              height: 48, onPressed: item['onPressed'], leading: const Icon(BipHip.openedEye), text: item['text'], textStyle: semiBold14TextStyle(cBlackColor)),
        );
      },
    );
  }
}
