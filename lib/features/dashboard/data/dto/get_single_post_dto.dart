import 'package:json_annotation/json_annotation.dart';

import '../model/forum_api_model.dart';

part 'get_single_post_dto.g.dart';

@JsonSerializable()
class GetSinglePostDTO {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'post')
  final ForumApiModel data;

  GetSinglePostDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSinglePostDTO.fromJson(Map<String, dynamic> json) =>
      _$GetSinglePostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetSinglePostDTOToJson(this);
}
