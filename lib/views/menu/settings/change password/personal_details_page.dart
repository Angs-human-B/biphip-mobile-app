import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/change_password_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/two%20_factor_authentication_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/account_ownership_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/contact_info_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/register/otp_verification.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
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
            title: "Personal Details",

          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Normalext(
                "We'll now ask for a login code anytime you log in on a device we don't recognize. Learn more",txtAlign: TextAlign.justify,fontSize: 25.sp,),
              SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.only(left: 20),
                height: 230.h,
                width: MediaQuery.of(context).size.width*.9,
                decoration: BoxDecoration(
                    color: cGreyBoxColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText("Text message"),
                            Normalext("We will send code to ************78.", fontSize: 26.sp,),
                          ],
                        ),
                        IconButton(onPressed: (){
                          Get.to(TwoFactorAuthentication(type: 'phone',));
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 10,),
                    CustomDivider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText("Get code on your mail"),
                            Normalext("We will send code to s**************l@gmail.com.", fontSize: 24.sp),
                          ],
                        ),
                        IconButton(onPressed: (){
                          Get.to(TwoFactorAuthentication(type: 'email',));
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor))
                      ],
                    ),

                    SizedBox(height: 10),
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
