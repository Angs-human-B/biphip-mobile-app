import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/shimmers/birthday/birthday_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:intl/intl.dart';

class BirthdayPage extends StatelessWidget {
  BirthdayPage({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
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
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: pendentBadgesController.isBirthdayLoading.value
                                ? const BirthdayPageShimmer()
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      kH16sizedBox,
                                      Text(
                                        ksTodaysBirthday.tr,
                                        style: semiBold18TextStyle(cBlackColor),
                                      ),
                                      kH16sizedBox,
                                      if (pendentBadgesController.todayBirthdayList.isEmpty)
                                        BirthdayEmptyView(
                                          title: ksNoOnesBirthdayToday.tr,
                                        ),
                                      if (pendentBadgesController.todayBirthdayList.isNotEmpty)
                                        ListView.separated(
                                          itemCount: pendentBadgesController.todayBirthdayList.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) => kH16sizedBox,
                                          itemBuilder: (context, index) {
                                            return BirthdayCommonView(
                                              userImage: pendentBadgesController.todayBirthdayList[index].profilePicture,
                                              name: pendentBadgesController.todayBirthdayList[index].fullName,
                                              birthday: 'Today',
                                              birthDate: DateFormat('dd MMMM').format(pendentBadgesController.todayBirthdayList[index].dob),
                                              age: pendentBadgesController.todayBirthdayList[index].yearsOld.toString(),
                                              birthdayTextEditingControllerValue: pendentBadgesController.todayBirthdayTimelineTextEditingController[index],
                                              isBirthdaySendButtonEnabled: pendentBadgesController.todayBirthdaySendButtonEnabled[index],
                                              isAlreadyWished: pendentBadgesController.todayBirthdayList[index].myWish == null ? true : false,
                                              userId: pendentBadgesController.todayBirthdayList[index].id,
                                              // isTimelinePostEnabled: todayBirthdays[index]['isAlreadyWished'],
                                            );
                                          },
                                        ),
                                      kH16sizedBox,
                                      Text(
                                        ksIn2Days.tr,
                                        style: semiBold18TextStyle(cBlackColor),
                                      ),
                                      kH16sizedBox,
                                      if (pendentBadgesController.inTwoDaysBirthdayList.isEmpty)
                                        BirthdayEmptyView(
                                          title: ksNoOnesBirthdayInTwoDays.tr,
                                        ),
                                      if (pendentBadgesController.inTwoDaysBirthdayList.isNotEmpty)
                                        ListView.separated(
                                          itemCount: pendentBadgesController.inTwoDaysBirthdayList.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) => kH16sizedBox,
                                          itemBuilder: (context, index) {
                                            return BirthdayCommonView(
                                              userImage: pendentBadgesController.inTwoDaysBirthdayList[index].profilePicture,
                                              name: pendentBadgesController.inTwoDaysBirthdayList[index].fullName,
                                              birthday: 'In 2 days',
                                              birthDate: DateFormat('dd MMMM').format(pendentBadgesController.inTwoDaysBirthdayList[index].dob),
                                              age: pendentBadgesController.inTwoDaysBirthdayList[index].yearsOld.toString(),
                                              birthdayTextEditingControllerValue: pendentBadgesController.inTwoDaysBirthdayTimelineTextEditingController[index],
                                              isBirthdaySendButtonEnabled: pendentBadgesController.inTwoDaysBirthdaySendButtonEnabled[index],
                                              isAlreadyWished: pendentBadgesController.inTwoDaysBirthdayList[index].myWish == null ? true : false,
                                              userId: pendentBadgesController.inTwoDaysBirthdayList[index].id,
                                              // isTimelinePostEnabled: inTwoDaysBirthdays[index]['isAlreadyWished'],
                                            );
                                          },
                                        ),
                                      kH16sizedBox,
                                      Text(
                                        ksUpcomingBirthdays.tr,
                                        style: semiBold18TextStyle(cBlackColor),
                                      ),
                                      kH16sizedBox,
                                      if (pendentBadgesController.upcomingsBirthdayList.isEmpty)
                                        BirthdayEmptyView(
                                          title: ksNoOnesUpcomingBirthday.tr,
                                        ),
                                      if (pendentBadgesController.upcomingsBirthdayList.isNotEmpty)
                                        ListView.separated(
                                          itemCount: pendentBadgesController.upcomingsBirthdayList.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) => kH16sizedBox,
                                          itemBuilder: (context, index) {
                                            return BirthdayCommonView(
                                              userImage: pendentBadgesController.upcomingsBirthdayList[index].profilePicture,
                                              name: pendentBadgesController.upcomingsBirthdayList[index].fullName,
                                              birthday: 'Upcoming',
                                              birthDate: DateFormat('dd MMMM').format(pendentBadgesController.upcomingsBirthdayList[index].dob),
                                              age: pendentBadgesController.upcomingsBirthdayList[index].yearsOld.toString(),
                                              isTodayOrIn2DaysBirthday: false,
                                              birthdayTextEditingControllerValue: pendentBadgesController.upcomingBirthdayTimelineTextEditingController[index],
                                              isAlreadyWished: pendentBadgesController.upcomingsBirthdayList[index].myWish == null ? true : false,
                                              userId: pendentBadgesController.upcomingsBirthdayList[index].id,
                                              // isTimelinePostEnabled: upcomingBirthdays[index]['isAlreadyWished'],
                                            );
                                          },
                                        ),
                                      kH16sizedBox,
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (pendentBadgesController.isBirthdayWishLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (pendentBadgesController.isBirthdayWishLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BirthdayCommonView extends StatelessWidget {
  BirthdayCommonView(
      {super.key,
      this.userImage,
      this.name,
      this.birthday,
      this.birthDate,
      this.age,
      this.isTodayOrIn2DaysBirthday = true,
      required this.birthdayTextEditingControllerValue,
      // this.isTimelinePostEnabled,
      this.isAlreadyWished,
      this.isBirthdaySendButtonEnabled,
      this.userId});
  final String? userImage;
  final String? name;
  final String? birthday;
  final String? birthDate;
  final String? age;
  final bool? isTodayOrIn2DaysBirthday;
  final TextEditingController birthdayTextEditingControllerValue;
  final RxBool? isBirthdaySendButtonEnabled;
  // final bool? isTimelinePostEnabled;
  final bool? isAlreadyWished;
  final int? userId;
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

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
                      userImage ?? '',
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
                          ", $age years old",
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // if (isTodayOrIn2DaysBirthday == true && isTimelinePostEnabled == false)
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
          // if (isTodayOrIn2DaysBirthday == true && isTimelinePostEnabled == false && isAlreadyWished == true)
          if (isTodayOrIn2DaysBirthday == true && isAlreadyWished == true)
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
                        if (birthdayTextEditingControllerValue.text.toString().trim() != '') {
                          isBirthdaySendButtonEnabled!.value = true;
                        } else {
                          isBirthdaySendButtonEnabled!.value = false;
                        }
                      },
                    ),
                  ),
                  kW12sizedBox,
                  Obx(() => CustomElevatedButton(
                        label: ksSend.tr,
                        onPressed: isBirthdaySendButtonEnabled!.value
                            ? () async {
                                pendentBadgesController.userId.value = userId!;
                                pendentBadgesController.birthdayWishContent.value = birthdayTextEditingControllerValue.text.toString().trim();
                                pendentBadgesController.birthdayWish();
                              }
                            : null,
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
                onPressed: null,
              ),
            ),
          //*Timeline post disable option api have no prameter for differenciate this
          // if (isTodayOrIn2DaysBirthday == true && isTimelinePostEnabled == true)
          // if (isTodayOrIn2DaysBirthday == true)
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          //   child: CustomElevatedButton(
          //       buttonWidth: width - 82,
          //       buttonHeight: h32,
          //       buttonColor: cPrimaryTint2Color,
          //       borderColor: cPrimaryColor,
          //       textStyle: regular12TextStyle(cBlackColor),
          //       label: ksWishInChat.tr,
          //       suffixIcon: BipHip.chatFill,
          //       suffixIconColor: cPrimaryColor,
          //       onPressed: () {}),
          // ),
        ],
      ),
    );
  }
}

class BirthdayEmptyView extends StatelessWidget {
  const BirthdayEmptyView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 120,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Center(
        child: Text(
          title,
          style: semiBold14TextStyle(cSmallBodyTextColor),
        ),
      ),
    );
  }
}
