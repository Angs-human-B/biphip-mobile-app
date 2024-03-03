import 'package:bip_hip/utils/constants/imports.dart';

class AwardController extends GetxController {
  final TextEditingController awardTextEditingController = TextEditingController();
  final RxBool isAwardSuffixVisible = RxBool(false);
  final RxInt selectedCatagoriesIndex = RxInt(0);
  final RxBool isCategoriesSelected = RxBool(false);
  List youWonAwardList = [
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 14 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 15 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 16 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 17 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 18 Sep, 2023"
    },
  ];
  List othersWinnerAwardList = [
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 19 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 20 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 21 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 22 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 23 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 24 Sep, 2023"
    },
    {
      "image": "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
      "ranking": "10",
      "WinningDate": "Wining Date: 25 Sep, 2023"
    },
  ];

  void resetAwardData() {
    selectedCatagoriesIndex.value = 0;
    isCategoriesSelected.value = false;
  }
}
