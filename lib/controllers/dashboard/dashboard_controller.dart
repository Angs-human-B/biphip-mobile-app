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
}
