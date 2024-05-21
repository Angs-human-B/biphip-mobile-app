import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
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
  final RxList<Map<String, dynamic>> messages = RxList<Map<String, dynamic>>([]);
  final Rx<FriendFamilyUserData?> selectedReceiver = Rx<FriendFamilyUserData?>(null);

  void onInit() async {
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
  //!    Socket and WebRTC
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
        messages.add({"userType": "sender", "message": data});
        ll("incoming message: $data");
      });

      conn.on("binary").listen((data) {
        ll("binary: $data");
      });

      conn.on("close").listen((event) {
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
          ll("Peer connect data: $data");
        });
        conn.on("binary").listen((data) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("Got binary!")));
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

  void sendMessage(String message) async{
    // Add to offline list
    messages.insert(0, {"userType": "self", "message": message});

    // Send through webRTC
    conn.send(message);

    // Add message to queue
    messageQueue.add(message);


    if (messageQueue.length >= batchSize && shouldSendNow()) {
      await sendBatch();
    }
  }

  // Check for internet connection
  bool shouldSendNow() {
    return true; 
  }

  // Send through API
  Future<void> sendBatch() async {
  }
}
