import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';


class Register extends StatelessWidget {
   Register({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();


  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);

    return Container(
      color: cWhiteColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: cWhiteColor,
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Obx(() => Column(
                children: [
                  kH20sizedBox,
                  // if(_authenticationController.isReferredRegistration.value)

                ],
              )),
            ),
          ),
        )
      ),
    );
  }
}