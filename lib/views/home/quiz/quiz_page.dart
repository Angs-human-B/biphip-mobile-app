import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

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
              appBarColor: cWhiteColor,
              title: 'Golf Quiz',
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k20Padding),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {},
                    child: Text(
                      ksNext.tr,
                      style: semiBold16TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH24sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "What is the term for the number of strokes a skilled golfer should take to complete a hole or round of golf, considering the course's difficulty?",
                        overflow: TextOverflow.clip,
                        style: semiBold14TextStyle(cBlackColor),
                      ),
                    ),
                    CustomCircularProgressBar(
                      percent: 0.2,
                      radius: h32,
                      lineWidth: 5,
                      centerWidget: Text(
                        '1/5',
                        style: regular16TextStyle(cBlackColor),
                      ),
                    ),
                  ],
                ),
                kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}
