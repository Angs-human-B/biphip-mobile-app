import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cGreyBoxColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cGreyBoxColor,
              title: 'Monjurul Sharker Omi'.tr,
              hasBackButton: false,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 225,
                        color: cTransparentColor,
                      ),
                      SizedBox(
                        height: 150,
                        width: width,
                        child: Image.asset(
                          'assets/images/coverPic.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        //right: ((width - 40) / 2) - ((height > kSmallDeviceSizeLimit ? kProfileImageSize : (kProfileImageSize - h10)) / 2),
                        left: 20,
                        child: Container(
                          height: height > kSmallDeviceSizeLimit ? kProfileImageSize : (kProfileImageSize - h10),
                          width: height > kSmallDeviceSizeLimit ? kProfileImageSize : (kProfileImageSize - h10),
                          decoration: BoxDecoration(
                            color: cGreyBoxColor,
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(color: cGreyBoxColor.withAlpha(500), width: 2),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profilePic4x.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
