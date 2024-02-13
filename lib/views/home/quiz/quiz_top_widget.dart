import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class QuizTopWidget extends StatelessWidget {
  const QuizTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SizedBox(
        width: width,
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(k8BorderRadius),
              child: Image.asset(
                kiDummyImage1ImageUrl,
                width: width - 40,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: h8,
              left: (width - 40) / 2.5,
              child: Text(
                'Golf Quiz',
                style: semiBold12TextStyle(cWhiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizFirstBottomSheetContent extends StatelessWidget {
  const QuizFirstBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          child: Image.asset(
            kiDummyImage1ImageUrl,
            width: width - 40,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        kH16sizedBox,
        Text(
          ksDailyQuiz,
          style: semiBold14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        const IconAndTextRow(
          icon: BipHip.activity,
          title: 'Duration: 21st August - 27th August ( 08:35 AM - 10:35 AM)',
        ),
        kH16sizedBox,
        const IconAndTextRow(
          icon: BipHip.twitchFill,
          title: '5 min',
        ),
        kH16sizedBox,
        const IconAndTextRow(
          icon: BipHip.termsCondition,
          title: '10',
        ),
        kH30sizedBox,
        CustomElevatedButton(
            label: ksPlayNow.tr,
            onPressed: () {
              Get.back();
              Get.find<PostReactionController>().totalTimeCalculation();
              Get.find<PostReactionController>().timerStartFunction();
              Get.toNamed(krQuizPage);
            }),
      ],
    );
  }
}

class IconAndTextRow extends StatelessWidget {
  const IconAndTextRow({super.key, this.icon, this.title});
  final IconData? icon;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: kIconSize16,
              color: cIconColor,
            ),
            kW8sizedBox,
            Expanded(
              child: Text(
                title!,
                overflow: TextOverflow.clip,
                style: regular12TextStyle(cBlackColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
