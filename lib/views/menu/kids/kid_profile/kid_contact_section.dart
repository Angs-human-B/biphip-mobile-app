import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_edit_about.dart';

class KidContactSection extends StatelessWidget {
  KidContactSection({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Text(
              ksContactDetails.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer(
                suffixText: ksPhone.tr,
                isAddButton: true,
                suffixOnPressed: () {
                  // editProfileHelper.addPhone();//!write function
                },
              ),
            ),
            for (int i = 0; i < kidsController.phoneNumberList.length; i++)
              // if (kidsController.phoneNumberList[i].type == 'phone')//!Use it when api call
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(kidsController.phoneNumberList[i]),
                  isAddButton: false,
                  suffixOnPressed: () {
                    // editProfileHelper.editPhone(i);//! Write function
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer(
                suffixText: ksEmail.tr,
                isAddButton: true,
                suffixOnPressed: () {
                  // editProfileHelper.addEmail();//!Add email function write
                },
              ),
            ),
            for (int i = 0; i < kidsController.emailList.length; i++)
              // if (profileController.contactDataList[i].type == 'email')//!use condition when api call in future
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(kidsController.emailList[i]),
                  isAddButton: false,
                  suffixOnPressed: () {
                    // editProfileHelper.editEmail(i);//!Function write for edit kid email
                  },
                ),
              ),
            kH4sizedBox
          ],
        ),
      ),
    );
  }
}
