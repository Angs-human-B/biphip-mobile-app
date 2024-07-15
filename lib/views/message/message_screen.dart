import 'package:bip_hip/utils/constants/imports.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          child: Scaffold(
            backgroundColor: cWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  Get.back();
                },
                action: [
                  Padding(
                    padding: const EdgeInsets.only(right: h20),
                    child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {},
                      child: Icon(
                        BipHip.video,
                        color: cPrimaryColor,
                        size: isDeviceScreenLarge() ? 24 : 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: h20),
                    child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {},
                      child: Icon(
                        BipHip.phoneFill,
                        color: cPrimaryColor,
                        size: isDeviceScreenLarge() ? 24 : 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: h20),
                    child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {},
                      child: Icon(
                        BipHip.info,
                        color: cPrimaryColor,
                        size: isDeviceScreenLarge() ? 24 : 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: cPrimaryColor,
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
