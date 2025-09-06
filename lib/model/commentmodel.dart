class Comment {
  int id;
  String? profilePhoto;
  final String name;
  final int rating;
  final String comment;
  final int userId;
  int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.userId,
    required this.profilePhoto,
    required this.name,
    required this.rating,
    required this.comment,
    required this.likes,
    required this.isLiked,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      profilePhoto: json['profilePhoto'],
      name: json['name'] ?? '',
      rating: json['rating'],
      userId: json['userId'],
      comment: json['comment'] ?? '',
      likes: json['likes'] ?? 0,
      isLiked: json['isLiked'] ?? false,
    );
  }
}
