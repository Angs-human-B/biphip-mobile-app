import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/logo_and_text_widget.dart';

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
                    physics: const AlwaysScrollableScrollPhysics(),
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
                        kH40sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 220),
                            width: width,
                            child: ListView.separated(
                                separatorBuilder: (context, index) => kH8sizedBox,
                                itemCount: _authenticationController.users.length,
                                shrinkWrap: true,
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
                            label: ksLoginToAnotherAccount.tr,
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
                    text: ksRegisterForNewAccount.tr,
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
    return CustomListTile(
      itemColor: cGreyBoxColor,
      onPressed: () {
        final SpController spController = SpController();
        spController.saveBearerToken(_item['token']);
        spController.saveRememberMe(true);
        Get.offAllNamed(krHome);
      },
      leading: Container(
        height: h40,
        width: h40,
        decoration: const BoxDecoration(
          color: cWhiteColor,
          shape: BoxShape.circle,
        ),
        child: Image.network(
          Environment.baseUrl + _item['image_url'].toString(),
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(kiProfileDefaultImageUrl);
          },
        ),
      ),
      title: Text(
        '${_item['name'] ?? ''}',
        style: regular16TextStyle(cBlackColor),
      ),
      trailing: ClipOval(
        child: TextButton(
          style: kTextButtonStyle,
          onPressed: () async {
            _authenticationController.users.remove(_item);
            await SpController().removeUser(_item);
            if (_authenticationController.users.isEmpty) {
              await SpController().onLogout();
              _authenticationController.resetLoginScreen();
              Get.offAllNamed(krLogin);
            }
          },
          child: Container(
            height: h36,
            width: h36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              BipHip.delete,
              color: cIconColor,
              size: isDeviceScreenLarge() ? kIconSize20 : kIconSize16,
            ),
          ),
        ),
      ),
    );
  }
}
