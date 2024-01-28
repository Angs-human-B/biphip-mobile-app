import 'package:bip_hip/utils/constants/imports.dart';

class AddKidContactInfo extends StatelessWidget {
  const AddKidContactInfo({super.key});

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
              title: ksAddKid.tr,
              hasBackButton: false,
              leadingWidth: 80,
              leadingWidget: Center(
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    ksPrevious.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              ),
              isCenterTitle: true,
              onBack: () {},
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {},
                    child: Text(
                      ksNext.tr,
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
