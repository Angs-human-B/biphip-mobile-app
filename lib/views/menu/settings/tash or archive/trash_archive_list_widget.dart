import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/icons/bip_hip_icons.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import 'common_undo_button.dart';
import 'common_white_button.dart';

class TrashArchiveListWidget extends StatefulWidget {
  const TrashArchiveListWidget({Key? key}) : super(key: key);

  @override
  State<TrashArchiveListWidget> createState() => _TrashArchiveListWidgetState();
}

class _TrashArchiveListWidgetState extends State<TrashArchiveListWidget> {
  List posts = [
    {
      "description": "Lorem Ipsum is simply dummy text of the printing and industry..",
      "type": "Post"
    },
    {
      "description": "Lorem Ipsum is simply dummy text of the printing and industry..",
      "type": "Post"
    },
    {
      "description": "Lorem Ipsum is simply dummy text of the printing and industry..",
      "type": "Selfie"
    },
    {
      "description": "Lorem Ipsum is simply dummy text of the printing and industry..",
      "type": "Selfie"
    },
    {
      "description": "Lorem Ipsum is simply dummy text of the printing and industry..",
      "type": "Poll"
    },
    {
      "description": "Lorem Ipsum is simply dummy text of the printing and industry..",
      "type": "Post"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*.95,
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                      border: Border.all(color: Colors.grey,width: 0.5),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  padding: EdgeInsets.all(15,),
                  child: Column(
                    children: [
                      Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 110.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                                color: cPlaceHolderColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(BipHip.imageFile, color: Colors.black45,size: 35,),
                          ),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 410.w,
                                  child: Normalext(posts[index]['description'], txtAlign: TextAlign.start,)),
                              HeaderText(posts[index]['type']),
                            ],
                          ),
                          Icon(Icons.more_horiz_rounded, size: 33.sp,)
                        ],

                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonBlueButton("Undo", Icons.check, (){}),
                          SizedBox(width: 20.w,),
                          CommonWhiteButton("Delete permanently", BipHip.delete, (){})
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
