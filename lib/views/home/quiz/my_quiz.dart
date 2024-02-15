import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class MyQuiz extends StatelessWidget {
  MyQuiz({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksQuiz.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(() => SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        TapAbleButtonContainer(
                          buttonText: postReactionController.quizTapButtonText,
                          buttonState: postReactionController.quizTapButtonState,
                          buttonPress: RxList([
                            () {
                              unFocus(context);
                              postReactionController.dailyQuizTapableButtonOnPressed();
                            },
                            () async {
                              unFocus(context);
                              postReactionController.playedQuizTapableButtonOnPressed();
                            },
                            () {
                              unFocus(context);
                              postReactionController.winnerQuizTapableButtonOnPressed();
                            },
                          ]),
                        ),
                        if (postReactionController.quizTapButtonState[0]) const MyDailyQuiz(),
                        if (postReactionController.quizTapButtonState[1]) MyPlayedQuiz(),
                        // postReactionController.isMyQuizesLoading.value ? const PlayedQuizShimmer() : MyPlayedQuiz(),
                        if (postReactionController.quizTapButtonState[2])
                          Padding(
                            padding: const EdgeInsets.only(top: k16Padding),
                            child: CustomModifiedTextField(
                                borderRadius: h8,
                                controller: postReactionController.quizWinnerTextEditingController,
                                prefixIcon: BipHip.search,
                                suffixIcon: postReactionController.isWinnerSuffixVisible.value ? BipHip.circleCrossNew : null,
                                hint: ksSearch.tr,
                                contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                                textInputStyle: regular16TextStyle(cBlackColor),
                                onSuffixPress: () {
                                  postReactionController.isWinnerSuffixVisible.value = false;
                                  postReactionController.quizWinnerTextEditingController.clear();
                                },
                                onSubmit: (v) {
                                  unfocus(context);
                                  postReactionController.isWinnerSuffixVisible.value = true;
                                },
                                onChanged: (v) {
                                  if (postReactionController.quizWinnerTextEditingController.text.toString().trim() != '') {
                                    postReactionController.isWinnerSuffixVisible.value = true;
                                  } else {
                                    postReactionController.isWinnerSuffixVisible.value = false;
                                  }
                                }),
                          )
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class MyPlayedQuiz extends StatelessWidget {
  MyPlayedQuiz({super.key});
  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH20sizedBox,
        Text(
          ksAlreadyPlayed.tr,
          style: semiBold18TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        SizedBox(
          height: height - (kAppBarSize + 30 + MediaQuery.of(context).padding.top),
          child: Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              // itemCount: postReactionController.myAllQuizesList.length,
              itemCount: 8,
              separatorBuilder: (context, index) => kH16sizedBox,
              itemBuilder: (BuildContext context, int index) {
                // return CommonDailyAndPlayedQuiz(
                //   image: postReactionController.myAllQuizesList[index].quiz!.mediaUrl,
                //   title: postReactionController.myAllQuizesList[index].quiz!.title == null
                //       ? ksNA
                //       : (postReactionController.myAllQuizesList[index].quiz!.title).toString(),
                //   noOfQuestions:
                //       "Correct Answer: ${postReactionController.myAllQuizesList[index].countRightAnswer}/${postReactionController.myAllQuizesList[index].totalMarks}",
                //   totalTime: "Taken Time: ${postReactionController.myAllQuizesList[index].elapsedTime}",
                //   actionText: "Score: ${postReactionController.myAllQuizesList[index].obtainedMarks}",
                //   actionTextStyle: semiBold14TextStyle(cPrimaryColor),
                // );
                return CommonDailyAndPlayedQuiz(
                  image:
                      'https://images.unsplash.com/photo-1500076656116-558758c991c1?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  title: 'How to play golf',
                  noOfQuestions: '12 questions',
                  totalTime: 'Duration: 30 Sec',
                  actionText: 'Score: 10',
                  actionTextStyle: semiBold14TextStyle(cPrimaryColor),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MyDailyQuiz extends StatelessWidget {
  const MyDailyQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH20sizedBox,
        Text(
          ksTodaysQuiz.tr,
          style: semiBold18TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CommonDailyAndPlayedQuiz(
          image:
              'https://images.unsplash.com/photo-1500076656116-558758c991c1?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          title: 'How to play golf',
          noOfQuestions: '12 questions',
          totalTime: 'Duration: 30 Sec',
          actionText: 'Tap to play',
          icon: BipHip.rightArrow,
          actionTextStyle: semiBold14TextStyle(cPrimaryColor),
          imageList: Get.find<PostReactionController>().quizParticipentList,
        ),
      ],
    );
  }
}

class CommonDailyAndPlayedQuiz extends StatelessWidget {
  const CommonDailyAndPlayedQuiz({
    super.key,
    this.image,
    required this.title,
    required this.noOfQuestions,
    required this.totalTime,
    required this.actionText,
    required this.actionTextStyle,
    this.icon,
    this.imageList = const [],
  });
  final String? image;
  final String title;
  final String noOfQuestions;
  final String totalTime;
  final String actionText;
  final TextStyle actionTextStyle;
  final IconData? icon;
  final List? imageList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 108,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Row(
        children: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.all(k8Padding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(kiDummyImage1ImageUrl);
                    },
                    loadingBuilder: imageLoadingBuilder,
                  ),
                ),
              ),
            ),
          if (image == null) kW8sizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH12sizedBox,
              Text(
                title,
                style: semiBold16TextStyle(cBlackColor),
                textAlign: TextAlign.left,
              ),
              kH4sizedBox,
              Text(
                noOfQuestions,
                style: regular12TextStyle(csmallBodyTextColor2),
                textAlign: TextAlign.left,
              ),
              kH4sizedBox,
              Text(
                totalTime,
                style: regular12TextStyle(csmallBodyTextColor2),
                textAlign: TextAlign.left,
              ),
              kH8sizedBox,
              SizedBox(
                width: width - (40 + 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      actionText,
                      style: actionTextStyle,
                    ),
                    if (icon != null)
                      Icon(
                        icon,
                        size: kIconSize16,
                        color: cPrimaryColor,
                      ),
                    const Spacer(),
                    Stack(
                      children: [
                        const SizedBox(
                          width: 60,
                          height: 20,
                        ),
                        if (imageList!.isNotEmpty)
                          for (int i = 0; i < 3; i++)
                            Positioned(
                              left: i * 12,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: cWhiteColor, width: 1),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    imageList![i],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                        if (imageList!.isNotEmpty && imageList != null && imageList!.length > 3)
                          Positioned(
                            left: 36,
                            child: Container(
                              width: h20,
                              height: h20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: cBlackColor,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "+" "${imageList!.length - 3}",
                                  style: regular10TextStyle(cWhiteColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlayedQuizShimmer extends StatelessWidget {
  const PlayedQuizShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 108,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(k8Padding),
            child: ShimmerCommon(
              widget: Container(
                  height: 90,
                  width: 940,
                  decoration: const BoxDecoration(
                    color: cWhiteColor,
                    shape: BoxShape.circle,
                  )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH12sizedBox,
              ShimmerCommon(
                widget: Container(
                    height: h14,
                    width: 200,
                    decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                    )),
              ),
              kH4sizedBox,
              ShimmerCommon(
                widget: Container(
                    height: h14,
                    width: 200,
                    decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                    )),
              ),
              kH4sizedBox,
              ShimmerCommon(
                widget: Container(
                    height: h14,
                    width: 200,
                    decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                    )),
              ),
              kH8sizedBox,
              SizedBox(
                width: width - (40 + 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ShimmerCommon(
                      widget: Container(
                          height: h14,
                          width: 200,
                          decoration: BoxDecoration(
                            color: cWhiteColor,
                            borderRadius: BorderRadius.circular(k8BorderRadius),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
