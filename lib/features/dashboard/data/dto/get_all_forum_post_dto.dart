import 'package:json_annotation/json_annotation.dart';

import '../model/forum_api_model.dart';

part 'get_all_forum_post_dto.g.dart';

@JsonSerializable()
class GetAllForumPostDTO {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'posts')
  final List<ForumApiModel> data;

  GetAllForumPostDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetAllForumPostDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllForumPostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllForumPostDTOToJson(this);
}
