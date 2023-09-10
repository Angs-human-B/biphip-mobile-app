import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_container.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);

    return Container(
      color: cWhiteColor,
      child: SafeArea(
          top: false,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                title: ksRegisterNow.tr,
                
                onBack: () async {
                  Get.back();
                },
              ),
            ),
            backgroundColor: cWhiteColor,
            body: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        children: [
                          kH20sizedBox,
                          if (_authenticationController.isReferredRegistration.value)
                            CustomTintContainer(
                                height: h60,
                                width: width,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k12Padding),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(children: [
                                      TextSpan(text: 'You are registering with ', style: regular14TextStyle(cBlackColor)),
                                      TextSpan(text: 'Aminul Islam', style: semiBold14TextStyle(cBlackColor)),
                                      TextSpan(text: '\'s referral link', style: regular14TextStyle(cBlackColor)),
                                    ]),
                                  ),
                                ),
                                borderRadius: k100CircularBorderRadius)
                        ],
                      ),
                    )),
              ),
            ),
          )),
    );
  }
}
