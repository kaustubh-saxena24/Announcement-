import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import 'section_screen.dart';

class HomeScreen extends StatelessWidget {
  final firestore = FirestoreService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sections')),

      body: StreamBuilder<List<String>>(
        stream: firestore.getSections(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final sections = snapshot.data!;
          return ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(sections[index]),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SectionScreen(sectionName: sections[index]),
                  ),
                ),
              );
            },
          );
        },
      ),

      // 👇 Floating Action Button to Add New Section
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddSectionDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text("New"),
      ),
    );
  }

  // 👇 Show Dialog to Add New Section
  void _showAddSectionDialog(BuildContext context) {
    final TextEditingController sectionController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Announcement"),
        content: TextField(
          controller: sectionController,
          decoration: const InputDecoration(hintText: "Content"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final newSection = sectionController.text.trim();
              if (newSection.isNotEmpty) {
                await firestore.addSection(newSection);
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
