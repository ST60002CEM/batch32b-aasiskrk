import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>(
  (ref) => AuthApiModel.empty(),
);

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'fullName')
  final String fullname;

  final String email;
  final String address;
  final String? password;
  final String phone;

  AuthApiModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.address,
    required this.password,
    required this.phone,
  });

  // Empty constructor
  AuthApiModel.empty()
      : id = '',
        fullname = '',
        email = '',
        address = '',
        password = '',
        phone = '';

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fullname: fullname,
      email: email,
      address: address,
      password: password ?? '',
      phone: phone,
    );
  }

  AuthApiModel fromEntity(AuthEntity entity) => AuthApiModel(
        fullname: entity.fullname,
        email: entity.email,
        address: entity.address,
        password: entity.password,
        phone: entity.phone,
      );
}
