import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerWidget({
    super.key,
  });
  // final String videoUrl;
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  //   late VideoPlayerController videoPlayerController;
  // late Future<void> initializedVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cBlackColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cBlackColor,
          body: FutureBuilder(
            future: allSearchController.initializedVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: allSearchController.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(allSearchController.videoPlayerController),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
