import 'dart:async';
import 'dart:io';
import 'package:bip_hip/models/messenger/message_list_model.dart';
import 'package:bip_hip/models/messenger/room_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:peerdart/peerdart.dart';

class MessengerController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final SpController spController = SpController();
  final ApiController apiController = ApiController();
  final TextEditingController inboxSearchTextEditingController = TextEditingController();
  final TextEditingController messageTextEditingController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  final RxBool isMessageTextFieldFocused = RxBool(false);
  final RxBool isSendEnabled = RxBool(false);
  final RxBool isSearchFieldCrossButtonShown = RxBool(false);
  final RxList inboxFilterCategoryList = RxList(["All", "Active", "Marketplace", "Kids"]);
  final RxString selectedFilterCategory = RxString("All");
  // final RxList messages = RxList([]);
  final Rx<RoomData?> selectedReceiver = Rx<RoomData?>(null);
  final RxInt selectedRoomIndex = RxInt(-1);

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

  static const defaultConfig = {
    'iceServers': [
      {'urls': "stun:stun.l.google.com:19302"},
      {
        "urls": [
          "turn:54.91.252.241:3478",
        ],
        "username": "user1",
        "credential": "123456",
      },
    ],
  };

  final Peer peer = Peer(options: PeerOptions(debug: LogLevel.All, config: defaultConfig));
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
        ll("PEER CLOSED");
    });

    peer.on<DataConnection>("connection").listen((event) {
      ll("PEER CONNECTED: ${event.peer}");
      int peerIndex = Get.find<GlobalController>().allOnlinePeers.indexWhere((user) => user['peerID'] == event.peer);
      if (peerIndex != -1) {
        connectedUserID.add(Get.find<GlobalController>().allOnlinePeers[peerIndex]['userID']);
      }
      conn = event;
      conn.on("data").listen((data) {
        // messages.insert(0, {"userType": "sender", "message": data});
        int index = allRoomMessageList.indexWhere((user) => user['roomID'] == selectedReceiver.value!.id);
        if (index != -1) {
          allRoomMessageList[index]["messages"].insert(
              0, MessageData(text: data, senderId: selectedReceiver.value!.roomUserId, messageText: data, senderImage: selectedReceiver.value!.roomImage![0]));
        }
        ll("incoming message: $data");
      });

      conn.on("binary").listen((data) {
        ll("binary: $data");
      });

      // conn.on("close").listen((event) {
      //   connected.value = false;
      //   ll("PEER CLOSED");
      // });

      conn.on("error").listen((error) {
        ll("Error occurred: $error");
        connected.value = false;
      });

      connected.value = true;
    });
  }

  void disconnectPeer() {
    peer.dispose();
    // peer.disconnect();
  }

  void socketConnect(peerID) {
    ll("Connecting...MC");

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
    ll(peerId);
    try {
      final connection = peer.connect(peerId);
      ll(connection.connectionId);
      conn = connection;

      conn.on("open").listen((event) {
        connected.value = true;

        conn.on("data").listen((data) {
          int index = allRoomMessageList.indexWhere((user) => user['roomID'] == selectedReceiver.value!.id);
          if (index != -1) {
            allRoomMessageList[index]["messages"].insert(0,
                MessageData(text: data, senderId: selectedReceiver.value!.roomUserId, messageText: data, senderImage: selectedReceiver.value!.roomImage![0]));
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

        connection.on("close").listen((event) {
          connected.value = false;
          ll("CONN CLOSE: ${conn.peer}");
          int index = Get.find<GlobalController>().allOnlinePeers.indexWhere((user) => user['peerID'] == conn.peer);
          connectedUserID.remove(Get.find<GlobalController>().allOnlinePeers[index]['userID']);
          Get.find<GlobalController>().allOnlinePeers.removeAt(index);
          ll(connectedUserID);
          ll(Get.find<GlobalController>().allOnlinePeers);
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
    connectedUserID.add(userID);
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
  int batchSize = 1;

  void sendMessage(String message) async {
    // if (connected.value && isInternetConnectionAvailable.value) {
    if (isInternetConnectionAvailable.value) {
      // Add to offline list
      setMessage(selectedReceiver.value!.id, MessageData(text: message, senderId: globalController.userId.value, messageText: message));

      // Send through webRTC
      conn.send(message);

      // Add message to queue
      messageQueue.add(message);

      if (messageQueue.length >= batchSize && isInternetConnectionAvailable.value) {
        for (int i = 0; i < messageQueue.length; i++) {
          sendBatchMessages(messageQueue[i]);
        }
        messageQueue.clear();
      }
      messageTextEditingController.clear();
    }
  }

  // Send through API
  final RxBool isSendMessageLoading = RxBool(false);
  Future<void> sendBatchMessages(message) async {
    try {
      isSendMessageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'room_id': selectedReceiver.value!.id.toString(),
        'message': message.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSendMessage,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
      } else {
        isSendMessageLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendMessageLoading.value = false;
      ll('sendBatchMessages error: $e');
    }
  }

  // Get Messages
  RxList<Map<String, dynamic>> allRoomMessageList = RxList<Map<String, dynamic>>([]);
  void geAllRoomMessages() {
    for (int i = 0; i < roomList.length; i++) {
      allRoomMessageList.add({
        "roomID": roomList[i].id,
        "userID": roomList[i].roomUserId,
        "peerID": "",
        "status": false.obs,
        "userName": roomList[i].roomName,
        "messages": RxList([]),
      });
    }
    if (globalController.allOnlinePeers.isNotEmpty) {
      updateRoomListWithOnlineUsers();
    }
  }

  void updateRoomListWithOnlineUsers() {
    ll("HELLO");
    Map<int, Map<String, dynamic>> onlineUserMap = {for (var onlineUser in globalController.allOnlinePeers) onlineUser['userID']: onlineUser};

    for (var room in allRoomMessageList) {
      if (onlineUserMap.containsKey(room['userID'])) {
        var onlineUser = onlineUserMap[room['userID']];
        room['peerID'] = onlineUser!['peerID'];
        room['status'] = true.obs;
      }
    }
    RxList<Map<String, dynamic>> temporaryAllRoomMessageList = RxList<Map<String, dynamic>>([]); 
    temporaryAllRoomMessageList.addAll(allRoomMessageList);
    allRoomMessageList.clear();
    allRoomMessageList.addAll(temporaryAllRoomMessageList);
    // ll("Hello: $allRoomMessageList");
  }

  // Set Messages
  void setMessage(userID, messageData) {
    int index = allRoomMessageList.indexWhere((user) => user['roomID'] == userID);
    if (index != -1) {
      allRoomMessageList[index]["messages"].insert(0, messageData);
    }
  }

  //==============================================
  //!           API Implementations
  //==============================================

  final RxBool isInboxLoading = RxBool(false);
  final RxBool roomListScrolled = RxBool(false);
  final Rx<RoomListModel?> roomListData = Rx<RoomListModel?>(null);
  final RxList<RoomData> roomList = RxList<RoomData>([]);
  Future<void> getRoomList() async {
    try {
      isInboxLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetRoomList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        roomList.clear();
        roomListScrolled.value = false;
        roomListData.value = RoomListModel.fromJson(response.data);
        roomList.addAll(roomListData.value!.rooms!.data!);
        geAllRoomMessages();
        isInboxLoading.value = false;
      } else {
        isInboxLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isInboxLoading.value = true;
      ll('getRoomList error: $e');
    }
  }

  final RxBool isMessageListLoading = RxBool(false);
  final RxBool messageListScrolled = RxBool(false);
  final Rx<MessageListModel?> messageListData = Rx<MessageListModel?>(null);
  final RxList<MessageData> messageList = RxList<MessageData>([]);
  Future<void> getMessageList(roomID) async {
    try {
      isMessageListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetMessageList?room_id=$roomID$suffixUrl&page=1&message_id=",
      ) as CommonDM;
      if (response.success == true) {
        messageList.clear();
        roomListScrolled.value = false;
        messageListData.value = MessageListModel.fromJson(response.data);
        messageList.addAll(messageListData.value!.messages!.data!);
        populateRoomMessageList(roomID, messageList);
        isMessageListLoading.value = false;
      } else {
        isMessageListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isMessageListLoading.value = true;
      ll('getMessageList error: $e');
    }
  }

  void populateRoomMessageList(roomID, messageList) {
    int index = allRoomMessageList.indexWhere((user) => user['roomID'] == roomID);
    if (index != -1) {
      allRoomMessageList[index]["messages"].clear();
      allRoomMessageList[index]["messages"].addAll(messageList);
    }
  }
}
