import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizPage extends StatelessWidget {
  QuizPage({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        leaveQuizAlertDialog(
            context: context,
            content: LeaveQuizPopupContent(
                text: ksLeaveQuizConfirmation.tr,
                leaveOnPressed: () {
                  Get.offAllNamed(krHome);
                }),
            title: ksConfirmation.tr);
        return false;
      },
      child: Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: cWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                appBarColor: cWhiteColor,
                title: 'Golf Quiz',
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  // if (postReactionController.currentIndex.value > 0) {
                  //   postReactionController.currentIndex.value--;
                  // } else {
                  //   Get.back();
                  // }
                  // Get.back();
                  leaveQuizAlertDialog(
                      context: context,
                      content: LeaveQuizPopupContent(
                          text: ksLeaveQuizConfirmation.tr,
                          leaveOnPressed: () {
                            Get.offAllNamed(krHome);
                          }),
                      title: ksConfirmation.tr);
                },
                action: [
                  Padding(
                    padding: const EdgeInsets.only(right: k20Padding),
                    child: Obx(() => TextButton(
                          style: kTextButtonStyle,
                          onPressed: postReactionController.currentIndex.value < postReactionController.quizQuestions.length - 1
                              ? () {
                                  postReactionController.nextQuestion();
                                }
                              : null,
                          child: Text(
                            postReactionController.currentIndex.value < postReactionController.quizQuestions.length - 1 ? ksNext.tr : 'Finish',
                            style: semiBold16TextStyle(cPrimaryColor),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Obx(() => Column(
                    children: [
                      kH24sizedBox,
                      Container(
                        width: width - 40,
                        height: h40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: cLineColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(k8Padding),
                          child: Row(
                            children: [
                              const Icon(
                                BipHip.twitchFill,
                                color: cPrimaryColor,
                                size: kIconSize20,
                              ),
                              // LinearProgressIndicator(
                              //   color: cPaintingColor,
                              // ),
                              LinearPercentIndicator(
                                progressColor: cPrimaryColor,
                                // percent: postReactionController,
                                // percent: (postReactionController.minuteValue.value * 60 + postReactionController.secondValue.value) /
                                //     postReactionController.totalTimeInSeconds,
                                percent: 0.2,
                                barRadius: const Radius.circular(k8BorderRadius),
                                lineHeight: 10,
                                width: width - 150,
                                backgroundColor: cNeutralColor,
                              ),
                              RichText(
                                  text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '00:10',
                                    style: semiBold12TextStyle(cPrimaryColor),
                                  ),
                                  // TextSpan(
                                  //   text:
                                  //       '${postReactionController.minuteValue.value.toStringAsFixed(0)}:${postReactionController.secondValue.value.toString().padLeft(2, '0')}',
                                  //   style: semiBold12TextStyle(cPrimaryColor),
                                  // ),
                                  TextSpan(
                                    text: '/00:30',
                                    style: semiBold12TextStyle(cPlaceHolderColor),
                                  ),
                                  // TextSpan(
                                  //   text:
                                  //       '/${((postReactionController.totalTimeInSeconds - (postReactionController.minuteValue.value * 60 + postReactionController.secondValue.value)) ~/ 60).toString().padLeft(2, '0')}:${((postReactionController.totalTimeInSeconds - (postReactionController.minuteValue.value * 60 + postReactionController.secondValue.value)).remainder(60)).toString().padLeft(2, '0')}',
                                  //   style: semiBold12TextStyle(cPlaceHolderColor),
                                  // ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                      kH16sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              postReactionController.quizQuestions[postReactionController.currentIndex.value],
                              overflow: TextOverflow.clip,
                              style: semiBold14TextStyle(cBlackColor),
                            ),
                          ),
                          CustomCircularProgressBar(
                            percent: (postReactionController.currentIndex.value + 1) / (postReactionController.quizQuestions.length),
                            radius: h32,
                            lineWidth: 5,
                            centerWidget: Text(
                              '${postReactionController.currentIndex.value + 1}/${postReactionController.quizQuestions.length}',
                              style: regular16TextStyle(cBlackColor),
                            ),
                          ),
                        ],
                      ),
                      kH24sizedBox,
                      for (int i = 0; i < postReactionController.OptionsList.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: k8Padding),
                          child: CustomListTile(
                            itemColor: postReactionController.temporarySelectedAnswer.value == postReactionController.OptionsList[i]
                                ? cPrimaryTint3Color
                                : cWhiteColor,
                            onPressed: () {
                              postReactionController.temporarySelectedAnswer.value = postReactionController.OptionsList[i];
                            },
                            title: postReactionController.OptionsList[i],
                            borderColor:
                                postReactionController.temporarySelectedAnswer.value == postReactionController.OptionsList[i] ? cPrimaryColor : cLineColor,
                            trailing: CustomRadioButton(
                              onChanged: () {
                                postReactionController.temporarySelectedAnswer.value = postReactionController.OptionsList[i];
                              },
                              isSelected: postReactionController.temporarySelectedAnswer.value == postReactionController.OptionsList[i],
                            ),
                          ),
                        ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

void leaveQuizAlertDialog({required BuildContext context, required Widget content, required String title}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
      title: title,
    ),
  );
}

class LeaveQuizPopupContent extends StatelessWidget {
  const LeaveQuizPopupContent({super.key, required this.text, this.leaveOnPressed});
  final String text;
  final VoidCallback? leaveOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k12Padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: regular14TextStyle(cBlackColor),
            textAlign: TextAlign.center,
          ),
          kH20sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                label: ksCancel.tr,
                onPressed: () {
                  Get.back();
                },
                buttonColor: cWhiteColor,
                borderColor: cRedColor,
                textStyle: semiBold18TextStyle(cRedColor),
                buttonHeight: h44,
                buttonWidth: 100,
              ),
              CustomElevatedButton(
                label: ksLeave.tr,
                onPressed: leaveOnPressed,
                buttonColor: cRedColor,
                borderColor: cRedColor,
                textStyle: semiBold18TextStyle(cWhiteColor),
                buttonHeight: h44,
                buttonWidth: 100,
              ),
            ],
          ),
          kH20sizedBox,
        ],
      ),
    );
  }
}
