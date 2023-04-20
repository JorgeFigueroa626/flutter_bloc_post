// ignore_for_file: unused_import

import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';

typedef OnSaveCallBack = Function(File image, String description);

class PhotoUpload extends StatefulWidget {
  final OnSaveCallBack onSave;

  const PhotoUpload({Key? key, required this.onSave}) : super(key: key);

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File? sampleImage;
  String? description;
  final ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? const Text("Select an Image")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = File(tempImage!.path);
    });
  }

  Widget enableUpload() {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Image.file(
                  sampleImage!,
                  height: 300.0,
                  width: 300.0,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: (value) {
                    return value!.isEmpty ? "Description is require" : null;
                  },
                  onSaved: (newValue) {
                    description = newValue;
                  },
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 10.0),
                  onPressed: uploadPost,
                  child: const Text("Add a new post"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uploadPost() async {
    if (validateAndSave()) {
      widget.onSave(sampleImage!, description!);
      Navigator.pop(context);
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
