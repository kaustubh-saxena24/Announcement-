import 'package:announcement/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔁 Fetch all section names
  Stream<List<String>> getSections() {
    return _db.collection('sections').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc['name'] as String).toList());
  }

  // 📥 Add a new section (section name used as document ID to avoid duplicates)
  Future<void> addSection(String name) async {
    final docRef = _db.collection('sections').doc(name);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({'name': name});
    }
  }

  // 📤 Get posts under a specific section
  Stream<List<Post>> getPosts(String sectionName) {
    final sectionDoc = _db.collection('sections').doc(sectionName);

    return sectionDoc
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Post.fromMap(doc.data())).toList());
  }

  // ➕ Add a post to a specific section
  Future<void> addPost(String sectionName, Post post) async {
    final sectionDoc = _db.collection('sections').doc(sectionName);
    final sectionSnapshot = await sectionDoc.get();

    if (sectionSnapshot.exists) {
      await sectionDoc.collection('posts').add(post.toMap());
    }
  }
}
