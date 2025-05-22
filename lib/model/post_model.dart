import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String content;
  final DateTime timestamp;

  Post({required this.title, required this.content, required this.timestamp});

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'],
      content: map['content'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
