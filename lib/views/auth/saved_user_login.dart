import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/logo_and_text_widget.dart';

class SavedUserLogin extends StatelessWidget {
  SavedUserLogin({Key? key}) : super(key: key);

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: cWhiteColor,
          body: Obx(
            () => Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: getPaddingTop(context) + h50),
                          child: const LogoAndText(
                            size: h50,
                            fontSize: h18,
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                        ),
                        kH60sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: SizedBox(
                            height: 140,
                            width: width,
                            child: ListView.builder(
                                itemCount: _authenticationController.users.length,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var item = _authenticationController.users;
                                  return CustomUserListContainer(
                                    item: item[index],
                                  );
                                }),
                          ),
                        ),
                        kH16sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: CustomElevatedButton(
                            label: 'Login to another account',
                            onPressed: () {},
                            buttonHeight: h32,
                            buttonWidth: width - 40,
                            buttonColor: cWhiteColor,
                            textStyle: semiBold14TextStyle(cBlackColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: h32,
                  child: CustomTextButton(
                    onPressed: () {
                      Get.toNamed(krRegister);
                    },
                    text: "Register for new account",
                    textStyle: semiBold14TextStyle(cPrimaryColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomUserListContainer extends StatelessWidget {
  CustomUserListContainer({
    Key? key,
    required item,
  })  : _item = item,
        super(key: key);

  final Map<String, String> _item;
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: width,
        height: h60,
        decoration: BoxDecoration(
          borderRadius: k4CircularBorderRadius,
          color: cGreyBoxColor,
        ),
        // height: isDeviceScreenLarge() ? kLargeListItemHeight : kSmallListItemHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kW12sizedBox,
            ClipOval(
              child: Container(
                height: h40,
                width: h40,
                decoration: const BoxDecoration(
                  color: cWhiteColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  BipHip.user,
                  color: cPrimaryColor,
                  size: height > kSmallDeviceSizeLimit ? kIconSize20 : kIconSize16,
                ),
              ),
            ),
            kW12sizedBox,
            Text(
              '${_item['name']}',
              style: regular16TextStyle(cBlackColor),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: k12Padding),
              child: IconButton(
                onPressed: () {
                  _authenticationController.users.remove(_item);
                },
                icon: Icon(
                  BipHip.delete,
                  color: cIconColor,
                  size: height > kSmallDeviceSizeLimit ? kIconSize20 : kIconSize16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
