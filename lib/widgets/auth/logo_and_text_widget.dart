import 'package:bip_hip/utils/constants/imports.dart';

class LogoAndText extends StatelessWidget {
  const LogoAndText({
    Key? key,
    required this.size,
    required this.fontSize,
    required this.mainAxisAlignment,
  }) : super(key: key);

  final double size;
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          kiLogoImageUrl,
          height: size,
          width: size,
        ),
        kH8sizedBox,
        Text(
          ksBipHip,
          style: semiBold20TextStyle(cPrimaryColor).copyWith(fontSize: fontSize),
        )
      ],
    );
  }
}
