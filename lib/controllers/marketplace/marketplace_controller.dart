import 'package:bip_hip/utils/constants/imports.dart';

class MarketPlaceController extends GetxController {
  final RxBool shortByBottomSheetState = RxBool(false);
  final RxBool isDatePostedBottomSheetState = RxBool(false);
  final RxBool isProductConditionBottomSheetState = RxBool(false);
  final List datePostedList = ["Any", "2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016"];
  final List productConditionList = ["Any", "New", "Used", "Used Good Condition", "Used Poor Condition", "Like New"];
  final RxString temporarySelectedDatePosted = RxString("");
  final RxString selectedDatePosted = RxString("");
  final RxString temporarySelectedProductCondition = RxString("");
  final RxString selectedProductCondition = RxString("");
  final TextEditingController sellertMessageTextEditingController = TextEditingController();
  final List topCategoriesList = [
    {"image": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0", "title": "Vehicles"},
    {"image": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0", "title": "Rentals"},
    {"image": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0", "title": "Women's Clothing & Shoes"},
    {"image": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0", "title": "Men's Clothing & Shoes"},
    {"image": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0", "title": "Furniture"},
    {
      "image":
          "https://www.realsimple.com/thmb/kRRAaK6XhZIqL_GFIxfZzHTHx7o=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/furniture-styles-GettyImages-1467984982-512fed4077b646eabbc187619554d517.jpg",
      "title": "Electronics"
    },
  ];
  final List allCategoriesList = [
    {
      "image": "https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg?size=626&ext=jpg&ga=GA1.1.1335436361.1687166632&semt=sph",
      "title": "Books, Movies & Music"
    },
    {
      "image": "https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg?size=626&ext=jpg&ga=GA1.1.1335436361.1687166632&semt=sph",
      "title": "Appliances"
    },
    {
      "image": "https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg?size=626&ext=jpg&ga=GA1.1.1335436361.1687166632&semt=sph",
      "title": "Art & Crafts"
    },
    {
      "image": "https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg?size=626&ext=jpg&ga=GA1.1.1335436361.1687166632&semt=sph",
      "title": "Auto Parts"
    },
    {
      "image": "https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg?size=626&ext=jpg&ga=GA1.1.1335436361.1687166632&semt=sph",
      "title": "Baby"
    },
    {
      "image": "https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg?size=626&ext=jpg&ga=GA1.1.1335436361.1687166632&semt=sph",
      "title": "Antiques & Collectibles"
    },
  ];
  final List marketplaceProductList = [
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": true,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": false,
    },
    {
      "productImage": "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
      "price": "\$17399",
      "location": "Dhaka",
      "details": "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
      "isBiddingPost": true,
    },
  ];
  final String descriptionText = "WorldSBK Championship capability with a powerful 998cc engine advanced technology and superior handling";

  final List sellingActionList = [
    {"icon": BipHip.report,"title": "Your Listing"},
    {"icon": BipHip.chatFill,"title": "Inbox"},
    {"icon": BipHip.bidding,"title": "Bidding"},
    {"icon": BipHip.shopFill,"title": "Store"},
  ];
  final List buyingActionList = [
    {"icon": BipHip.chatFill,"title": "Inbox"},
    {"icon": BipHip.bidding,"title": "Bidding"},
  ];
    final List moreActionList = [
    {"icon": BipHip.location,"title": "Location"},
    {"icon": BipHip.notificationFill,"title": "Notification"},
  ];
}
