import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';

class History extends StatefulWidget {
  final String title;
  final String type;
  History(this.title, this.type,{Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final List history = [
    {
      "date": "Today",
      "time": "7:23 PM",
      "name": "Maud Rana",
      "description": "You search on Bip-hip"
    },
    {
      "date": "Today",
      "time": "8:15 PM",
      "name": "Maud Rana",
      "description": "You search on Bip-hip"
    },
    {
      "date": "Oct 24, 2024",
      "time": "7:23 PM",
      "name": "Maud Rana",
      "description": "You search on Bip-hip"
    },
    {
      "date": "Oct 24, 2024",
      "time": "8:30 PM",
      "name": "Maud Rana",
      "description": "You search on Bip-hip"
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "Maud Rana",
      "description": "You search on Bip-hip"
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "Maud Rana",
      "description": "You search on Bip-hip"
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "Maud Rana",
      "description": "You search on Bip-hip"
    },
  ];

  final List reactionHistory = [
    {
      "date": "Today",
      "time": "7:23 PM",
      "name": "❤️ ❤️ ❤️ ❤️️ ",
      "description": "You recently “React” Abdir Rahman Selfie."
    },
    {
      "date": "Today",
      "time": "8:15 PM",
      "name": "👍 👍 👍 👍",
      "description": "You recently “React” Abdir Rahman Selfie."
    },
    {
      "date": "Oct 24, 2024",
      "time": "7:23 PM",
      "name": "❤️ ❤️ ❤️ ❤️️ ",
      "description": "You recently “React” Abdir Rahman Selfie."
    },
    {
      "date": "Oct 24, 2024",
      "time": "8:30 PM",
      "name": "👍 👍 👍 ",
      "description": "You recently “React” Abdir Rahman Selfie."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "❤️ ❤️ ❤️ ❤️️ ",
      "description": "You recently “React” Abdir Rahman Selfie."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "👍 👍 👍 👍",
      "description": "You recently “React” Abdir Rahman Selfie."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "❤️ ❤️ ❤️ ❤️️ ",
      "description": "You recently “React” Abdir Rahman Selfie."
    },
  ];

  final List friends = [
    {
      "date": "Today",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become friend with Abdir Rahman."
    },
    {
      "date": "Today",
      "time": "8:15 PM",
      "name": "",
      "description": "You recently become friend with Abdir Rahman."
    },
    {
      "date": "Oct 24, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become friend with Abdir Rahman."
    },
    {
      "date": "Oct 24, 2024",
      "time": "8:30 PM",
      "name": "",
      "description": "You recently become friend with Abdir Rahman."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become friend with Abdir Rahman."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become friend with Abdir Rahman."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become friend with Abdir Rahman."
    },
  ];

  final List family = [
    {
      "date": "Today",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become family with Abdir Rahman."
    },
    {
      "date": "Today",
      "time": "8:15 PM",
      "name": "",
      "description": "You recently become family with Abdir Rahman."
    },
    {
      "date": "Oct 24, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become family with Abdir Rahman."
    },
    {
      "date": "Oct 24, 2024",
      "time": "8:30 PM",
      "name": "",
      "description": "You recently become family with Abdir Rahman."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become family with Abdir Rahman."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become family with Abdir Rahman."
    },
    {
      "date": "Nov 02, 2024",
      "time": "7:23 PM",
      "name": "",
      "description": "You recently become family with Abdir Rahman."
    },
  ];


  @override
  Widget build(BuildContext context) {
    // Group history items by date

    Map<String, List> groupedHistory = {};
    if(widget.type == "reaction"){
      for (var item in reactionHistory) {
        groupedHistory.putIfAbsent(item['date'], () => []).add(item);
      }
      print(groupedHistory);
    }
    else if(widget.type == "friends" ){
      for (var item in friends) {
        groupedHistory.putIfAbsent(item['date'], () => []).add(item);
      }
      print(groupedHistory);
    }
    else if(widget.type == "family" ){
      for (var item in family) {
        groupedHistory.putIfAbsent(item['date'], () => []).add(item);
      }
      print(groupedHistory);
    }
    else{
      for (var item in history) {
        groupedHistory.putIfAbsent(item['date'], () => []).add(item);
      }
      print(groupedHistory);
    }


    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            Get.back();
          },
          title: widget.title,
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*.935,
          child: ListView.builder(
            itemCount: groupedHistory.keys.length,
            itemBuilder: (context, index) {
              String date = groupedHistory.keys.elementAt(index);
              List dateHistory = groupedHistory[date]!;

              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cGreyBoxColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText(date,fontSize: 35.sp,),
                    SizedBox(height: 10),
                    ...dateHistory.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 70.h,
                                width: 85.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.type == "friends" || widget.type == "family"? Container():
                                  HeaderText(entry['name'], fontSize: 27.sp),
                                  Container(
                                    width: 470.w,
                                      child: Normalext(entry['description'],fontSize: 25.sp,txtAlign: TextAlign.start,)),
                                  Normalext(entry['time'],color: Colors.grey,fontSize: 25.sp,),
                                ],
                              ),
                            ],
                          ),
                          Icon(Icons.more_horiz_rounded, color: Colors.grey,size: 50.sp,)
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
