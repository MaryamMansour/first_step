
class AddCommentRequest {
  final String content;

  AddCommentRequest({required this.content});

  Map<String, dynamic> toJson() {
    return {'content': content};
  }
}

class CommentResponse {
  final int commentID;
  final String content;
  final String userName;
  final int projectId;

  CommentResponse({
    required this.commentID,
    required this.content,
    required this.userName,
    required this.projectId,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      commentID: json['commentID'],
      content: json['content'],
      userName: json['userName'],
      projectId: json['project']['projectID'],
    );
  }
}
