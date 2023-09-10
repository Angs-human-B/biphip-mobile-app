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
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
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
                      kH30sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: h20),
                        child: Container(
                          height: 200,
                          color: cRedColor,
                          width: width,
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
    );
  }
}
