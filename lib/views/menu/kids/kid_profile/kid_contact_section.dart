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
    return Obx(
      () => Container(
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
                    kidHelper.kidAddPhone();
                  },
                ),
              ),
              // for (int i = 0; i < kidsController.phoneData.length; i++)
              // if (kidsController.phoneNumberList[i].type == 'phone')//!Use it when api call
              if (kidsController.phoneData.value != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(kidsController.phoneData.value),
                    isAddButton: false,
                    suffixOnPressed: () {
                      // kidHelper.editKidPhone(i);
                      kidHelper.editKidPhone();
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: ksEmail.tr,
                  isAddButton: true,
                  suffixOnPressed: () {
                    kidHelper.kidAddEmail();
                  },
                ),
              ),
              // for (int i = 0; i < kidsController.emailDataList.length; i++)
              // if (profileController.contactDataList[i].type == 'email')//!use condition when api call in future
              if (kidsController.emailData.value != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(kidsController.emailData.value),
                    isAddButton: false,
                    suffixOnPressed: () {
                      kidHelper.editKidEmail();
                    },
                  ),
                ),
              kH4sizedBox
            ],
          ),
        ),
      ),
    );
  }
}
