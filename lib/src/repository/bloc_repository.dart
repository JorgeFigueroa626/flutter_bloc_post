// ignore_for_file: unused_import

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc_post/src/models/post.dart';
import 'package:intl/intl.dart';

class BlogRepository {
  final databaseReference = FirebaseFirestore.instance.collection("posts");

  Stream<List<Post>> getPosts() {
    return databaseReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromSnapshot(doc)).toList();
    });
  }

  Future<void> putPost(File image, String description) async {
    final Reference postImageRef =
        FirebaseStorage.instance.ref().child("Post Images");
    var timeKey = DateTime.now();

    final UploadTask uploadTask =
        postImageRef.child("$timeKey.jpg").putFile(image);

    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    var url = imageUrl.toString();

    var formatDate = DateFormat('MMM d, yyy');
    var formatTime = DateFormat('EEEE, hh:mm');

    String date = formatDate.format(timeKey);
    String time = formatTime.format(timeKey);
    databaseReference.doc().set({
      'image': url,
      'description': description,
      'date': date,
      'time': time,
    });
  }
}
