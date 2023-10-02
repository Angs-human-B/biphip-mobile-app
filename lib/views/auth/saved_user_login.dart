import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
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
                            height: 200,
                            width: width,
                            child: ListView.builder(
                                itemCount: _authenticationController.users.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                            onPressed: () {
                              Get.offAllNamed(krLogin);
                            },
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
                      Get.offAllNamed(krRegister);
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

  final Map<String, dynamic> _item;
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextButton(
        onPressed: () {
          final SpController spController = SpController();
          spController.saveBearerToken(_item['token']);
          spController.saveRememberMe(true);
          Get.offAllNamed(krMenu);
        },
        style: kTextButtonStyle,
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
                  child: Image.network(
                    Environment.baseUrl + _item['image_url'].toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(kiLogoImageUrl);
                    },
                  ),
                ),
              ),
              kW12sizedBox,
              Text(
                '${_item['name'] ?? ''}',
                style: regular16TextStyle(cBlackColor),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: k12Padding),
                child: IconButton(
                  onPressed: () async {
                    _authenticationController.users.remove(_item);
                    await SpController().removeUser(_item);
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
      ),
    );
  }
}
