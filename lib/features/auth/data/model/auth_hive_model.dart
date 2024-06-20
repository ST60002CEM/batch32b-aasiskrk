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
  final String email;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String password;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fullname,
    required this.email,
    required this.password,
    required this.address,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fullname: '',
          email: '',
          password: '',
          address: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: userId,
        fullname: fullname,
        email: email,
        password: password,
        address: address,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        fullname: entity.fullname,
        email: entity.email,
        password: entity.password,
        address: entity.address,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fullname: $fullname, email: $email,   password: $password, address: $address';
  }
}
