import 'package:bip_hip/utils/constants/imports.dart';

class CustomPostButton extends StatelessWidget {
  const CustomPostButton({super.key, this.onPressed, required this.name, required this.profilePic, this.prefixWidget});

  final VoidCallback? onPressed;
  final String name, profilePic;
  final Widget? prefixWidget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPressed,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: k12Padding),
          child: Row(
            children: [
              kW20sizedBox,
              ClipOval(
                child: Container(
                  height: h40,
                  width: h40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    profilePic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              kW12sizedBox,
              Text(
                'What\'s on your mind, $name?',
                style: regular14TextStyle(cIconColor),
              ),
              const Spacer(),
              prefixWidget ?? const SizedBox(),
              kW20sizedBox
            ],
          ),
        ),
      ),
    );
  }
}
