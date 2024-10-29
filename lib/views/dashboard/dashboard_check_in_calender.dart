import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardCheckInCalender extends StatelessWidget {
  DashboardCheckInCalender({super.key});
  final DashboardController dashboardController = DashboardController();

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
              title: ksDailyCheckIn.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                children: [
                  CalendarView(),
                  kH40sizedBox,
                  Row(
                    children: [
                      Text(
                        ksCheckBonus.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kW8sizedBox,
                      InkWell(
                        onTap: () {
                          Get.find<GlobalController>().blankBottomSheet(
                            bottomSheetHeight: height * 0.2,
                            context: context,
                            content: Padding(
                              padding: const EdgeInsets.all(k20Padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ksCheckBonus.tr,
                                    style: semiBold16TextStyle(cBlackColor),
                                  ),
                                  kH8sizedBox,
                                  Text(
                                    ksLoginEverydayAndEarnNiceGift.tr,
                                    style: regular14TextStyle(cSmallBodyTextColor),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          BipHip.info,
                          size: kIconSize14,
                          color: cIconColor,
                        ),
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  Container(
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      boxShadow: const [
                        BoxShadow(
                          color: cLineColor,
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: Offset(
                            0,
                            1,
                          ),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(k12Padding),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                kiWinner,
                                width: 30,
                                height: 30,
                              ),
                              kW12sizedBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ksMysteryGiftBox.tr,
                                    style: semiBold16TextStyle(cBlackColor),
                                  ),
                                  kH4sizedBox,
                                  Text(
                                    "Login continually for 30 days",
                                    style: regular12TextStyle(cSmallBodyTextColor),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              CustomElevatedButton(
                                label: ksClaim.tr,
                                onPressed: () {},
                                textStyle: regular14TextStyle(cPrimaryColor),
                                buttonWidth: 66,
                                buttonHeight: h32,
                                buttonColor: cPrimaryTint2Color,
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: k12Padding, right: k12Padding, bottom: k12Padding, top: k8Padding),
                          child: const Timeline(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarView extends StatelessWidget {
  CalendarView({Key? key}) : super(key: key);
  final DashboardController dashboardController = DashboardController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat("MMMM, yyyy").format(dashboardController.days.value),
          style: semiBold16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        TableCalendar(
          firstDay: DateTime.utc(2024, 01, 01),
          lastDay: DateTime.utc(2024, 6, 30),
          focusedDay: dashboardController.focuseDay.value,
          onDaySelected: (selectedDay, focusedDay) {
            dashboardController.focuseDay.value = focusedDay;
            ll(dashboardController.focuseDay.value);
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerVisible: false,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            defaultTextStyle: semiBold14TextStyle(cBlackColor),
            holidayTextStyle: semiBold14TextStyle(cRedColor),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              dashboardController.days.value = day;
              return Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(color: cWhiteColor, borderRadius: BorderRadius.circular(k4BorderRadius), border: Border.all(width: 1, color: cLineColor)),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      BipHip.giftNew,
                      color: cAmberColor,
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    right: 2,
                    child: Icon(
                      BipHip.minusNew,
                      color: cIconColor,
                      size: 10,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: 2,
                    child: Text(
                      DateFormat('d').format(day),
                      style: semiBold10TextStyle(cPrimaryColor),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(8, (index) {
          return Column(
            children: [
              Row(
                children: [
                  if (index != 0)
                    Container(
                      width: h28,
                      height: h8,
                      color: cNeutralColor,
                    ),
                  Container(
                    width: h28,
                    height: h28,
                    decoration: const BoxDecoration(
                      color: cPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check, //! Icon must be change
                      color: cWhiteColor,
                      size: kIconSize14,
                    ),
                  ),
                ],
              ),
              kH8sizedBox,
              Text('${index + 1} days'),
            ],
          );
        }),
      ),
    );
  }
}
