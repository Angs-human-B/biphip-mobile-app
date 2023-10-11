import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/logo_and_text_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Scaffold(
      backgroundColor: cWhiteColor,
      body: SizedBox(
        height: height,
        width: width,
        child: const LogoAndText(
          size: 80.0,
          fontSize: h26,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
