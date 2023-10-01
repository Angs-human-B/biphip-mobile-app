import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/post_upper_container.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';

class CommonPostWidget extends StatelessWidget {
  const CommonPostWidget({super.key, required this.isCommented, required this.isLiked});
  final bool isCommented, isLiked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLiked)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
            child: Row(
              children: [
                kW8sizedBox,
                Stack(
                  children: [
                    const SizedBox(
                      width: 40,
                      height: 20,
                    ),
                    for (int index = 0; index < 3; index++)
                      Positioned(
                        left: index * 10,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: cWhiteColor, width: 1),
                          ),
                          child: Image.asset(
                            'assets/images/profileDefault.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  ],
                ),
                kW8sizedBox,
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Aminul Islam Rana and 10 other ', style: semiBold14TextStyle(cBlackColor)),
                  TextSpan(text: 'liked it.', style: regular14TextStyle(cSmallBodyTextColor))
                ]))
              ],
            ),
          ),
        if (isCommented)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k10Padding),
            child: Row(
              children: [
                kW8sizedBox,
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Aminul Islam Rana ', style: semiBold14TextStyle(cBlackColor)),
                  TextSpan(text: 'commented.', style: regular14TextStyle(cSmallBodyTextColor))
                ])),
              ],
            ),
          ),
        const CustomDivider(),
        kH10sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: PostUpperContainer(),
        )
      ],
    );
  }
}
