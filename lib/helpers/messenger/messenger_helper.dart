import 'dart:developer';

import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webRTC;
import 'package:get/get.dart';

class MessengerHelper {
  final MessengerController messengerController = Get.find<MessengerController>();
  Future<void> openUserMedia(isAudioCall) async {
    var stream = await webRTC.navigator.mediaDevices.getUserMedia({'video': isAudioCall ? false : true, 'audio': true});

    messengerController.localStream = stream;
    if (!isAudioCall) {
      messengerController.localRenderer.srcObject = stream;
      messengerController.isLocalFeedStreaming.value = true;
    } else {
      messengerController.isLocalFeedStreaming.value = false;
    }
  }

  Future<void> hangUp() async {
    List<webRTC.MediaStreamTrack> localTracks = messengerController.localRenderer.srcObject!.getTracks();
    localTracks.forEach((track) {
      log("Local track stopped");
      track.stop();
    });
    if (messengerController.localStream != null) {
      messengerController.localStream!.getTracks().forEach((track) {
        log("Local track stopped 2");
        track.stop();
      } );
    }

    if (messengerController.remoteStream != null) {
      messengerController.remoteStream!.getTracks().forEach((track){
        log("Remote stopped");
        track.stop();
      });
    }

    messengerController.localStream!.dispose();
    messengerController.remoteStream?.dispose();
    Get.back();
  }

  Future<void> switchCamera(userID) async {
    var videoTrack = messengerController.localStream?.getVideoTracks().first;
    webRTC.Helper.switchCamera(videoTrack!);
  }

  Future<void> toggleMuteAudio() async {
    var audioTrack = messengerController.localStream?.getAudioTracks().first;

    if (audioTrack != null) {
      audioTrack.enabled = !audioTrack.enabled;
      if(audioTrack.enabled){
        messengerController.isMuted.value = false;
      }else{
         messengerController.isMuted.value = true;
      }
    }
  }
}
