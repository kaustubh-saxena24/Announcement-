import 'package:flutter/material.dart';
import '../model/post_model.dart';

import '../../services/firestore_service.dart';

class SectionScreen extends StatelessWidget {
  final String sectionName;
  final firestore = FirestoreService();

  SectionScreen({super.key, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sectionName)),
      body: StreamBuilder<List<Post>>(
        stream: firestore.getPosts(sectionName),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.content),
              );
            },
          );
        },
      ),
    );
  }
}
