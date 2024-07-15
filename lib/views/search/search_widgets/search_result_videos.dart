import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/videos/widgets/video_player_widget.dart';
import 'package:bip_hip/views/search/search_widgets/search_video_content.dart';

class SearchResultVideos extends StatelessWidget {
  SearchResultVideos({super.key});

  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: k16Padding),
          child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(k0Padding),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => kH8sizedBox,
              itemCount: allSearchController.videosList.length,
              itemBuilder: (context, index) {
                final item = allSearchController.videosList[index];
                return InkWell(
                  onTap: () {
                    allSearchController.videoUrl.value = item.fullPath.toString();
                    allSearchController.customOnInit();
                    Get.to(() => VideoPlayerWidget());
                  },
                  child: SearchVideosContent(
                    image: item.fullPath.toString(),
                    title: item.title ?? ksNA.tr,
                    name: item.user?.fullName ?? ksNA.tr,
                    totalView: item.totalViewCount.toString(),
                    time: item.imageTakenTime.toString(),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
