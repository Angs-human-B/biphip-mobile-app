import 'dart:ui';

import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SelfiePage extends StatelessWidget {
  SelfiePage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();
  @override
  Widget build(BuildContext context) {
    final RxDouble x = RxDouble(width * 0.5);
    final RxDouble y = RxDouble(height * 0.5);
    // ll("initial value of dx ${selfieController.x.value}");
    // ll("initial value of dy ${selfieController.y.value}");
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cWhiteColor,
        resizeToAvoidBottomInset: true,
        // floatingActionButton: selfieController.isColorsShow.value
        //     ? Padding(
        //         padding: const EdgeInsets.only(left: k30Padding),
        //         child: Row(
        //           children: [
        //             InkWell(
        //               onTap: () {
        //                 selfieController.isColorsShow.value = false;
        //               },
        //               child: Container(
        //                 width: h20,
        //                 height: h20,
        //                 decoration: BoxDecoration(
        //                   border: Border.all(width: 2, color: cWhiteColor),
        //                   shape: BoxShape.circle,
        //                 ),
        //                 child: const Icon(
        //                   BipHip.cross,
        //                   color: cWhiteColor,
        //                   size: kIconSize16,
        //                 ),
        //               ),
        //             ),
        //             kW12sizedBox,
        //             SizedBox(
        //               height: h60,
        //               child: ListView.separated(
        //                   scrollDirection: Axis.horizontal,
        //                   shrinkWrap: true,
        //                   physics: const AlwaysScrollableScrollPhysics(),
        //                   itemCount: 10,
        //                   separatorBuilder: (context, index) => kW12sizedBox,
        //                   itemBuilder: (context, index) {
        //                     return InkWell(
        //                       onTap: () {
        //                         selfieController.textSelectedColor.value = selfieController.colorList[index]["colorCode"];
        //                       },
        //                       child: Container(
        //                         width: h20,
        //                         height: h20,
        //                         decoration: BoxDecoration(
        //                           shape: BoxShape.circle,
        //                           color: selfieController.colorList[index]["colorCode"],
        //                           border: Border.all(width: 1, color: cWhiteColor),
        //                         ),
        //                         child: Stack(
        //                           alignment: Alignment.center,
        //                           children: [
        //                             if (selfieController.textSelectedColor.value == selfieController.colorList[index]["colorCode"])
        //                               Container(
        //                                 width: 8,
        //                                 height: 8,
        //                                 decoration: const BoxDecoration(
        //                                   color: cWhiteColor,
        //                                   shape: BoxShape.circle,
        //                                 ),
        //                               ),
        //                             // if (selfieController.textSelectedColor.value != selfieController.colorList[index]["colorCode"])
        //                             //   const SizedBox.shrink(), // Use an empty SizedBox to fill the space when the condition is false
        //                           ],
        //                         ),
        //                       ),
        //                     );
        //                   }),
        //             ),
        //           ],
        //         ),
        //       )
        //     : const SizedBox(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Obx(
          () => Column(
            children: [
              Stack(
                children: [
                  if (selfieController.isSelfieImageChanged.value)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(
                                  selfieController.selfieImageFile.value,
                                ),
                                fit: BoxFit.cover)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                          child: Container(
                            width: width - 40,
                            // height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(selfieController.selfieImageFile.value),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (selfieController.isTextFieldShow.value)
                    Positioned(
                      top: height * 0.4,
                      child: Center(
                        child: SizedBox(
                          width: width,
                          height: 220,
                          child: CustomModifiedTextField(
                            border: InputBorder.none,
                            fillColor: cTransparentColor,
                            maxLines: 5,
                            maxLength: 255,
                            inputAction: TextInputAction.newline,
                            inputType: TextInputType.multiline,
                            autoFocus: true,
                            controller: selfieController.selfieTextEditingController,
                            hint: ksStartTyping.tr,
                            textHintStyle: medium24TextStyle(cSmallBodyTextColor),
                            textAlign: TextAlign.center,
                            textInputStyle: medium24TextStyle(selfieController.textSelectedColor.value),
                          ),
                        ),
                      ),
                    ),
                  if (!selfieController.isTextFieldShow.value)
                    Positioned(
                      left: x.value,
                      top: y.value,
                      child: Draggable(
                        feedback: Material(
                          color: cTransparentColor,
                          child: Text(
                            selfieController.selfieText.value,
                            textAlign: TextAlign.center,
                            style: medium24TextStyle(selfieController.textSelectedColor.value),
                          ),
                        ),
                        child: Material(
                          color: cTransparentColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: k8Padding, right: k8Padding),
                            child: Text(
                              selfieController.selfieText.value,
                              textAlign: TextAlign.center,
                              style: medium24TextStyle(selfieController.textSelectedColor.value),
                            ),
                          ),
                        ),
                        // onDragUpdate: (details){

                        // },
                        //                  onDragStarted: (details) {
                        //   // Store the initial position when the drag starts
                        //   draggableController.initialPosition = details.offset;
                        // },
                        // onDragStarted: () {
                        //   selfieController.initialPosition = details.offset;
                        // },
                        onDragEnd: (details) {
                          // Calculate the difference between the final and initial positions
                          // selfieController.updateDragOffset(details.offset);
                          x.value = details.offset.dx;
                          y.value = (details.offset.dy);
                          // Update the dragOffset with the calculated difference
                          // selfieController.updateDragOffset(selfieController.initialOffset, details.offset);
                        },
                        // child: Transform.translate(
                        //   offset: selfieController.dragOffset.value,
                        //   child: Material(
                        //     child: Text(
                        //       selfieController.selfieText.value,
                        //       textAlign: TextAlign.center,
                        //       style: medium24TextStyle(selfieController.textSelectedColor.value),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  if (selfieController.isTextFieldShow.value)
                    Positioned(
                      right: 20,
                      top: 50,
                      child: CustomElevatedButton(
                        buttonColor: cBlackColor,
                        buttonWidth: 68,
                        buttonHeight: h32,
                        label: ksDone,
                        onPressed: () {
                          unFocus(context);
                          selfieController.isTextFieldShow.value = false;
                          selfieController.isColorsShow.value = false;
                          if (selfieController.selfieTextEditingController.text.toString().trim() != "") {
                            selfieController.selfieText.value = selfieController.selfieTextEditingController.text.toString().trim();
                          }
                        },
                        textStyle: semiBold14TextStyle(cWhiteColor),
                      ),
                    ),
                  if (selfieController.isTextFieldShow.value)
                    Positioned(
                      left: width * 0.5,
                      top: 50,
                      child: InkWell(
                        onTap: () {
                          selfieController.isColorsShow.value = true;
                        },
                        child: Container(
                          width: h32,
                          height: h32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                cOrangeGradientColor,
                                cBlackGradientColor,
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            border: Border.all(width: 1, color: cWhiteColor),
                          ),
                        ),
                      ),
                    ),
                  if (selfieController.isTextFieldShow.value && selfieController.isColorsShow.value)
                    Positioned(
                      bottom: h20,
                      child: Padding(
                        padding: const EdgeInsets.only(top: k50Padding, left: k20Padding),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                selfieController.isColorsShow.value = false;
                              },
                              child: Container(
                                width: h20,
                                height: h20,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: cWhiteColor),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  BipHip.cross,
                                  color: cWhiteColor,
                                  size: kIconSize16,
                                ),
                              ),
                            ),
                            kW12sizedBox,
                            SizedBox(
                              height: h60,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: 10,
                                  separatorBuilder: (context, index) => kW12sizedBox,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        selfieController.textSelectedColor.value = selfieController.colorList[index]["colorCode"];
                                      },
                                      child: Container(
                                        width: h20,
                                        height: h20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selfieController.colorList[index]["colorCode"],
                                          border: Border.all(width: 1, color: cWhiteColor),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            if (selfieController.textSelectedColor.value == selfieController.colorList[index]["colorCode"])
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: const BoxDecoration(
                                                  color: cWhiteColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            // if (selfieController.textSelectedColor.value != selfieController.colorList[index]["colorCode"])
                                            //   const SizedBox.shrink(), // Use an empty SizedBox to fill the space when the condition is false
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (!selfieController.isTextFieldShow.value)
                    Positioned(
                      left: 20,
                      top: 50,
                      child: SizedBox(
                        width: width - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              onPress: () {
                                Get.back();
                              },
                              icon: BipHip.cross,
                              iconColor: cWhiteColor,
                              size: kIconSize24,
                            ),
                            InkWell(
                              onTap: () {
                                selfieController.isTextFieldShow.value = true;
                              },
                              child: Text(
                                ksText.tr,
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  if (!selfieController.isTextFieldShow.value)
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Column(
                        children: [
                          CustomIconButton(
                            onPress: () {},
                            icon: BipHip.downCircleArrowNew,
                            iconColor: cWhiteColor,
                            size: kIconSize20,
                          ),
                          Text(
                            ksSave,
                            style: regular12TextStyle(cWhiteColor),
                          ),
                        ],
                      ),
                    ),
                  if (!selfieController.isTextFieldShow.value)
                    Positioned(
                      left: 60,
                      bottom: 20,
                      child: Column(
                        children: [
                          CustomIconButton(
                            onPress: () {},
                            icon: BipHip.world,
                            iconColor: cWhiteColor,
                            size: kIconSize20,
                          ),
                          Text(
                            ksPrivacy.tr,
                            style: regular12TextStyle(cWhiteColor),
                          ),
                        ],
                      ),
                    ),
                  if (!selfieController.isTextFieldShow.value)
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: CustomElevatedButton(
                        buttonWidth: 90,
                        buttonHeight: h40,
                        buttonColor: cPrimaryColor,
                        label: ksShare.tr,
                        textStyle: semiBold16TextStyle(cWhiteColor),
                        onPressed: () {},
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
