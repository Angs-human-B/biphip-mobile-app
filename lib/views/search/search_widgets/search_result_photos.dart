import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchResultPhotos extends StatelessWidget {
  SearchResultPhotos({super.key});

  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
          child: GridView.custom(
            padding: const EdgeInsets.all(k0Padding),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: const [
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(2, 3),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(2, 2),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              childCount: allSearchController.photosList.length,
              (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: cLineColor),
                    borderRadius: k8CircularBorderRadius,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: k8CircularBorderRadius,
                        child: Image.network(
                          allSearchController.photosList[index].fullPath ?? "",
                          fit: BoxFit.cover,
                          width: width,
                          height: 600,
                          errorBuilder: (context, error, stackTrace) => SizedBox(
                            width: width,
                            child: Image.asset(
                              kiDummyImage3ImageUrl, 
                              width: width,
                              height: 600,
                              fit: BoxFit.cover,
                            ),
                          ),
                          loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                      Positioned(
                        left: 4,
                        bottom: 4,
                        child: Text(
                          "by ${allSearchController.photosList[index].user?.fullName ?? ""}",
                          style: regular10TextStyle(cWhiteColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
