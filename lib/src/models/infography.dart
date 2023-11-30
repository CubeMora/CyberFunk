// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Infography {

  final String title;
  final String image;
  final String description; 
  Infography({
    required this.title,
    required this.image,
    required this.description,
  });


  Infography copyWith({
    String? title,
    String? image,
    String? description,
  }) {
    return Infography(
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'description': description,
    };
  }

  factory Infography.fromMap(Map<String, dynamic> map) {
    return Infography(
      title: map['title'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Infography.fromJson(String source) => Infography.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Infography(title: $title, image: $image, description: $description)';

  @override
  bool operator ==(covariant Infography other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.image == image &&
      other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ image.hashCode ^ description.hashCode;
}
