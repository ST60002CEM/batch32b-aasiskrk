import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/forgot_password_entity.dart';

@JsonSerializable()
class ForgotPasswordApiModel {
  final bool success;
  final String message;

  ForgotPasswordApiModel({required this.success, required this.message});

  factory ForgotPasswordApiModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordApiModel(
      success: json['success'],
      message: json['message'],
    );
  }

  ForgotPasswordEntity toEntity() => ForgotPasswordEntity(
        success: success,
        message: message,
      );

  ForgotPasswordApiModel.empty()
      : success = false,
        message = '';
}
