import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth_helpers/login_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/logo_and_text_widget.dart';

class SavedUserLogin extends StatelessWidget {
  SavedUserLogin({Key? key}) : super(key: key);

  final AuthenticationController authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: cTransparentColor,
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
                                itemCount: authenticationController.users.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var item = authenticationController.users;
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
  final LoginHelper _loginHelper = LoginHelper();

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      itemColor: cWhiteColor,
      borderColor: cLineColor2,
      onPressed: () async {
        _loginHelper.getSaveUserDetails(_item);
      },
      leading: Container(
        height: h40,
        width: h40,
        decoration: const BoxDecoration(
          color: cWhiteColor,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.network(
            Environment.imageBaseUrl + _item['image_url'].toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(kiProfileDefaultImageUrl);
            },
          ),
        ),
      ),
      title: Text(
        '${_item['name'] ?? ''}',
        style: medium16TextStyle(cBlackColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
