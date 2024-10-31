import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/imports.dart';

class Modalsheetwidget extends StatefulWidget {
  String title;
  String description;
  int options;
  Modalsheetwidget(this.title, this.description,this.options,{Key? key}) : super(key: key);

  @override
  State<Modalsheetwidget> createState() => _ModalsheetwidgetState();
}

class _ModalsheetwidgetState extends State<Modalsheetwidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: cLineColor,
                  borderRadius: k4CircularBorderRadius,
                ),
                height: 5,
                width: width * .1,
              ),
            ),
            SizedBox(height:10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                    child: Icon(BipHip.circleCrossNew,color: Colors.black45,)),
                Normalext("Edit Audience",fontSize: 35.sp,weight: FontWeight.bold,),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                    child: Normalext("Done", color: Colors.blue,fontSize: 28.sp,))
              ],
            ),
            SizedBox(height:10,),
            CustomDivider(thickness: 1,),
            SizedBox(height:20,),
            HeaderText(widget.title,),
            Normalext(widget.description, txtAlign: TextAlign.start, fontSize: 25.sp,),
            SizedBox(height: 20,),
            if(widget.options ==0)
              FriendsRequest()
            else if(widget.options ==1)
              FriendsList()
            else
              MessageRequest()
          ],
        ),
      ),
    );
  }

  Widget FriendsRequest(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(50)
                  ),
                    child: Icon(BipHip.world,size: 35.sp,)
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    HeaderText("Everyone",),
                    Normalext("Anyone or off BipHip", color: Colors.grey,),

                  ],
                ),

              ],
            ),
            Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (value) {
                setState(() {
                  print("Button value: $value");
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                    child: Icon(BipHip.friends,size: 35.sp,)),
                SizedBox(width: 15,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText("Friends of friends",),
                    Normalext("Your friends on BipHip", color: Colors.grey,),

                  ],
                ),

              ],
            ),
            Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (value) {
                setState(() {
                  print("Button value: $value");
                });
              },
            ),
          ],
        )
      ],
    );
  }
  Widget FriendsList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(BipHip.world, size: 35.sp,)
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    HeaderText("Everyone",),
                    Normalext("Anyone or off BipHip", color: Colors.grey,),

                  ],
                ),

              ],
            ),
            Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (value) {
                setState(() {
                  print("Button value: $value");
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(BipHip.friends, size: 35.sp,)),
                SizedBox(width: 15,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText("Friends & Family",),
                    Normalext("Your friends on BipHip", color: Colors.grey,),

                  ],
                ),

              ],
            ),
            Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (value) {
                setState(() {
                  print("Button value: $value");
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(BipHip.friends, size: 35.sp,)),
                SizedBox(width: 15,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText("Family",),
                    Normalext("Your friends on BipHip", color: Colors.grey,),

                  ],
                ),

              ],
            ),
            Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (value) {
                setState(() {
                  print("Button value: $value");
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(BipHip.friends, size: 35.sp,)),
                SizedBox(width: 15,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText("Friends",),
                    Normalext("Your friends on BipHip", color: Colors.grey,),
                  ],
                ),

              ],
            ),
            Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (value) {
                setState(() {
                  print("Button value: $value");
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(BipHip.lock, size: 35.sp,)),
                SizedBox(width: 15,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText("Only Me",),
                    Normalext("Add your family", color: Colors.grey,),

                  ],
                ),

              ],
            ),
            Radio<int>(
              value: 0,
              groupValue: 0,
              onChanged: (value) {
                setState(() {
                  print("Button value: $value");
                });
              },
            ),
          ],
        ),

      ],
    );
  }

    Widget MessageRequest() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Icon(BipHip.world, size: 35.sp,)
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      HeaderText("Chat",),
                      Normalext("You want message in your chat", color: Colors.grey,),

                    ],
                  ),

                ],
              ),
              Radio<int>(
                value: 0,
                groupValue: 0,
                onChanged: (value) {
                  setState(() {
                    print("Button value: $value");
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(BipHip.friends, size: 35.sp,)),
                  SizedBox(width: 15,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText("Message requests",),
                      Normalext("You get only message request", color: Colors.grey,),

                    ],
                  ),

                ],
              ),
              Radio<int>(
                value: 0,
                groupValue: 0,
                onChanged: (value) {
                  setState(() {
                    print("Button value: $value");
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(BipHip.friends, size: 35.sp,)),
                  SizedBox(width: 15,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText("Don’t receive request",),
                      Normalext("You don’t receive any message request", color: Colors.grey,fontSize: 27.sp,),

                    ],
                  ),

                ],
              ),
              Radio<int>(
                value: 0,
                groupValue: 0,
                onChanged: (value) {
                  setState(() {
                    print("Button value: $value");
                  });
                },
              ),
            ],
          ),
        ],
      );
    }
}
