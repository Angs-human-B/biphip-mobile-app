import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/password_and_security_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/settings/privacy_settings_controller.dart';

class LoginAlerts extends StatefulWidget {
  const LoginAlerts({Key? key}) : super(key: key);

  @override
  State<LoginAlerts> createState() => _LoginAlertsState();
}

class _LoginAlertsState extends State<LoginAlerts> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();
  int selectedGroupValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
            () => Stack(
          children: [ SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSizeSetting),
          child: CustomAppBar(
            onBack: () {
              Get.back();
            },
            title: "Login Alerts",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Normalext(
                "We will send a notification for your every new login.",
                txtAlign: TextAlign.justify,
                fontSize: 26.sp,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 220.h,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  color: cGreyBoxColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderText("In-app notification"),
                        Radio<int>(
                          value: 1,
                          groupValue: privacySettingsController.selectedLoginAlertStatus.value,
                          onChanged: (value) {
                            setState(() {
                              privacySettingsController.selectedLoginAlertStatus.value = value ?? 0;
                              selectedGroupValue=value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const CustomDivider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderText("Email"),
                        Radio<int>(
                          value: 2,
                          groupValue: privacySettingsController.selectedLoginAlertStatus.value,
                          onChanged: (value) {
                            setState(() {
                              privacySettingsController.selectedLoginAlertStatus.value = value ?? 0;
                              selectedGroupValue=value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedGroupValue == 0
                  ? cIconColor
                  : cPrimaryColor,
            ),
            child: Normalext('Save', color: Colors.white),
            onPressed: selectedGroupValue == 0
                ? (){}
                : () {
              privacySettingsController.postLoginAlert();
            },
          ),
        ),
      ),
    ),
    if (privacySettingsController.isLoginAlertStatusLoading.value == true)
    Positioned(
    child: CommonLoadingAnimation(
    onWillPop: () async {
    if (privacySettingsController.isLoginAlertStatusLoading.value) {
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
