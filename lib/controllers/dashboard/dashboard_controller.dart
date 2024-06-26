import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
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

  //! Payouts
  final RxList dashboardPayoutsTapButtonState = RxList([true, false, false]);
  final RxList dashboardPayoutsTapButtonText = RxList(["Overview", "Transections", "Settings"]);
  final RxList payoutsTapButtonState = RxList([true, false, false]);
  final RxList payoutsTapButtonText = RxList(["Overview", "Transections", "Settings"]);
  void payoutsOverviewTapableButtonOnPressed() async {
    payoutsToggleType(0);
    // await getQuestionList();
  }

  void payoutsTransectionsTapableButtonOnPressed() async {
    payoutsToggleType(1);
    // await getPlayedQuizesList();
  }

  void payoutsSettingsTapableButtonOnPressed() async {
    payoutsToggleType(2);
    // await getmyQuizWinnerList();
  }

  final RxBool isWithdrawReportAvailable = RxBool(true);
  final RxBool isEarningReportAvailable = RxBool(true);

  void payoutsToggleType(int index) {
    switch (index) {
      case 0:
        payoutsTapButtonState[0] = true;
        payoutsTapButtonState[1] = false;
        payoutsTapButtonState[2] = false;
        break;
      case 1:
        payoutsTapButtonState[0] = false;
        payoutsTapButtonState[1] = true;
        payoutsTapButtonState[2] = false;
        break;
      case 2:
        payoutsTapButtonState[0] = false;
        payoutsTapButtonState[1] = false;
        payoutsTapButtonState[2] = true;
        break;
    }
  }

  final TextEditingController payoutWithdrawTextEditingController = TextEditingController();
  final RxBool isdashboardPayoutWithdraw = RxBool(false);
  final RxString payoutTaxInformationStatus = RxString("");
  final RxString payoutPassportStatus = RxString("");
  final RxList payoutBankAccountList = RxList([
    {"accountName": "Wahid Murad", "bankName": "Brac Bank"},
    {"accountName": "Wahid Murad", "bankName": "Ab Bank"},
  ]);
  final RxString temporarySelectedCountry = RxString("");
  final RxString selectedCountry = RxString("");
  final RxBool dashboardPayoutCountryRightButtonState = RxBool(false);
  final RxList countryList = RxList(["Bangladesh","Argentina","Bhutan","Nepal","Japan","Chine","Palestine"]);
  final RxList withdrawHistoryList = RxList([
    {"date": "17/01/2024", "payment": "Paypal", "withdrawAmount": 200, "availableAmount": 10},
    {"date": "17/01/2024", "payment": "Brac Bank", "withdrawAmount": 300, "availableAmount": 20},
    {"date": "17/01/2024", "payment": "Cripto", "withdrawAmount": 400, "availableAmount": 30},
    {"date": "17/01/2024", "payment": "Ab Bank", "withdrawAmount": 500, "availableAmount": 40},
    {"date": "17/01/2024", "payment": "Paypal", "withdrawAmount": 600, "availableAmount": 50},
    {"date": "17/01/2024", "payment": "Brac Bank", "withdrawAmount": 700, "availableAmount": 60},
    {"date": "17/01/2024", "payment": "Ab Bank", "withdrawAmount": 800, "availableAmount": 70},
    {"date": "17/01/2024", "payment": "Cripto", "withdrawAmount": 900, "availableAmount": 80},
    {"date": "17/01/2024", "payment": "Paypal", "withdrawAmount": 1000, "availableAmount": 90},
  ]);
  //*payout add manual link bank account
  final TextEditingController accountHolderNameTextEditingController = TextEditingController();
  final TextEditingController swiftCodeTextEditingController = TextEditingController();
  final TextEditingController accountNumberTextEditingController = TextEditingController();
  final TextEditingController routingNumberTextEditingController = TextEditingController();
  //*payout crypto
  final TextEditingController cryptoAmountTextEditingController = TextEditingController();
  final TextEditingController cryptoAccountNumberTextEditingController = TextEditingController();
  //*payout card
  final TextEditingController cardNumberTextEditingController = TextEditingController();
  final TextEditingController cardExpirationDateTextEditingController = TextEditingController();
  final TextEditingController cardCVVTextEditingController = TextEditingController();
  final TextEditingController billingAddressTextEditingController = TextEditingController();

}
