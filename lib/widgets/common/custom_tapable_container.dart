import 'package:bip_hip/utils/constants/imports.dart';

class TapAbleButtonContainer extends StatelessWidget {
  const TapAbleButtonContainer({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.firstButtonOnPressed,
    required this.secondButtonOnPressed,
    required this.thirdButtonOnPressed,
    required this.firstButtonClicked,
    required this.secondButtonClicked,
  }) : super(key: key);

  final VoidCallback? firstButtonOnPressed, secondButtonOnPressed, thirdButtonOnPressed;
  final String firstText, secondText, thirdText;
  final RxBool firstButtonClicked, secondButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        color: cNutralColor,
      ),
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: k2Padding, vertical: k2Padding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: TextButton(
                    onPressed: firstButtonOnPressed,
                    style: kTextButtonStyle,
                    child: Container(
                      // height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        boxShadow: const [
                          BoxShadow(
                            color: cNutralColor,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(4, 8),
                          ),
                        ],
                        color: firstButtonClicked.value && !secondButtonClicked.value ? cWhiteColor : cNutralColor,
                      ),
                      child: Center(
                        child: Text(
                          firstText,
                          style: medium14TextStyle(cBlackColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: k2Padding, vertical: k2Padding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: TextButton(
                    onPressed: secondButtonOnPressed,
                    style: kTextButtonStyle,
                    child: Container(
                      // height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        color: !firstButtonClicked.value && secondButtonClicked.value ? cWhiteColor : cNutralColor,
                        boxShadow: const [
                          BoxShadow(
                            color: cNutralColor,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(4, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          secondText,
                          style: medium14TextStyle(cBlackColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: k2Padding, vertical: k2Padding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: TextButton(
                    onPressed: thirdButtonOnPressed,
                    style: kTextButtonStyle,
                    child: Container(
                      // height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        color: !firstButtonClicked.value && !secondButtonClicked.value ? cWhiteColor : cNutralColor,
                        boxShadow: const [
                          BoxShadow(
                            color: cNutralColor,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(4, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          thirdText,
                          style: medium14TextStyle(cBlackColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}