import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fullname;
  final String email;
  final String password;
  final String address;
  final String phone;

  const AuthEntity({
    this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, fullname, email, password, address, phone];
}
