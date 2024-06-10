import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final RxList dashboardOverviewFilterList = RxList(["Overview", "Insights", "Profile Eligibility", "Tools"]);
  final RxInt dashboardOverviewSelectedFilterIndex = RxInt(0);
  final RxString dashboardOverviewSelectedFilterValue = RxString("Overview");
  final RxString dashboardOverviewTime = RxString("From previous 28 days");
    final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final List selectDateTimeFilterList = ["Today", "Yesterday", "This Week", "This Month", "This Year", "Custom"];
  final RxList ageGenderDataList = RxList([
    {'ageGroup': '18-24', 'men': 80, 'women': 20},
    {'ageGroup': '25-34', 'men': 90, 'women': 10},
    {'ageGroup': '35-44', 'men': 60, 'women': 40},
    {'ageGroup': '45-54', 'men': 51.5, 'women': 48.5},
  ]);
  final RxList topCitiesList = RxList([
    {'cityName': "Dhaka, Bangladesh", 'percent': 50},
    {'cityName': "Chapainawabganj, Bangladesh", 'percent': 20},
    {'cityName': "Rajshahi, Bangladesh", 'percent': 25},
    {'cityName': "Gazipur, Bangladesh", 'percent': 5},
  ]);
  final RxList dashboardEarnedGiftPostList = RxList([
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0"
    },
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0"
    },
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0"
    },
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0"
    },
  ]);
  String bashboardOverviewAppbarTitle(int index){
    if(index==0){
      return ksOverview.tr;
    }
    else if(index==1){
      return ksInsights.tr;
    }
    else if(index==2){
      return ksProfileEligibility.tr;
    }
    else{
      return ksTools.tr;
    }
  }
}
