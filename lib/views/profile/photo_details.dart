import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';

class PhotoDetails extends StatelessWidget {
  PhotoDetails({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: 'Photos'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                children: [
                  kH24sizedBox,
                  ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: Image.asset(_profileController.photoLink.value),
                  ),
                  kH20sizedBox,
                  const CustomDivider(),
                  kH20sizedBox,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [InteractionStats(), UserInteractionView()],
                  ),
                  kH20sizedBox,
                  const CustomDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InteractionStats extends StatelessWidget {
  const InteractionStats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const Icon(
                BipHip.view,
                color: cGreenColor,
              ),
              kH4sizedBox,
              Text(
                '7.1 k',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.love,
                color: cRedColor,
              ),
              kH4sizedBox,
              Text(
                '1.1 k',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.comment,
                color: cStoryTellingColor,
              ),
              kH4sizedBox,
              Text(
                '790',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.share,
                color: cPrimaryColor,
              ),
              kH4sizedBox,
              Text(
                '440',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.giftNew,
                color: cSecondaryColor,
              ),
              kH4sizedBox,
              Text(
                '440',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          )
        ],
      ),
    );
  }
}

class UserInteractionView extends StatelessWidget {
  const UserInteractionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            const SizedBox(
              width: 75,
              height: 21,
            ),
            for (int index = 0; index < 6; index++)
              Positioned(
                left: index * 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: cPrimaryColor,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: cPrimaryColor, width: 1),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profileDefault.png',
                      fit: BoxFit.cover,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
        kH10sizedBox,
        Text(
          'Tanmoy and 432+ more liked',
          style: semiBold8TextStyle(cBlackColor),
        )
      ],
    );
  }
}
