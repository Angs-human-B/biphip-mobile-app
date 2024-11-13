import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/blocking/blocked_people.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controllers/menu/friend_controller.dart';
import '../../../../models/profile_view/user/profile_view_friend_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../../friends/add_friend.dart';

class BlockingSettingTiles extends StatefulWidget {
  List texts;
  int index;
  BlockingSettingTiles(this.texts,this.index, {Key? key}) : super(key: key);

  @override
  State<BlockingSettingTiles> createState() => _BlockingSettingTilesState();
}

class _BlockingSettingTilesState extends State<BlockingSettingTiles> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        Get.find<GlobalController>().resetTapButtonData();
        Get.find<GlobalController>().searchController.clear();
        Get.find<FriendController>().isFriendSearched.value = false;
        Get.find<FriendController>().isRouteFromBottomNavBar.value = true;
        Get.to(BlockedPeople( widget.texts[widget.index]['title']));
        await Get.find<FriendController>().getBlockedUserList();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 400.w,
                  child: HeaderText(
                    widget.texts[widget.index]['title'],
                  )),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: cPrimaryTint3Color,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.5.h),
                  child: Normalext(
                    "View",
                    weight: FontWeight.bold,
                    fontSize: 26.sp,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Normalext(
            widget.texts[widget.index]['body'],
            fontSize: 25.sp,
            txtAlign: TextAlign.start,
            weight: FontWeight.normal,
            color: cBlackColor,
          ),
          SizedBox(height: 10),
          if(widget.index < widget.texts.length-1)
            CustomDivider(),
        ],
      ),
    );
  }
}
