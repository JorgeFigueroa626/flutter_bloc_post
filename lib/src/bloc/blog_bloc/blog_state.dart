part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogLoading extends BlogState {
  @override
  String toString() => 'Blog Loading...';
}

class BlogLoaded extends BlogState {
  final List<Post> posts;

  const BlogLoaded(this.posts);

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'Blog loaded';
}

class BlogNoLoaded extends BlogState {
  @override
  String toString() => 'Blog No Loaded';
}
