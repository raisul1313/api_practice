class Post {
  int? userId;
  int? id;
  String? title;

  Post({this.userId, this.id, this.title});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }
}

class PostList {
  final List<Post>? posts;

  PostList({this.posts});

  factory PostList.fromJson(List<dynamic> parsedJson){
    List<Post> posts = <Post>[];
    posts = parsedJson.map((e) => Post.fromJson(e)).toList();
    return PostList(posts: posts);
  }
}
