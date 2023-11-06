class Story {
  final String name;
  final String imageUrl;
  final String storyImageUrl;
  final bool isViewed;

  const Story({
    required this.name,
    required this.imageUrl,
    required this.storyImageUrl,
    this.isViewed = false,
  });
}