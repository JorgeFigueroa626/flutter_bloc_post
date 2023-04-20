import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_post/src/bloc/blog_bloc/blog_bloc.dart';
import 'package:flutter_bloc_post/src/repository/bloc_repository.dart';
import 'package:flutter_bloc_post/src/ui/home/home_page.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final BlogRepository _blogRepository = BlogRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogBloc>(
      create: (context) => BlogBloc(blogRepository: _blogRepository)..add(LoadBlog()),
      child: Scaffold(
        appBar: AppBar(
          title:const Text("Home"),),
          body:const HomePage(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/addPost'),
            child:const Icon(Icons.add),
            ),
      ),
    );
  }
}
