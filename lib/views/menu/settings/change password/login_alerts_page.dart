import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/password_and_security_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/delete_account_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginAlerts extends StatefulWidget {
  const LoginAlerts({Key? key}) : super(key: key);

  @override
  State<LoginAlerts> createState() => _LoginAlertsState();
}

class _LoginAlertsState extends State<LoginAlerts> {
  int selectedGroupValue = 0;
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
            title: "Login Alerts",

          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Normalext(
                "We will send a notification for your every new login.", txtAlign: TextAlign.justify,fontSize: 26.sp,),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 20),
                height: 220.h,
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
                        HeaderText("In-app notifications"),
                        IconButton(onPressed: (){
                        },
                          icon: Radio<int>(
                            value: 1,
                            groupValue: selectedGroupValue,
                            onChanged: (value) {
                              setState(() {
                                selectedGroupValue = 1;
                                print("Button value: $value");
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    CustomDivider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderText("Login alerts"),
                        IconButton(
                          onPressed: (){
                          },
                          icon: Radio<int>(
                            value: 2,
                            groupValue: selectedGroupValue,
                            onChanged: (value) {
                              setState(() {
                                selectedGroupValue = 2;
                                print("Button value: $value");
                              });
                            },
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: selectedGroupValue == 0? Colors.black38: Colors.blue
            ),
            child: Normalext('Save', color: Colors.white,),
            onPressed: () {
              Get.to(PasswordAndSecurity());
            },
          ),
        ),
      ),
    );
  }
}
