import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/account_login_activity_page.dart';
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

class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
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
            title: "Where you’re logged in",

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
                  "You’re currently logged in on these devices",txtAlign: TextAlign.justify,fontSize: 25.sp,),
              ),
              SizedBox(height: 20,),
              Container(
                height: 150.h,
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
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("Iphone"),
                              SizedBox(height: 2,),
                              Normalext("Dhaka, Bangladesh"),
                              SizedBox(height: 2,),
                              Normalext("This device"),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){
                          Get.to(LoginActivity());
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),


                  ],
                ),
              ),
              SizedBox(height: 20,),
              HeaderText("Logins on others devices"),
              SizedBox(height: 20,),
              Container(
                  height: 800.h,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      color: cGreyBoxColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      HeaderText("Iphone"),
                                      SizedBox(height: 2,),
                                      Normalext("Dhaka, Bangladesh"),
                                      SizedBox(height: 2,),
                                      Normalext("This device"),
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  Get.to(LoginActivity());
                                },
                                    icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                              ],
                            ),
                            SizedBox(height: 10,),
                            if (index < 5)
                              CustomDivider()
                          ],
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
