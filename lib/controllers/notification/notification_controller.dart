import 'package:bip_hip/utils/constants/imports.dart';

class NotificationController extends GetxController {
  final TextEditingController notificationTextEditingController = TextEditingController();
  final RxList notificationFilterCategoryList = RxList(["All", "Marketplace", "Kids"]);
  final RxString selectedNotificationFilterCategory = RxString("All");
  final RxList allNotificationList = RxList([
    {
      "userImage": "https://i.pinimg.com/originals/92/f0/ed/92f0edd9b0ecefdd5b7a48b8e1f7d340.jpg",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "1 hour ago",
      "postType": "Post",
    },
    {
      "userImage":
          "https://img.freepik.com/free-photo/cheerfulcharming-young-woman-wearing-blue-sweater-with-fair-straight-hair-smiling-happily-while-receiving-some-positive-news-pretty-girl-dressed-blue-looking-with-joyful-smile_176420-13443.jpg?t=st=1716184855~exp=1716188455~hmac=3187e1f0fa9ac6cc47c866c84b9485fe2131f8f9772932cb39ed2f4aae7cac54&w=1060",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "2 hour ago",
      "postType": "Post",
    },
    {
      "userImage": "https://i.pinimg.com/originals/92/f0/ed/92f0edd9b0ecefdd5b7a48b8e1f7d340.jpg",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "3 hour ago",
      "postType": "Birthday",
    },
    {
      "userImage":
          "https://img.freepik.com/free-photo/cheerfulcharming-young-woman-wearing-blue-sweater-with-fair-straight-hair-smiling-happily-while-receiving-some-positive-news-pretty-girl-dressed-blue-looking-with-joyful-smile_176420-13443.jpg?t=st=1716184855~exp=1716188455~hmac=3187e1f0fa9ac6cc47c866c84b9485fe2131f8f9772932cb39ed2f4aae7cac54&w=1060",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "4 hour ago",
      "postType": "Birthday",
    },
    {
      "userImage": "https://i.pinimg.com/originals/92/f0/ed/92f0edd9b0ecefdd5b7a48b8e1f7d340.jpg",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "5 hour ago",
      "postType": "Post",
    },
    {
      "userImage": "https://i.pinimg.com/originals/92/f0/ed/92f0edd9b0ecefdd5b7a48b8e1f7d340.jpg",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "6 hour ago",
      "postType": "Person",
    },
    {
      "userImage":
          "https://img.freepik.com/free-photo/cheerfulcharming-young-woman-wearing-blue-sweater-with-fair-straight-hair-smiling-happily-while-receiving-some-positive-news-pretty-girl-dressed-blue-looking-with-joyful-smile_176420-13443.jpg?t=st=1716184855~exp=1716188455~hmac=3187e1f0fa9ac6cc47c866c84b9485fe2131f8f9772932cb39ed2f4aae7cac54&w=1060",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "7 hour ago",
      "postType": "Person",
    },
    {
      "userImage":
          "https://img.freepik.com/free-photo/cheerfulcharming-young-woman-wearing-blue-sweater-with-fair-straight-hair-smiling-happily-while-receiving-some-positive-news-pretty-girl-dressed-blue-looking-with-joyful-smile_176420-13443.jpg?t=st=1716184855~exp=1716188455~hmac=3187e1f0fa9ac6cc47c866c84b9485fe2131f8f9772932cb39ed2f4aae7cac54&w=1060",
      "mentionUserName": "Aminul islam rana",
      "postUserName": "Wahid Murad",
      "firstText": "Mentioned you in a comment in",
      "lastText": "post where your are taged in",
      "notificationTime": "8 hour ago",
      "postType": "Person",
    },
  ]);
  final RxList receivedFamilyRequestList = RxList([
    {
      "backgroundImage":
          "https://img.freepik.com/free-photo/cheerfulcharming-young-woman-wearing-blue-sweater-with-fair-straight-hair-smiling-happily-while-receiving-some-positive-news-pretty-girl-dressed-blue-looking-with-joyful-smile_176420-13443.jpg?t=st=1716184855~exp=1716188455~hmac=3187e1f0fa9ac6cc47c866c84b9485fe2131f8f9772932cb39ed2f4aae7cac54&w=1060",
      "userName": "Maria Jones",
      "subtitle": "Sister"
    },
    {
      "backgroundImage":
          "https://img.freepik.com/free-photo/young-beautiful-woman-looking-camera-trendy-girl-casual-summer-white-t-shirt-jeans-shorts-positive-female-shows-facial-emotions-funny-model-isolated-yellow_158538-15796.jpg?t=st=1716184971~exp=1716188571~hmac=4a5c62f96abfa4821c883ba546d5b786d263d92a23621505710f8b0698d7b48c&w=826",
      "userName": "Maria Jones",
      "subtitle": "Sister"
    },
    {
      "backgroundImage":
          "https://img.freepik.com/free-photo/tender-woman-having-brow-color-added-her-eyebrows_231208-3536.jpg?size=626&ext=jpg&ga=GA1.1.1335436361.1687166632&semt=ais_user",
      "userName": "Maria Jones",
      "subtitle": "Sister"
    },
    {
      "backgroundImage":
          "https://img.freepik.com/free-photo/brunette-business-woman-with-wavy-long-hair-blue-eyes-stands-holding-notebook-hands_197531-343.jpg?t=st=1716184776~exp=1716188376~hmac=987a5fb6cd7df347eabd737da6d21b937b1670986100f33355ed6e0b09393059&w=740",
      "userName": "Maria Jones",
      "subtitle": "Sister"
    },
  ]);
  void resetNotificationData() {
    selectedNotificationFilterCategory.value = "All";
  }
}
