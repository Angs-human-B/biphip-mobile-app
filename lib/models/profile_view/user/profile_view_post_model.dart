import 'package:bip_hip/models/home/new_post_list_model.dart';

class ProfileViewPostModel {
    Posts? posts;

    ProfileViewPostModel({
        this.posts,
    });

    factory ProfileViewPostModel.fromJson(Map<String, dynamic> json) => ProfileViewPostModel(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
    );
}
