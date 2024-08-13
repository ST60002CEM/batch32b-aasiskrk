import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "fullName")
  final String fullname;

  final String email;

  final String password;

  final String address;

  final String phone;

  final String? profilePicture;

  final bool isAdmin;

  final String? otpReset;

  final String? otpResetExpires;

  GetCurrentUserDto({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
    this.profilePicture,
    required this.isAdmin,
    this.otpReset,
    this.otpResetExpires,
  });

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fullname: fullname,
      email: email,
      password: password,
      address: address,
      phone: phone,
      profilePicture: profilePicture,
      isAdmin: isAdmin,
      otpReset: otpReset,
      otpResetExpires:
          otpResetExpires != null ? DateTime.parse(otpResetExpires!) : null,
    );
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}
