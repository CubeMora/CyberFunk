// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoClass {
  final String title;
  final String summary;
  final String videoUrl;
  final bool isCompleted;
  final int percentage;
  final String questionPoolPath;
  VideoClass({
    required this.title,
    required this.summary,
    required this.videoUrl,
    required this.isCompleted,
    required this.percentage,
    required this.questionPoolPath,
  });

  VideoClass copyWith({
    String? title,
    String? summary,
    String? videoUrl,
    bool? isCompleted,
    int? percentage,
    String? questionPoolPath,
  }) {
    return VideoClass(
      title: title ?? this.title,
      summary: summary ?? this.summary,
      videoUrl: videoUrl ?? this.videoUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      percentage: percentage ?? this.percentage,
      questionPoolPath: questionPoolPath ?? this.questionPoolPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'summary': summary,
      'videoUrl': videoUrl,
      'isCompleted': isCompleted,
      'percentage': percentage,
      'questionPoolPath': questionPoolPath,
    };
  }

  factory VideoClass.fromMap(Map<String, dynamic> map) {
    return VideoClass(
      title: map['title'] as String,
      summary: map['summary'] as String,
      videoUrl: map['videoUrl'] as String,
      isCompleted: map['isCompleted'] as bool,
      percentage: map['percentage'] as int,
      questionPoolPath: map['questionPoolPath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoClass.fromJson(String source) => VideoClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoClass(title: $title, summary: $summary, videoUrl: $videoUrl, isCompleted: $isCompleted, percentage: $percentage, questionPoolPath: $questionPoolPath)';
  }

  @override
  bool operator ==(covariant VideoClass other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.summary == summary &&
      other.videoUrl == videoUrl &&
      other.isCompleted == isCompleted &&
      other.percentage == percentage &&
      other.questionPoolPath == questionPoolPath;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      summary.hashCode ^
      videoUrl.hashCode ^
      isCompleted.hashCode ^
      percentage.hashCode ^
      questionPoolPath.hashCode;
  }
}
