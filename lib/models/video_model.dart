class Video{
  final String name;
  final String url;
  final String thumbnail;

  Video({
    required this.name,
    required this.thumbnail,
    required this.url
  });
}

List videos = [
  Video(
    name: 'By Blender Foundation', 
    thumbnail: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg', 
    url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
    ),
    Video(
    name: 'Elephant Dream', 
    thumbnail: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg', 
    url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
    ),
    Video(
    name: 'For Bigger Blazes', 
    thumbnail: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg', 
    url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'
    ),
];