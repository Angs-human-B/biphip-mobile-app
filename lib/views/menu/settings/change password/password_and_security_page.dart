import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/change_password_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/two%20_factor_authentication_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/where_logged_in_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/account_ownership_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/login_alerts_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/auth/authentication_controller.dart';

class PasswordAndSecurity extends StatefulWidget {
  const PasswordAndSecurity({Key? key}) : super(key: key);

  @override
  State<PasswordAndSecurity> createState() => _PasswordAndSecurityState();
}

class _PasswordAndSecurityState extends State<PasswordAndSecurity> {
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSizeSetting),
          child: CustomAppBar(
            onBack: (){
              Get.back();
            },
            title: "Password and Security",

          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Normalext(
                "Manage your passwords, login preferences and recovery methods and Review security issues by running checks across apps, devices and emails sent.",txtAlign: TextAlign.justify,fontSize: 25.sp,),
              SizedBox(height: 20,),
              Container(
                height: 350.h,
                width: MediaQuery.of(context).size.width*.9,
                decoration: BoxDecoration(
                    color: cGreyBoxColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText("Change password"),
                        ),
                        IconButton(onPressed: (){
                          Get.to(ChangePassword());
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomDivider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText("Tow-factor authentication"),
                        ),
                        IconButton(onPressed: (){
                          authenticationController.getTwoFactorAuthentication();
                          print(authenticationController.twoFactorAuthentication.value.two_factor_enabled);
                          Get.to(TwoFactorAuthentication());
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 5),
                    CustomDivider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText("Where you’re logged in"),
                        ),
                        IconButton(
                            onPressed: (){
                              Get.to(LoggedIn());
                            },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    CustomDivider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText("Login alerts"),
                        ),
                        IconButton(
                            onPressed: (){
                              Get.to(LoginAlerts());
                            },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
