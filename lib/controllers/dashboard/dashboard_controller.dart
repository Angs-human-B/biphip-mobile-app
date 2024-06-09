import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final fundTransferFilterList = RxList(["All", "Amount", "Star"]);
  final RxInt selectedFundTransferFilterIndex = RxInt(0);
  final RxString selectedFundTransferFilterValue = RxString("All");
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final List selectDateTimeFilterList = ["Today", "Yesterday", "This Week", "This Month", "This Year", "Custom"];
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
}
