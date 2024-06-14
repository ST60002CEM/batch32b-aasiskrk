import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullname;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String password;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fullname,
    required this.email,
    required this.image,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fullname: '',
          image: '',
          email: '',
          password: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: userId,
        fullname: fullname,
        image: image,
        email: email,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        fullname: entity.fullname,
        email: entity.email,
        image: entity.image!,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fullname: $fullname, email: $email,  image: $image, password: $password';
  }
}
