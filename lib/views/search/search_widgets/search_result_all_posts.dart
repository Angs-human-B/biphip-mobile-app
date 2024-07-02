import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';

class SearchResultAllPost extends StatelessWidget {
  SearchResultAllPost({super.key});

  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: k16Padding,
          ),
          child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(k0Padding),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Container(
                    height: h10,
                    width: width,
                    color: cBackgroundColor,
                  ),
              itemCount: Get.find<GlobalController>().commonPostList.length,
              itemBuilder: (context, index) {
                return Container(
                  color: cWhiteColor,
                  width: width - 40,
                  child: CommonPostWidget(
                    postIndex: index,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
