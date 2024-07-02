class AddCommentRequest {
  final String content;

  AddCommentRequest({required this.content});

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }
}
class CommentResponse {
  final int id;
  final String content;
  final String author;

  CommentResponse({required this.id, required this.content, required this.author});

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      id: json['id'],
      content: json['content'],
      author: json['author'],
    );
  }
}
