import 'package:json_annotation/json_annotation.dart';

import '../model/profile_api_model.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDTO {
  @JsonKey(name: "user")
  final ProfileApiModel userData;
  final bool success;
  // final String image;

  ProfileDTO({
    required this.userData,
    required this.success,
  });

  factory ProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDTOToJson(this);
}
