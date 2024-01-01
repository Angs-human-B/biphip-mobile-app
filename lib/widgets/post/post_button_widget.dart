import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorBuilder.dart';

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
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                  child: Image.network(
                    profilePic.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const CommonImageErrorBuilder(
                      icon: BipHip.user,
                      iconSize: kIconSize20,
                    ),
                  ),
                ),
              ),
              kW12sizedBox,
              Expanded(
                child: Text(
                  '${ksWhatsOnYourMind.tr}, $name?',
                  style: regular14TextStyle(cIconColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              prefixWidget ?? const SizedBox(),
              kW20sizedBox
            ],
          ),
        ),
      ),
    );
  }
}
