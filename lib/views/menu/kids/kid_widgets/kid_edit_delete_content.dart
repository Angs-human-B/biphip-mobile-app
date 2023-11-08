import 'package:bip_hip/helpers/kids_helper/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class EditDeleteContent extends StatelessWidget {
   EditDeleteContent({
    super.key,
  });
  final KidHelper _kidHelper = KidHelper();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksEditKid.tr,
          prefixIcon: BipHip.edit,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () {
          _kidHelper.kidEditButtonOnPressed();
            Get.toNamed(krEditKidPage);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CustomElevatedButton(
          label: ksDeleteKid.tr,
          prefixIcon: BipHip.delete,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () {
            _kidHelper.kidDeleteButtonOnPressed();
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}
