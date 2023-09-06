import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/logo_and_text_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Scaffold(
      backgroundColor: cWhiteColor,
      body: SizedBox(
        height: height,
        child: const Center(
          child: LogoAndText(
            size: 80.0,
            fontSize: h26,
          ),
        ),
      ),
    );
  }
}
