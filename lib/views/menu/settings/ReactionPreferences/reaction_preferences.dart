import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReactionPreferences extends StatefulWidget {
  const ReactionPreferences({Key? key}) : super(key: key);

  @override
  State<ReactionPreferences> createState() => _ReactionPreferencesState();
}

class _ReactionPreferencesState extends State<ReactionPreferences> {
  bool togglePostFromOthers = true;
  bool togglePostsYouShare = false;

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
            title: ksReactionPreferences.tr,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  color: cGreyBoxColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("On posts from others"),
                              SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                child: Normalext(
                                  "You won’t see the total number of reactions for posts others share to News Feed, Pages, and groups. You will still see reaction counts for posts in other places, like Marketplace, and for other content, like reels. Your reaction to a post will still be visible to you and everyone else.",
                                  fontSize: 26.sp,
                                  txtAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: togglePostFromOthers,
                          activeTrackColor:Colors.green ,
                          thumbColor: WidgetStateProperty.all(cWhiteColor),
                          onChanged: (bool value) {
                            setState(() {
                              togglePostFromOthers = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomDivider(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("On posts you share"),
                              SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                child: Normalext(
                                  "Other people won't see the total number of reactions under posts you share to your profile. Reaction counts will still appear on your posts in other places, like groups, or on other content, like reels.",
                                  fontSize: 26.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: togglePostsYouShare,
                          activeTrackColor:Colors.green ,
                          thumbColor: WidgetStateProperty.all(cWhiteColor),
                          onChanged: (bool value) {
                            setState(() {
                              togglePostsYouShare = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
