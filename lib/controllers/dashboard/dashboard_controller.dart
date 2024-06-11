import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
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
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final RxBool quizTimeRangeRightButtonState = RxBool(false);
  final List selectDateTimeFilterList = ["Today", "Yesterday", "This Week", "This Month", "This Year", "Custom"];
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
}
