// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Post {
  final String image, description, date, time, id;

  const Post(this.image, this.description, this.date, this.time, this.id);

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    return Post(
      snapshot['image'],
      snapshot['description'],
      snapshot['date'],
      snapshot['time'],
      snapshot.id

    );
  }
}
