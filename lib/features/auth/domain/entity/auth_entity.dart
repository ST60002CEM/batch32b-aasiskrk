import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fullname;
  final String email;
  final String password;
  final String address;
  final String phone;
  final String? profilePicture;
  final bool isAdmin;
  final String? otpReset;
  final DateTime? otpResetExpires;

  const AuthEntity({
    this.id,
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

  @override
  List<Object?> get props => [
        id,
        fullname,
        email,
        password,
        address,
        phone,
        profilePicture,
        isAdmin,
        otpReset,
        otpResetExpires,
      ];
}
