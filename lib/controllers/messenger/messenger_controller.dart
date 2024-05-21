import 'dart:async';
import 'dart:io';

import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:peerdart/peerdart.dart';

class MessengerController extends GetxController {
  final TextEditingController inboxSearchTextEditingController = TextEditingController();
  final TextEditingController messageTextEditingController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  final RxBool isMessageTextFieldFocused = RxBool(false);
  final RxBool isSendEnabled = RxBool(false);
  final RxBool isSearchFieldCrossButtonShown = RxBool(false);
  final RxList inboxFilterCategoryList = RxList(["All", "Active", "Marketplace", "Kids"]);
  final RxString selectedFilterCategory = RxString("All");
  final RxList messages = RxList([]);
  final Rx<FriendFamilyUserData?> selectedReceiver = Rx<FriendFamilyUserData?>(null);

  void onInit() async {
    checkInternetConnectivity();
    connectPeer();
    messageFocusNode.addListener(() {
      if (messageFocusNode.hasFocus) {
        isMessageTextFieldFocused.value = true;
      } else {
        isMessageTextFieldFocused.value = false;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    peer.dispose();
    super.onClose();
  }

  //=====================================================
  //!          Check for internet connection
  //=====================================================

  late StreamSubscription<InternetConnectionStatus> internetConnectivitySubscription;
  final RxBool isInternetConnectionAvailable = RxBool(false);
  Future<void> initConnectivity() async {
    try {
      bool internetConnectivityResult = await InternetConnectionChecker().hasConnection;
      if (internetConnectivityResult != true) {
        ll("NOOO CONNNN");
        isInternetConnectionAvailable.value = false;
      } else {
        isInternetConnectionAvailable.value = true;
      }
    } on SocketException catch (e) {
      ll('Connectivity status error: $e');
      isInternetConnectionAvailable.value = false;
    } on PlatformException catch (e) {
      ll('Connectivity status error: $e');
      isInternetConnectionAvailable.value = false;
    }
  }

  Future<void> checkInternetConnectivity() async {
    await initConnectivity();
    internetConnectivitySubscription = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            isInternetConnectionAvailable.value = true;
            break;
          case InternetConnectionStatus.disconnected:
            ll("CONNN CUTTT");
            isInternetConnectionAvailable.value = false;
            break;
        }
      },
    );
  }

  //=====================================================

  //=====================================================
  //!                Socket and WebRTC
  //=====================================================

  final Peer peer = Peer(options: PeerOptions(debug: LogLevel.All));
  final RxString peerId = RxString("");
  late DataConnection conn;
  final RxBool connected = RxBool(false);
  final RxList connectedUserID = RxList([]);

  void connectPeer() {
    peer.on("open").listen((id) {
      peerId.value = peer.id!;
      if (peerId.value != "") {
        socketConnect(peerId.value);
      }
    });

    peer.on("close").listen((id) {
      connected.value = false;
    });

    peer.on<DataConnection>("connection").listen((event) {
      int index = Get.find<GlobalController>().allConnectedPeers.indexWhere((user) => user['peerID'] == event.peer);
      if (index != -1) {
        connectedUserID.add(Get.find<GlobalController>().allConnectedPeers[index]['peerID']);
      }
      conn = event;
      conn.on("data").listen((data) {
        messages.insert(0, {"userType": "sender", "message": data});
        int index = allFriendMessageList.indexWhere((user) => user['userID'] == selectedReceiver.value!.id);
        if (index != -1) {
          allFriendMessageList[index]["messages"].insert(0, {"userType": "sender", "message": data});
          ll(allFriendMessageList[index]["messages"]);
        }
        ll("incoming message: $data");
      });

      conn.on("binary").listen((data) {
        ll("binary: $data");
      });

      conn.on("close").listen((event) {
        connected.value = false;
      });

      conn.on("error").listen((error) {
        ll("Error occurred: $error");
        connected.value = false;
      });

      connected.value = true;
    });
  }

  void socketConnect(peerID) {
    ll("Connecting...");

    socket.on('connect', (_) {
      ll('Connected: ${socket.id}');
      Map<String, dynamic> data = {
        "peerID": peerID,
        "userID": Get.find<GlobalController>().userId.value,
        "userName": Get.find<GlobalController>().userName.value,
        "userImage": Get.find<GlobalController>().userImage.value
      };
      socket.emit("mobile-chat-channel", data);
    });
  }

  void connectWithPeer(peerId) {
    //connect with peer
    try {
      final connection = peer.connect(peerId);
      ll(connection.connectionId);
      conn = connection;

      conn.on("open").listen((event) {
        connected.value = true;
        connection.on("close").listen((event) {
          connected.value = false;
        });

        conn.on("data").listen((data) {
          messages.insert(0, {"userType": "sender", "message": data});
          int index = allFriendMessageList.indexWhere((user) => user['userID'] == selectedReceiver.value!.id);
          if (index != -1) {
            allFriendMessageList[index]["messages"].insert(0, {"userType": "sender", "message": data});
            ll(allFriendMessageList[index]["messages"]);
          }
          ll("Peer connect data: $data");
        });
        conn.on("binary").listen((data) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("Got binary!")));
        });

        conn.on("error").listen((error) {
          ll("Error occurred: $error");
          connected.value = false;
        });
      });
    } catch (e) {
      ll(e.toString());
    }
  }

  void exchangePeerID(userID) {
    Map<String, dynamic> data = {
      "peerID": peerId.value,
      "userID": Get.find<GlobalController>().userId.value,
      "userName": Get.find<GlobalController>().userName.value,
      "userImage": Get.find<GlobalController>().userImage.value
    };
    socket.emit("mobile-chat-peer-exchange-$userID", data);
  }

  //===========END=======================================

  void checkCanSendMessage() {
    if (messageTextEditingController.text.trim() == "") {
      isSendEnabled.value = false;
    } else {
      isSendEnabled.value = true;
    }
  }

  //============================================
  //!         Send Message Data Persistency
  //============================================

  List<String> messageQueue = [];
  int batchSize = 5; // Adjust based on your needs

  void sendMessage(String message) async {
    if (connected.value && isInternetConnectionAvailable.value) {
      // Add to offline list
      messages.insert(0, {"userType": "self", "message": message});
      setMessage(selectedReceiver.value!.id, {"userType": "self", "message": message});

      // Send through webRTC
      conn.send(message);

      // Add message to queue
      messageQueue.add(message);

      if (messageQueue.length >= batchSize && isInternetConnectionAvailable.value) {
        await sendBatchMessages();
      }
      messageTextEditingController.clear();
    }
  }

  // Send through API
  Future<void> sendBatchMessages() async {}

  // Get Messages
  RxList<Map<String, dynamic>> allFriendMessageList = RxList<Map<String, dynamic>>([]);
  void geAllFriendMessages() {
    for (int i = 0; i < Get.find<FriendController>().friendList.length; i++) {
      allFriendMessageList.add({
        "userID": Get.find<FriendController>().friendList[i].id,
        "userName": Get.find<FriendController>().friendList[i].fullName,
        "messages": [],
      });
    }
    ll("hello: $allFriendMessageList");
  }

  // Set Messages
  void setMessage(userID, messageData) {
    int index = allFriendMessageList.indexWhere((user) => user['userID'] == userID);
    if (index != -1) {
      allFriendMessageList[index]["messages"].insert(0, messageData);
    }
  }
}
