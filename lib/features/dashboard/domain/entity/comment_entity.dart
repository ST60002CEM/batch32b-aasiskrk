import 'package:json_annotation/json_annotation.dart';

part 'comment_entity.g.dart';

@JsonSerializable()
class AddCommentEntity {
  final String? commentId;
  final String userId;
  final String userName;
  final String comment;
  final String commentedAt;

  AddCommentEntity({
    this.commentId,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.commentedAt,
  });

  AddCommentEntity copyWith({
    String? commentId,
    String? userId,
    String? userName,
    String? comment,
    String? commentedAt,
  }) {
    return AddCommentEntity(
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      comment: comment ?? this.comment,
      commentedAt: commentedAt ?? this.commentedAt,
      // Include the new field
    );
  }

  factory AddCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$AddCommentEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AddCommentEntityToJson(this);
}
