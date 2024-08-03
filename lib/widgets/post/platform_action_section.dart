import 'package:bip_hip/utils/constants/imports.dart';

class PlatformActionSection extends StatelessWidget {
  const PlatformActionSection({super.key, this.actionOnPressed, required this.platformName, this.platformLink, required this.actionName});

  final VoidCallback? actionOnPressed;
  final String platformName, actionName;
  final String? platformLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: h60,
      decoration: BoxDecoration(color: cBackgroundColor, borderRadius: k4CircularBorderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k12Padding, vertical: k12Padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    platformName,
                    overflow: TextOverflow.ellipsis,
                    style: semiBold14TextStyle(cBlackColor),
                  ),
                  if (platformLink != null)
                    Padding(
                      padding: const EdgeInsets.only(top: k4Padding),
                      child: Text(
                        platformLink!,
                        overflow: TextOverflow.ellipsis,
                        style: regular10TextStyle(cSmallBodyTextColor),
                      ),
                    ),
                ],
              ),
            ),
            CustomElevatedButton(
              label: actionName,
              textStyle: regular14TextStyle(cWhiteColor),
              buttonHeight: 24,
              buttonWidth: 100,
              onPressed: actionOnPressed,
              buttonColor: cPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}
