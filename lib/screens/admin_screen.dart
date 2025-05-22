import 'package:flutter/material.dart';
import '../model/post_model.dart';
import '../../services/firestore_service.dart';


class AdminScreen extends StatelessWidget {
  final firestore = FirestoreService();
  final sectionController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: sectionController,
              decoration: const InputDecoration(labelText: 'Section Name'),
            ),
            ElevatedButton(
              child: const Text('Add Section'),
              onPressed: () {
                firestore.addSection(sectionController.text);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Post Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Post Content'),
            ),
            ElevatedButton(
              child: const Text('Add Post'),
              onPressed: () {
                final post = Post(
                  title: titleController.text,
                  content: contentController.text,
                  timestamp: DateTime.now(),
                );
                firestore.addPost(sectionController.text, post);
              },
            ),
          ],
        ),
      ),
    );
  }
}
