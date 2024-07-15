class DashboardProfileOverviewModel {
    int? postReach;
    int? postEngagement;
    int? newProfileFollowers;
    int? reactions;
    int? gifts;
    int? stars;
    String? pendents;
    int? comments;
    int? shares;
    int? photoViews;
    int? linkClicks;
    int? hideAllPosts;
    int? unfollows;

    DashboardProfileOverviewModel({
        this.postReach,
        this.postEngagement,
        this.newProfileFollowers,
        this.reactions,
        this.gifts,
        this.stars,
        this.pendents,
        this.comments,
        this.shares,
        this.photoViews,
        this.linkClicks,
        this.hideAllPosts,
        this.unfollows,
    });

    factory DashboardProfileOverviewModel.fromJson(Map<String, dynamic> json) => DashboardProfileOverviewModel(
        postReach: json["post_reach"],
        postEngagement: json["post_engagement"],
        newProfileFollowers: json["new_profile_followers"],
        reactions: json["reactions"],
        gifts: json["gifts"],
        stars: json["stars"],
        pendents: json["pendents"],
        comments: json["comments"],
        shares: json["shares"],
        photoViews: json["photo_views"],
        linkClicks: json["link_clicks"],
        hideAllPosts: json["hide_all_posts"],
        unfollows: json["unfollows"],
    );

}
