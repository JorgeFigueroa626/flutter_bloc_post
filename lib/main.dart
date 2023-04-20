// ignore_for_file: import_of_legacy_library_into_null_safe, unnecessary_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc_post/src/bloc/blog_bloc/blog_bloc.dart';
import 'package:flutter_bloc_post/src/repository/bloc_repository.dart';
import 'package:flutter_bloc_post/src/ui/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_post/src/ui/photo_upload.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocSupervisor.delegate = BlocDelegate();
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogBloc>(
        create: (context) {
          return BlogBloc(blogRepository: BlogRepository())..add(LoadBlog());
        },
        child: MaterialApp(
          title: "Blog App II",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
                .copyWith(secondary: Colors.redAccent),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => Home(),
            '/addPost': (context) {
              return  PhotoUpload(
                onSave: (image, description) {
                  BlocProvider.of<BlogBloc>(context)
                      .add(AddPost(image, description));
                },
              );
            }
          },
        ));
  }
}
