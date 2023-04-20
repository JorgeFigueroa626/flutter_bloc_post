// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_post/src/bloc/blog_bloc/blog_bloc.dart';
import 'package:flutter_bloc_post/src/models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> postList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BlogNoLoaded) {
          return Center(
            child: Column(
              children: const <Widget>[
                Icon(Icons.error),
                Text('Cannot load posts')
              ],
            ),
          );
        }
        if (state is BlogLoaded) {
          postList = state.posts;
          return Container(
              child: postList.isEmpty
                  ? const Center(
                      child: Text('No Blog Avaliable'),
                    )
                  : ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (_, index) {
                        return postsUI(
                          postList[index].image,
                          postList[index].description,
                          postList[index].date,
                          postList[index].time,
                        );
                      },
                    ));
        }
        return Container();
      },
    );
  }

  Widget postsUI(String image, String description, String date, String time) {
    return Card(
      elevation: 10.0,
      margin:const EdgeInsets.all(14.0),
      child: Container(
        padding:const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10.0),
            Text(
              description,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
