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
                    () {
                      unFocus(context);
                      postReactionController.playedQuizTapableButtonOnPressed();
                    },
                    () {
                      unFocus(context);
                      postReactionController.winnerQuizTapableButtonOnPressed();
                    },
                  ]),
                ),
                if (postReactionController.quizTapButtonState[0]) MyDailyQuiz(),
                if (postReactionController.quizTapButtonState[1]) MyPlayedQuiz(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPlayedQuiz extends StatelessWidget {
  const MyPlayedQuiz({super.key});

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
        CommonDailyAndPlayedQuiz(
          image:
              'https://images.unsplash.com/photo-1500076656116-558758c991c1?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          title: 'How to play golf like pros',
          noOfQuestions: 'Correct Answer: 5/12',
          totalTime: 'Taken Time: 20 Sec',
          actionText: 'Score: 10',
          icon: BipHip.rightArrow,
          actionTextStyle: semiBold14TextStyle(cPrimaryColor),
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
          actionText: 'Score',
          actionTextStyle: semiBold14TextStyle(cPrimaryColor),
          image1: 'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
          image2: 'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
          image3: 'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
          othersText: '+99',
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
    this.image1,
    this.image2,
    this.image3,
    this.othersText,
  });
  final String? image;
  final String title;
  final String noOfQuestions;
  final String totalTime;
  final String actionText;
  final TextStyle actionTextStyle;
  final IconData? icon;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? othersText;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    actionText,
                    style: actionTextStyle,
                  ),
                  if (icon != null)
                    Icon(
                      icon,
                      size: kIconSize14,
                      color: cPrimaryColor,
                    ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      if (image1 != null)
                        Container(
                          width: h20,
                          height: h20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: cWhiteColor,
                          ),
                          child: Image.network(
                            image1!,
                            // width: 20,
                            // height: 20,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(kiDummyImage1ImageUrl);
                            },
                            loadingBuilder: imageLoadingBuilder,
                          ),
                        ),
                      if (image2 != null)
                        Container(
                          width: h20,
                          height: h20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: cWhiteColor,
                          ),
                          child: Image.network(image2!),
                        ),
                      if (image3 != null)
                        Container(
                          width: h20,
                          height: h20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: cWhiteColor,
                          ),
                          child: Image.network(image3!),
                        ),
                      if (othersText != null)
                        Container(
                          width: h20,
                          height: h20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: cBlackColor,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              othersText!,
                              style: regular10TextStyle(cWhiteColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
