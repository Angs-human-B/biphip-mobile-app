import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class BirthdayPage extends StatelessWidget {
  BirthdayPage({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    final todayBirthdays = pendentBadgesController.birthdayList.where((item) => item['birthday'] == 'Today').toList();
    final inTwoDaysBirthdays = pendentBadgesController.birthdayList.where((item) => item['birthday'] != 'Today' && item['birthday'] != 'Upcoming').toList();
    final upcomingBirthdays = pendentBadgesController.birthdayList.where((item) => item['birthday'] == 'Upcoming').toList();
    for (int i = 0; i < todayBirthdays.length; i++) {
      pendentBadgesController.todayBirthdayTimelineTextEditingController.add(TextEditingController());
    }
    for (int i = 0; i < inTwoDaysBirthdays.length; i++) {
      pendentBadgesController.in2DaysBirthdayTimelineTextEditingController.add(TextEditingController());
    }
    for (int i = 0; i < upcomingBirthdays.length; i++) {
      pendentBadgesController.upcomingBirthdayTimelineTextEditingController.add(TextEditingController());
    }
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
              title: ksBirthday.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kH16sizedBox,
                        Text(
                          ksTodaysBirthday.tr,
                          style: semiBold18TextStyle(cBlackColor),
                        ),
                        kH16sizedBox,
                        if (todayBirthdays.isNotEmpty)
                          ListView.separated(
                            itemCount: todayBirthdays.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (context, index) {
                              return BirthdayCommonView(
                                userImage: todayBirthdays[index]['image'],
                                name: todayBirthdays[index]['name'],
                                birthday: todayBirthdays[index]['birthday'],
                                birthDate: todayBirthdays[index]['birthDate'],
                                age: todayBirthdays[index]['age'],
                                birthdayTextEditingControllerValue: pendentBadgesController.todayBirthdayTimelineTextEditingController[index],
                                isAlreadyWished: todayBirthdays[index]['isTimelinePostEnable'],
                                isTimelinePostEnabled: todayBirthdays[index]['isAlreadyWished'],
                              );
                            },
                          ),
                        kH16sizedBox,
                        Text(
                          ksIn2Days.tr,
                          style: semiBold18TextStyle(cBlackColor),
                        ),
                        kH16sizedBox,
                        ListView.separated(
                          itemCount: inTwoDaysBirthdays.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => kH16sizedBox,
                          itemBuilder: (context, index) {
                            return BirthdayCommonView(
                              userImage: inTwoDaysBirthdays[index]['image'],
                              name: inTwoDaysBirthdays[index]['name'],
                              birthday: inTwoDaysBirthdays[index]['birthday'],
                              birthDate: inTwoDaysBirthdays[index]['birthDate'],
                              age: inTwoDaysBirthdays[index]['age'],
                              birthdayTextEditingControllerValue: pendentBadgesController.in2DaysBirthdayTimelineTextEditingController[index],
                              isAlreadyWished: inTwoDaysBirthdays[index]['isTimelinePostEnable'],
                              isTimelinePostEnabled: inTwoDaysBirthdays[index]['isAlreadyWished'],
                            );
                          },
                        ),
                        kH16sizedBox,
                        Text(
                          ksUpcomingBirthdays.tr,
                          style: semiBold18TextStyle(cBlackColor),
                        ),
                        kH16sizedBox,
                        ListView.separated(
                          itemCount: upcomingBirthdays.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => kH16sizedBox,
                          itemBuilder: (context, index) {
                            return BirthdayCommonView(
                              userImage: upcomingBirthdays[index]['image'],
                              name: upcomingBirthdays[index]['name'],
                              birthday: upcomingBirthdays[index]['birthday'],
                              birthDate: upcomingBirthdays[index]['birthDate'],
                              age: upcomingBirthdays[index]['age'],
                              isTodayOrIn2DaysBirthday: false,
                              birthdayTextEditingControllerValue: pendentBadgesController.upcomingBirthdayTimelineTextEditingController[index],
                              isAlreadyWished: upcomingBirthdays[index]['isTimelinePostEnable'],
                              isTimelinePostEnabled: upcomingBirthdays[index]['isAlreadyWished'],
                            );
                          },
                        ),
                      ],
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

class BirthdayCommonView extends StatelessWidget {
  const BirthdayCommonView(
      {super.key,
      this.userImage,
      this.name,
      this.birthday,
      this.birthDate,
      this.age,
      this.isTodayOrIn2DaysBirthday = true,
      required this.birthdayTextEditingControllerValue,
      this.isTimelinePostEnabled,
      this.isAlreadyWished});
  final String? userImage;
  final String? name;
  final String? birthday;
  final String? birthDate;
  final String? age;
  final bool? isTodayOrIn2DaysBirthday;
  final TextEditingController birthdayTextEditingControllerValue;
  final bool? isTimelinePostEnabled;
  final bool? isAlreadyWished;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: isTodayOrIn2DaysBirthday! ? 150 : 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: k16Padding,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: k16Padding, right: k8Padding),
                  child: ClipOval(
                    child: Image.network(
                      userImage!,
                      width: 50,
                      height: 50,
                      loadingBuilder: imageLoadingBuilder,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          kiProfileDefaultImageUrl,
                          height: h40,
                          width: h40,
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Row(
                      children: [
                        Text(
                          birthday!,
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                        Text(
                          ", $birthDate",
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                        Text(
                          ", $age",
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                if (isTodayOrIn2DaysBirthday == true)
                  Padding(
                    padding: const EdgeInsets.only(right: k16Padding),
                    child: Container(
                      width: 48,
                      height: h32,
                      decoration: BoxDecoration(
                        color: cPrimaryTint2Color,
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        border: Border.all(color: cPrimaryColor, width: 1),
                      ),
                      child: CustomIconButton(
                        onPress: () {},
                        icon: BipHip.chatOutline,
                        size: kIconSize14,
                        iconColor: cPrimaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          kH20sizedBox,
          if (isTodayOrIn2DaysBirthday == true && isTimelinePostEnabled == false && isAlreadyWished == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 220,
                    height: h40,
                    child: CustomModifiedTextField(
                      controller: birthdayTextEditingControllerValue,
                      maxLength: 255,
                      maxLines: 1,
                      minLines: 1,
                      isFilled: false,
                      fillColor: cWhiteColor,
                      inputAction: TextInputAction.newline,
                      inputType: TextInputType.multiline,
                      hint: ksWriteOnTimeline.tr,
                      contentPadding: const EdgeInsets.only(top: k8Padding, bottom: k8Padding, left: k8Padding),
                      textHintStyle: regular12TextStyle(cPlaceHolderColor),
                      textInputStyle: regular12TextStyle(cBlackColor),
                      suffixIcon: BipHip.emojiOutline,
                      suffixIconColor: cIconColor,
                      suffixIconSize: kIconSize16,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: cLineColor,
                          width: 1.0,
                        ),
                      ),
                      onChanged: (v) {
                        if (birthdayTextEditingControllerValue.text.toString() != '') {
                          Get.find<PendentBadgesController>().isBirthdaySendButtonEnable.value = true;
                        } else {
                          Get.find<PendentBadgesController>().isBirthdaySendButtonEnable.value = false;
                        }
                      },
                    ),
                  ),
                  kW12sizedBox,
                  Obx(() => CustomElevatedButton(
                        label: ksSend.tr,
                        onPressed: Get.find<PendentBadgesController>().isBirthdaySendButtonEnable.value ? () {} : null,
                        buttonWidth: 64,
                        buttonHeight: h32,
                        buttonColor: cPrimaryColor,
                        textStyle: semiBold14TextStyle(cWhiteColor),
                      )),
                ],
              ),
            ),
          if (isTodayOrIn2DaysBirthday == true && isAlreadyWished == false)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: CustomElevatedButton(
                  buttonWidth: width - 82,
                  buttonHeight: h32,
                  buttonColor: cPrimaryColor,
                  textStyle: regular12TextStyle(cWhiteColor),
                  label: ksViewPost.tr,
                  onPressed: () {}),
            ),
          if (isTodayOrIn2DaysBirthday == true && isTimelinePostEnabled == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: CustomElevatedButton(
                  buttonWidth: width - 82,
                  buttonHeight: h32,
                  buttonColor: cPrimaryTint2Color,
                  borderColor: cPrimaryColor,
                  textStyle: regular12TextStyle(cBlackColor),
                  label: ksWishInChat.tr,
                  suffixIcon: BipHip.chatFill,
                  suffixIconColor: cPrimaryColor,
                  onPressed: () {}),
            ),
        ],
      ),
    );
  }
}
