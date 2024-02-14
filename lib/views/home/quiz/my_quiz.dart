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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
