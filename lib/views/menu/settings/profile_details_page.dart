import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/account_ownership_page.dart';
import 'package:bip_hip/views/menu/settings/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/contact_info_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
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
                  "Bip-Hip uses this information to verify your identity and to keep our community safe. You decide what personal details you make visible to others.",txtAlign: TextAlign.justify,fontSize: 25.sp,),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 20),
                height: 250,
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
                            HeaderText("Contact info"),
                            Normalext("Shohagjalal@gmail.com", fontSize: 26.sp,),
                            Normalext("+8801993144278", fontSize: 26.sp),
                          ],
                        ),
                        IconButton(onPressed: (){
                          Get.to(ContactInfo());
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
                            HeaderText("Birthday"),
                            Normalext("January 01, 2000", fontSize: 26.sp),
                          ],
                        ),
                        IconButton(onPressed: (){
                          Get.to(AddContactInfo("Birthday", 'birthday', controllerTxt: "January 01, 2000",));
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomDivider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText("Account ownership and control"),
                            Normalext("Deactivate or delete your account and profile", fontSize: 26.sp),
                          ],
                        ),
                        IconButton(
                            onPressed: (){
                              Get.to(AccountOwnership());
                            },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
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
