import 'dart:io';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/family.dart';
import 'package:bip_hip/views/profile/menu/friends.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  final RxBool isSupportButtonPressed = RxBool(false);
  final RxBool isSettingButtonPressed = RxBool(false);
  final RxInt interestCatagoriesIndex = RxInt(0);
  final RxBool isInterestSelected = RxBool(false);
  final RxString profileImageLink = RxString('');
  final Rx<File> profileImageFile = File('').obs;
  final Rx<File> newProfileImageFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxString coverImageLink = RxString('');
  final Rx<File> coverImageFile = File('').obs;
  final Rx<File> newCoverImageFile = File('').obs;
  final RxBool isCoverImageChanged = RxBool(false);
  final TextEditingController bioEditingController = TextEditingController();
  final RxInt bioCount = 0.obs;
  final RxString bio = RxString('');
  final RxString photoLink = RxString('');
  late VideoPlayerController videoPlayerController;
  final RxString videoUrl = RxString('');
  final RxBool isSharedToNewFeed = RxBool(false);
  final RxBool isProfilePicEditor = RxBool(true);

  final RxList tapAbleButtonState = RxList([true, false, false]);
  final RxList tapAbleButtonText = RxList(["All", "Received", "Pending"]);

  void playVideo(
    String videoUrl, {
    bool init = false,
  }) {
    // if(index<0 || index>= videos.length){
    //   return;
    // }
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..addListener(() {})
      ..setLooping(true)
      ..initialize().then((value) => videoPlayerController.play());
  }
  final RxList relationList = RxList([
    "Father",
    "Mother",
    "Daughter",
    "Son",
    "Sister",
    "Brother",
    "Auntie",
    "Uncle",
    "Niece",
    "Nephew",
  ]);
  final RxList relationListState = RxList([
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ]);

  final RxString relation = RxString("");

  void relationStatusChange(index) {
    for (int i = 0; i < relationListState.length; i++) {
      if (index == i) {
        relationListState[i] = true;
      } else {
        relationListState[i] = false;
      }
    }
  }

  void selectRelationTextChange() {
    for (int i = 0; i < relationListState.length; i++) {
      if (relationListState[i]) {
        relation.value = relationList[i];
        break;
      }
    }
  }

  void initializeSelectedRelationText() {
    for (int i = 0; i < relationListState.length; i++) {
      if (relationList[i] == relation.value) {
        relationListState[i] = true;
      } else {
        relationListState[i] = false;
      }
    }
  }

  void initializeRelationText() {
    relation.value = "";
  }

  //*For tapAble button
  void toggleType(int index) {
    for (int i = 0; i < 3; i++) {
      if (index == i) {
        tapAbleButtonState[i] = true;
      } else {
        tapAbleButtonState[i] = false;
      }
    }
  }

  void resetTapButtonData() {
    tapAbleButtonState.clear();
    tapAbleButtonState.addAll([true, false, false]);
  }

  //*Search
  final TextEditingController searchController = TextEditingController();
  RxBool isCloseIconVisible = RxBool(false);

  //*Friends
  RxList allFriendsLists = RxList(friendsList);
  RxList receivedFriendLists = RxList(friendsList);
  RxList pendingFriendLists = RxList(friendsList);
  RxList addFriendLists = RxList(addFriendList);

  //*friends page list data show
  StatelessWidget allReceivedPendingFriendsView() {
    if (tapAbleButtonState[0] == true) {
      return AllFriendList();
    } else if (tapAbleButtonState[1] == true) {
      return ReceivedFriendList();
    } else {
      return PendingFriendList();
    }
  }

  //*Family
  RxList allFamilyLists = RxList(friendsList);
  RxList receivedFamilyLists = RxList(friendsList);
  RxList pendingFamilyLists = RxList(friendsList);
  RxList addFamilyLists = RxList(addFriendList);

  //*friends page list data show
  StatelessWidget allReceivedPendingFamilyView() {
    if (tapAbleButtonState[0] == true) {
      return AllFamilyList();
    } else if (tapAbleButtonState[1] == true) {
      return ReceivedFamilyList();
    } else {
      return PendingFamilyList();
    }
  }

  void showPictureUploadModalBottomSheet(context, content) {
    showModalBottomSheet(
      backgroundColor: cWhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
      ),
      context: context,
      builder: (context) {
        return content;
      },
    );
  }

  void clearBio() {
    bioCount.value = 0;
    bioEditingController.clear();
  }

  void resetImage(){
    profileImageFile.value = File('');
    profileImageLink.value = '';
    isProfileImageChanged.value = false;
    isSharedToNewFeed.value = false;
    coverImageFile.value = File('');
    coverImageLink.value = '';
    isCoverImageChanged.value = false;
  }
}
