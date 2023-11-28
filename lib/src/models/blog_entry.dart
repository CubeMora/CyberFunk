class BlogEntry {
  final String title;
  final List<String> imageUrl;
  final List<String> description;
  final String url;

  BlogEntry({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.url,
  });

  factory BlogEntry.fromJson(Map<String, dynamic> json) {
    return BlogEntry(
      title: json['title'] ?? '',
      imageUrl: List<String>.from(json['image_url'] ?? []),
      description: List<String>.from(json['description'] ?? []),
      url: json['url'] ?? '',
    );
  }
}