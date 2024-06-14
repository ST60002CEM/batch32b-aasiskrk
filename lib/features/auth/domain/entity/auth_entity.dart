import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fullname;
  final String? image;
  final String email;
  final String password;

  const AuthEntity({
    this.id,
    required this.fullname,
    this.image,
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, fullname, image, email, password];
}
