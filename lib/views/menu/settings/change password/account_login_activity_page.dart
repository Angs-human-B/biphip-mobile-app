import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/login/login.dart';
import 'package:bip_hip/views/intro/splash_screen.dart';
import 'package:bip_hip/views/menu/settings/change%20password/change_password_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/password_and_security_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/two%20_factor_authentication_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/account_ownership_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/contact_info_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/common/utils/common_alertdialogue.dart';


class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              title: "Account login activity",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Normalext(
                    "We'll help you secure your account in case you see a login you don't recognize.",
                    txtAlign: TextAlign.center,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150.h,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      color: cGreyBoxColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText("Iphone"),
                            SizedBox(
                              height: 2,
                            ),
                            Normalext("Dhaka, Bangladesh"),
                            SizedBox(
                              height: 2,
                            ),
                            Normalext("This device"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: ElevatedButton(
                child: Normalext(
                  'Logout from this device',
                  color: Colors.white,
                ),
                onPressed: () {
                  deleteAlertDialog(context: context, content: DeletePopupContent(text: "You will no longer be logged in on the selected devices."), title: "Are you sure?");
                },
              )),
        ));
  }
  
}
void deleteAlertDialog({required BuildContext context, required Widget content, required String title}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
      title: title,
    ),
  );
}

class DeletePopupContent extends StatelessWidget {
  const DeletePopupContent({super.key, required this.text, this.deleteOnPressed});
  final String text;
  final VoidCallback? deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k12Padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Normalext("You will no longer be logged in on the selected devices.", fontSize: 26.sp,color: Colors.black, txtAlign: TextAlign.center,),
          kH20sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                label: ksCancel.tr,
                onPressed: () {
                  Get.back();
                },
                buttonColor: cWhiteColor,
                borderColor: cLineColor2,
                textStyle: semiBold18TextStyle(cBlackColor),
                buttonHeight: h44,
                buttonWidth: 100,
              ),
              CustomElevatedButton(
                label: "Log out",
                onPressed: (){
                  Get.offUntil(
                    GetPageRoute(
                      page: () =>  Login(),
                    ),
                        (route) => route.isFirst,
                  );
                },
                buttonColor: cRedColor,
                borderColor: cRedColor,
                textStyle: semiBold18TextStyle(cWhiteColor),
                buttonHeight: h44,
                buttonWidth: 100,
              ),
            ],
          ),
          kH20sizedBox,
        ],
      ),
    );
  }
}

