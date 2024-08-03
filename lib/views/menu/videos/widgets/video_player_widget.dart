import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerWidget({
    super.key,
  });
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    allSearchController.videoProgress.value = allSearchController.videoPlayerController.value.position.inSeconds.toDouble();
    return Container(
      color: cBlackColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cBlackColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: allSearchController.initializedVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return InkWell(
                      onTap: () {
                        allSearchController.enableVideoKeyLayer();
                      },
                      child: AspectRatio(
                        aspectRatio: allSearchController.videoPlayerController.value.aspectRatio,
                        child: Obx(
                          () => Stack(
                            children: [
                              Container(height: width, width: width, color: Colors.green, child: VideoPlayer(allSearchController.videoPlayerController)),
                              if (allSearchController.showVideoKeys.value)
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      if (allSearchController.isVideoPlaying.value) {
                                        allSearchController.videoPlayerController.pause();
                                        allSearchController.isVideoPlaying.value = false;
                                      } else {
                                        allSearchController.videoPlayerController.play();
                                        allSearchController.isVideoPlaying.value = true;
                                      }
                                    },
                                    child: Icon(
                                      allSearchController.isVideoPlaying.value ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_sharp,
                                      size: kIconSize40,
                                      color: cBackgroundColor,
                                    ),
                                  ),
                                ),
                              Positioned(
                                bottom: 0,
                                child: Obx(
                                  () => SizedBox(
                                    width: width,
                                    child: Row(
                                      children: [
                                        if (allSearchController.showVideoKeys.value)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 7.0),
                                            child: Text(
                                              "${allSearchController.videoSeconds(allSearchController.videoPlayerController.value.position.inSeconds)}/${allSearchController.videoSeconds(allSearchController.videoPlayerController.value.duration.inSeconds)}",
                                              style: regular12TextStyle(cWhiteColor),
                                            ),
                                          ),
                                        Expanded(
                                          child: SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              thumbColor: cPrimaryColor,
                                              thumbShape: allSearchController.showVideoKeys.value ? null : SliderComponentShape.noThumb,
                                            ),
                                            child: Slider(
                                              activeColor: cPrimaryColor,
                                              inactiveColor: cBackgroundColor,
                                              value: allSearchController.videoProgress.value,
                                              min: 0,
                                              max: allSearchController.videoPlayerController.value.duration.inSeconds.toDouble(),
                                              onChanged: (double value) {
                                                allSearchController.videoPlayerController.seekTo(Duration(seconds: value.toInt()));
                                                allSearchController.videoProgress.value = value;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
