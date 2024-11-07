import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/activity%20log/history_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/where_logged_in_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';

class ActivityLog extends StatefulWidget {
  const ActivityLog({Key? key}) : super(key: key);

  @override
  State<ActivityLog> createState() => _ActivityLogState();
}

class _ActivityLogState extends State<ActivityLog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            Get.back();
          },
          title: ksActivityLog.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height:900.h,
        width: MediaQuery.of(context).size.width*.9,
        decoration: BoxDecoration(
            color: cGreyBoxColor,
            borderRadius: BorderRadius.circular(10)
        ),
          child: Column(
            children: [
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("Your search history", ''));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: cWhiteColor
                          ),
                          child: Icon(BipHip.search,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Your search history",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("Videos you’ve Watched", ''));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.video,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Videos you’ve Watched",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("Share history", ''));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.share,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Recent share",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("Post activity",  ''));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.heart,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Post activity",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("Comment", ''));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.comment,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Comment",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("Selfie activity", 'reaction'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.photo,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Selfie activity",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("New Friends", 'friends'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.friends,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Recent friend",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(History("New Friends", 'family'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.addFamily ,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Recent family",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              CustomDivider(thickness: 2,),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Get.to(LoggedIn());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cWhiteColor
                          ),
                          child: Icon(BipHip.user ,color: Colors.grey,),
                        ),
                        SizedBox(width: 10,),
                        HeaderText("Where you’re logged in",fontSize: 33.sp,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );

  }
}
