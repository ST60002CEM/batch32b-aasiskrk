import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/comment_entity.dart';

part 'add_comment_api_model.g.dart';

@JsonSerializable()
class AddCommentApiModel {
  @JsonKey(name: '_id')
  final String? commentId;
  final String comment;
  final String userId;
  final String commentedAt;
  final String userName;

  AddCommentApiModel({
    this.commentId,
    required this.comment,
    required this.commentedAt,
    required this.userId,
    required this.userName,
  });

  factory AddCommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$AddCommentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentApiModelToJson(this);

  AddCommentEntity toEntity() {
    return AddCommentEntity(
      commentId: commentId,
      comment: comment,
      commentedAt: commentedAt,
      userId: userId,
      userName: userName,
    );
  }
}
