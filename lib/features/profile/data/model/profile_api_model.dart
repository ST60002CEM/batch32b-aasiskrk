import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/profile_entity.dart';

part 'profile_api_model.g.dart';

@JsonSerializable()
class ProfileApiModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'fullName')
  final String fullname;
  final String email;
  final String? password;
  final String address;
  final String phone;
  final String? profilePicture;
  final bool isAdmin;
  final String? otpReset;
  final DateTime? otpResetExpires;

  ProfileApiModel({
    this.id,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.address,
    required this.isAdmin,
    required this.otpReset,
    required this.otpResetExpires,
  });

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      fullname: fullname,
      email: email,
      password: password,
      phone: phone,
      address: address,
      profilePicture: profilePicture,
      isAdmin: isAdmin,
      otpReset: otpReset,
      otpResetExpires: otpResetExpires,
    );
  }
}
