import 'package:bip_hip/utils/constants/imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Scaffold(
      backgroundColor: cWhiteColor,
      body: SizedBox(
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kiLogoImageUrl,
                height: 80,
                width: 80,
              ),
              kH8sizedBox,
              Text(
                ksBipHip.tr,
                style: semiBold20TextStyle(cPrimaryColor).copyWith(fontSize: h26),
              )
            ],
          ),
        ),
      ),
    );
  }
}
