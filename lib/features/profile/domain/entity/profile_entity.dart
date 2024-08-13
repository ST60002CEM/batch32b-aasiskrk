import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? id;
  final String fullname;
  final String email;
  final String password;
  final String address;
  final int phone;
  final String? profilePicture;
  final bool isAdmin;
  final String? otpReset;
  final DateTime? otpResetExpires;

  const ProfileEntity({
    this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
    this.profilePicture,
    required this.isAdmin,
    required this.otpReset,
    required this.otpResetExpires,
  });

  ProfileEntity copyWith({
    final String? id,
    final String? fullname,
    final String? email,
    final String? password,
    final String? address,
    final int? phone,
    final String? profilePicture,
    final bool? isAdmin,
    final String? otpReset,
    final DateTime? otpResetExpires,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
      isAdmin: isAdmin ?? this.isAdmin,
      otpReset: otpReset ?? this.otpReset,
      otpResetExpires: otpResetExpires ?? this.otpResetExpires,
    );
  }

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
