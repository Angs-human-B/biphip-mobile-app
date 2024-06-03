import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final RxString temporarySelectedCategory = RxString("All");
  final RxString selectedCategory = RxString("All");
  final RxInt temporarySelectedCategoryId = RxInt(-1);
  final RxInt selectedCategoryId = RxInt(-1);
  final RxBool categoryRightButtonState = RxBool(false);
  final List selectDateTimeFilterList = ["Today", "Yesterday", "This Week", "This Month", "This Year", "Custom"];
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
}
