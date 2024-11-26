import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/count_down.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/common/textfields/otp_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/common/utils/common_simple_text.dart';


class TwoFactorAuthentication extends StatefulWidget {
  String type;
  TwoFactorAuthentication({this.type = 'phone',super.key});

  @override
  State<TwoFactorAuthentication> createState() => _TwoFactorAuthenticationState();
}

class _TwoFactorAuthenticationState extends State<TwoFactorAuthentication> {
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // authenticationController.getTwoFactorAuthentication();
  }

  @override
  Widget build(BuildContext context) {

    heightWidthKeyboardValue(context);

    return Container(
      decoration: const BoxDecoration(color: cWhiteColor,image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
      child: Obx(
            () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kAppBarSizeSetting),
                  child: CustomAppBar(
                    onBack: (){
                      Get.back();
                    },
                    title: ksTwoFactorAuth.tr,

                  ),
                ),
                body: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        children: [
                          Normalext(authenticationController.twoFactorAuthentication.value.two_factor_enabled? ksTwoFactorEnabled:
                          ksTwoFactorDisabled.tr,txtAlign: TextAlign.center,fontSize: 25.sp,),
                          SizedBox(height: 20,),
                          // if(!authenticationController.twoFactorAuthentication.value.two_factor_enabled)
                          CustomModifiedTextField(
                            obscureText: true,
                            controller: authenticationController.twoFactorTextfieldController,
                            onChanged: (value) {
                              registrationHelper.checkCanOTPVerifyNow();
                            },
                            hint: "Enter you bip-hip password",
                          ),
                          SizedBox(height: 750.h,),
                          kH16sizedBox,

                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar:  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                  child: CustomElevatedButton(
                    label:authenticationController.twoFactorAuthentication.value.two_factor_enabled? ksDisable.tr :ksConfirm.tr,
                    onPressed:authenticationController.twoFactorTextfieldController.text.isNotEmpty?  () {
                      Get.back();
                      if(authenticationController.twoFactorAuthentication.value.two_factor_enabled){

                        authenticationController.enableTwoFactorAuthentication("0");

                      }
                      else{
                         authenticationController.enableTwoFactorAuthentication("1");

                      }
                    }
                       : null ,
                    buttonWidth: width - 40,
                    buttonColor: authenticationController.twoFactorAuthentication.value.two_factor_enabled? cRedColor: Colors.blue,
                    textStyle: authenticationController.canOTPVerifyNow.value
                        ? semiBold16TextStyle(cWhiteColor)
                        : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                  ),
                ),
              ),
            ),
            if (authenticationController.isTwoFactorLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    print("bool");
                    if (authenticationController.isTwoFactorLoading.value) {
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
