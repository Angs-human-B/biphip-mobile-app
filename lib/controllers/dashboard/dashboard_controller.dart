import 'package:bip_hip/models/dashboard/dashboard_contents_model.dart';
import 'package:bip_hip/models/dashboard/dashboard_profile_overview_model.dart';
import 'package:bip_hip/models/dashboard/dashboard_star_insight_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final fundTransferFilterList = RxList(["All", "Amount", "Star"]);
  final RxInt selectedFundTransferFilterIndex = RxInt(0);
  final RxString selectedFundTransferFilterValue = RxString("All");
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  // final RxBool selectPeopleBottomSheetRightButtonState = RxBool(false);
  //  final RxList<bool> isPeopleSelected = RxList<bool>([]);
  final List selectDateTimeFilterList = ["Today", "Yesterday", "This Week", "This Month", "This Year", "Custom"];
  final TextEditingController selectPeopleTextEditingController = TextEditingController();
  final TextEditingController fundTransferTextEditingController = TextEditingController();
  final TextEditingController dashboardOtpTextEditingController = TextEditingController();
  final RxBool canOTPVerifyNow = RxBool(false);
  final RxBool isOTPResendClick = RxBool(false);
  final RxList fundTransferHistoryList = RxList([
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "10",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "20",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$10",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$20",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "30",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "40",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$30",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$40",
    },
  ]);
  final RxList fundTransferAmountHistoryList = RxList([
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$10",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$20",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$30",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$40",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$50",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$60",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$70",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$80",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$90",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Amount",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "amount": "\$100",
    },
  ]);
  final RxList fundTransferStarHistoryList = RxList([
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "10",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "20",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "30",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "40",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "50",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "60",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "70",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "80",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "90",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "100",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "110",
    },
    {
      "date": "17/01/2024",
      "transferOf": "Star",
      "userImage":
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "userName": "Wahid Murad",
      "icon": BipHip.giftNew,
      "amount": "120",
    },
  ]);
  final RxBool isConfirmButtonEnabled = RxBool(false);
  void checkConfirmButtonEnable() {
    if (fundTransferTextEditingController.text.toString().trim() == '') {
      isConfirmButtonEnabled.value = false;
    } else if (fundTransferTextEditingController.text.toString().trim() != '' && double.parse(fundTransferTextEditingController.text.toString()) < 20.00 ||
        double.parse(fundTransferTextEditingController.text.toString()) > 2000) {
      isConfirmButtonEnabled.value = false;
    } else {
      isConfirmButtonEnabled.value = true;
    }
  }

  final Rx<String?> fundTransferErrorText = Rx<String?>(null);
  void dashboardFundTransferOnChanged() {
    checkConfirmButtonEnable();
    if (fundTransferTextEditingController.text.toString().trim() == '') {
      fundTransferErrorText.value = ksEmptyFundTransferErrorText.tr;
    } else if (fundTransferTextEditingController.text.toString().trim() != '' && double.parse(fundTransferTextEditingController.text.toString()) < 20.00 ||
        double.parse(fundTransferTextEditingController.text.toString()) > 2000) {
      fundTransferErrorText.value = ksFundTranferLimit.tr;
    } else {
      fundTransferErrorText.value = null;
    }
  }

  void resetDashboardFundTransferData() {
    fundTransferTextEditingController.clear();
    selectPeopleTextEditingController.clear();
    fundTransferTextEditingController.clear();
    dashboardOtpTextEditingController.clear();
    canOTPVerifyNow.value = false;
    isOTPResendClick.value = false;
    isConfirmButtonEnabled.value = false;
    fundTransferErrorText.value = null;
  }

  void checkCanOTPVerifyNow() {
    if (dashboardOtpTextEditingController.text.length == kOTPLength) {
      canOTPVerifyNow.value = true;
    } else {
      canOTPVerifyNow.value = false;
    }
  }

  final RxList donationTapButtonText = RxList(["I donated", "My applications"]);
  final RxList donationTapButtonState = RxList([true, false]);
  void dashboardIDonatedTapableButtonOnPressed() async {
    dashboardDonationToggleType(0);
  }

  void dashboardMyDonationTapableButtonOnPressed() async {
    dashboardDonationToggleType(1);
  }

  void dashboardDonationToggleType(int index) {
    switch (index) {
      case 0:
        donationTapButtonState[0] = true;
        donationTapButtonState[1] = false;
        break;
      case 1:
        donationTapButtonState[0] = false;
        donationTapButtonState[1] = true;
        break;
    }
  }

  final Rx<DateTime> focuseDay = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> days = Rx<DateTime>(DateTime.now());
  final RxBool quizTimeRangeRightButtonState = RxBool(false);
  final RxList dashboardDonationPost = RxList([
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$10"
    },
    {
      "productImage": "https://imgd.aeplcdn.com/642x361/n/cw/ec/126607/honda-cbr500r-right-side-view0.jpeg?isig=0&q=80",
      "productTitle": "Honda CBR150R Repsol Edition",
      "postDate": "10Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$20"
    },
    {
      "productImage": "https://www.otocapital.in/_next/image?url=https%3A%2F%2Fassets.otocapital.in%2Fproduction%2Fsports-bike-in-india.png&w=1024&q=75",
      "productTitle": "Sports bike",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$30"
    },
    {
      "productImage": "https://media.e-valy.com/cms/products/images/b71f027e-9793-4dc2-8d26-1111cbba1c81",
      "productTitle": "Yamaha MT-15 Motor Bike - 155CC - Black",
      "postDate": "15Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$40"
    },
    {
      "productImage": "https://imgd.aeplcdn.com/642x361/n/cw/ec/126607/honda-cbr500r-right-side-view0.jpeg?isig=0&q=80",
      "productTitle": "Honda CBR150R Repsol Edition",
      "postDate": "10Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$50"
    },
  ]);
  final List starPurchaseHistoryList = [
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Welcome", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
  ];
  final List starGiftHistoryList = [
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Welcome", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
    {"date": "17/01/2-2024", "packageIcon": BipHip.giftNew, "packageName": "Custom", "starAmount": 200, "price": "\$10"},
  ];
  final List dashboardStarHistoryList = ["Purchase", "Gift"];
  final RxString selectedDashboardStarHistoryValue = RxString("Purchase");
  final RxInt selectedDashboardStarHistoryIndex = RxInt(0);
  final RxString temporarySelectedCategory = RxString("All");
  final RxString selectedCategory = RxString("All");
  final RxInt temporarySelectedCategoryId = RxInt(-1);
  final RxInt selectedCategoryId = RxInt(-1);
  final RxBool categoryRightButtonState = RxBool(false);
  final List categoryFilterList = [
    {"categoryIcon": BipHip.poetry, "categoryName": "Poetry", "id": 1},
    {"categoryIcon": BipHip.painting, "categoryName": "Painting", "id": 2},
    {"categoryIcon": BipHip.kids, "categoryName": "Kids", "id": 3},
    {"categoryIcon": BipHip.storytelling, "categoryName": "Storytelling", "id": 4},
    {"categoryIcon": BipHip.photography, "categoryName": "Photography", "id": 5},
    {"categoryIcon": BipHip.newsFill, "categoryName": "News", "id": 6},
    {"categoryIcon": BipHip.selling, "categoryName": "Selling", "id": 7},
  ];
  List allAwardList = [
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 14 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 15 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 16 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 17 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 18 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 14 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 15 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 16 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 17 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
    {
      "image":
          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
      "ranking": "10",
      "WinningDate": "Wining Date: 18 Sep, 2023",
      "certificate":
          "https://img.freepik.com/free-vector/certificate-achievement-template_1198-354.jpg?w=826&t=st=1709447459~exp=1709448059~hmac=68f0d8517275781aebdaa0dc721fafe662ed1909bb4e47ece91c5d1b304e93f9"
    },
  ];

  // List allAwardList = [];
  Color categoryIconColor(int index) {
    if (categoryFilterList[index]["id"] == 1) {
      return cPoetryColor;
    } else if (categoryFilterList[index]["id"] == 2) {
      return cPaintingColor;
    } else if (categoryFilterList[index]["id"] == 3) {
      return cKidsColor;
    } else if (categoryFilterList[index]["id"] == 4) {
      return cStoryTellingColor;
    } else if (categoryFilterList[index]["id"] == 5) {
      return cPhotographyColor;
    } else if (categoryFilterList[index]["id"] == 6) {
      return cCategoryColor;
    } else {
      return cPrimaryColor;
    }
  }

  final RxList quizFilterText = RxList(["Inshights", "Today's Quiz", "Played", "Won Quiz"]);
  final RxInt selectedQuizFilterIndex = RxInt(0);
  final RxList dashboardOverviewContentFilterList = RxList(["All content", "Photos", "Videos", "Text"]);
  final RxInt dashboardOverviewSelectedContentFilterIndex = RxInt(0);
  final RxString dashboardOverviewSelectedContentFilterValue = RxString("All content");
  final RxList dashboardOverviewFilterList = RxList(["Overview", "Insights", "Profile Eligibility", "Tools"]);
  final RxInt dashboardOverviewSelectedFilterIndex = RxInt(0);
  final RxString dashboardOverviewSelectedFilterValue = RxString("Overview");
  final RxString dashboardOverviewTime = RxString("From previous 28 days");
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
  final RxList topCountriesList = RxList([
    {'countryName': "Bangladesh", 'percent': 50},
    {'countryName': "India", 'percent': 20},
    {'countryName': "USA", 'percent': 25},
    {'countryName': "Pakistan", 'percent': 25},
  ]);
  final RxList dashboardEarnedGiftPostList = RxList([
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "isVideoContent": false,
      "isTextOnly": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/642x361/n/cw/ec/126607/honda-cbr500r-right-side-view0.jpeg?isig=0&q=80",
      "productTitle": "Honda CBR150R Repsol Edition",
      "postDate": "10Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$20",
      "isVideoContent": false,
      "isTextOnly": false,
    },
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "isVideoContent": false,
      "isTextOnly": true,
    },
    {
      "productImage": "https://www.otocapital.in/_next/image?url=https%3A%2F%2Fassets.otocapital.in%2Fproduction%2Fsports-bike-in-india.png&w=1024&q=75",
      "productTitle": "Sports bike",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$30",
      "isVideoContent": false,
      "isTextOnly": false,
    },
    {
      "productImage": "https://media.e-valy.com/cms/products/images/b71f027e-9793-4dc2-8d26-1111cbba1c81",
      "productTitle": "Yamaha MT-15 Motor Bike - 155CC - Black",
      "postDate": "15Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$40",
      "isVideoContent": true,
      "isTextOnly": false,
    },
  ]);
  final RxList dashboardEarnedGiftVideosPostList = RxList([
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "isVideoContent": true,
      "isTextOnly": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/642x361/n/cw/ec/126607/honda-cbr500r-right-side-view0.jpeg?isig=0&q=80",
      "productTitle": "Honda CBR150R Repsol Edition",
      "postDate": "10Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$20",
      "isVideoContent": true,
      "isTextOnly": false,
    },
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "isVideoContent": true,
      "isTextOnly": false,
    },
  ]);
  final RxList dashboardEarnedGiftPhotosPostList = RxList([
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "isVideoContent": false,
      "isTextOnly": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/642x361/n/cw/ec/126607/honda-cbr500r-right-side-view0.jpeg?isig=0&q=80",
      "productTitle": "Honda CBR150R Repsol Edition",
      "postDate": "10Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$20",
      "isVideoContent": false,
      "isTextOnly": false,
    },
    {
      "productImage": "https://www.otocapital.in/_next/image?url=https%3A%2F%2Fassets.otocapital.in%2Fproduction%2Fsports-bike-in-india.png&w=1024&q=75",
      "productTitle": "Sports bike",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "amount": "\$30",
      "isVideoContent": false,
      "isTextOnly": false,
    },
  ]);

  final RxList dashboardEarnedGiftTextPostList = RxList([
    {
      "productImage": "https://5.imimg.com/data5/XL/EN/MY-70607897/selection_941-500x500.png",
      "productTitle": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "postDate": "3Feb, 2024",
      "postCount": "0",
      "engagementCount": "0",
      "giftCount": "0",
      "isVideoContent": false,
      "isTextOnly": true,
    },
  ]);

  String dashboardOverviewAppbarTitle(int index) {
    if (index == 0) {
      return ksOverview.tr;
    } else if (index == 1) {
      return ksInsights.tr;
    } else if (index == 2) {
      return ksProfileEligibility.tr;
    } else {
      return ksTools.tr;
    }
  }

  //*Dashboard profile overview Api Call
  final Rx<DashboardProfileOverviewModel?> dashboardProfileOverviewData = Rx<DashboardProfileOverviewModel?>(null);
  final RxBool dashboardProfileOverviewLoading = RxBool(false);
  Future<void> getDashboardProfileOverview() async {
    try {
      dashboardProfileOverviewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetProfileOverview,
      ) as CommonDM;
      if (response.success == true) {
        dashboardProfileOverviewData.value = DashboardProfileOverviewModel.fromJson(response.data);
        dashboardProfileOverviewLoading.value = false;
      } else {
        dashboardProfileOverviewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      dashboardProfileOverviewLoading.value = true;
      ll('getProfileOverview error: $e');
    }
  }

  //*Dashboard Content Api Call
  final Rx<DashboardContentsModel?> dashboardContentData = Rx<DashboardContentsModel?>(null);
  final RxList<ContentData> contentList = RxList<ContentData>([]);
  final RxBool isDashboardContentsLoading = RxBool(false);
  Future<void> getDashboardContents() async {
    try {
      isDashboardContentsLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuDashboardContents?take=10&start_date=2024-01-01&end_date=2024-04-21",
      ) as CommonDM;
      if (response.success == true) {
        contentList.clear();
        dashboardContentData.value = DashboardContentsModel.fromJson(response.data);
        contentList.addAll(dashboardContentData.value!.contents!.data!);
        isDashboardContentsLoading.value = false;
        ll("dashboard contentList length in api call ${contentList.length}");
        // dashboardProfileOverviewData.value = DashboardProfileOverviewModel.fromJson(response.data);
        // postReachCount.value = dashboardProfileOverviewData.value!.postReach!;
        // ll("post reach count ${postReachCount.value}");
        // dashboardProfileOverviewLoading.value = false;
      } else {
        isDashboardContentsLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isDashboardContentsLoading.value = true;
      ll('getDashboardContents error: $e');
    }
  }

  //*Dashboard star insights Api Call
  final Rx<DashboardStarInsightModel?> dashboardStarInsightData = Rx<DashboardStarInsightModel?>(null);
  final RxBool isDashboardStarInsightLoading = RxBool(false);
  Future<void> getDashboardStarInsight() async {
    try {
      isDashboardStarInsightLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuDashboardStarInsight?year=2024",
      ) as CommonDM;
      if (response.success == true) {
        dashboardStarInsightData.value = DashboardStarInsightModel.fromJson(response.data);
        isDashboardStarInsightLoading.value = false;
      } else {
        isDashboardStarInsightLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isDashboardStarInsightLoading.value = true;
      ll('getDashboardStarInsight error: $e');
    }
  }
}
