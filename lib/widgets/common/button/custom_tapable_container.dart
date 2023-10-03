import 'package:bip_hip/utils/constants/imports.dart';

class TapAbleButtonContainer extends StatelessWidget {
  const TapAbleButtonContainer({
    Key? key,
    required this.buttonState,
    required this.buttonPress,
    required this.buttonText,
  }) : super(key: key);

  final RxList buttonState;
  final RxList buttonPress;
  final RxList buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        color: cNeutralColor,
      ),
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < buttonState.length; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k2Padding, vertical: k2Padding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    child: TextButton(
                      onPressed: buttonPress[i],
                      style: kTextButtonStyle,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                         
                          color: buttonState[i] ? cWhiteColor : cNeutralColor,
                        ),
                        child: Center(
                          child: Text(
                            buttonText[i],
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
