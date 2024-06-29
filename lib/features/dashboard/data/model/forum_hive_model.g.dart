// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForumHiveModelAdapter extends TypeAdapter<ForumHiveModel> {
  @override
  final int typeId = 1;

  @override
  ForumHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForumHiveModel(
      postId: fields[0] as String?,
      postPicture: fields[1] as String,
      postTitle: fields[2] as String,
      postDescription: fields[3] as String,
      postTags: (fields[4] as List).cast<String>(),
      postLikes: fields[5] as int,
      postDislikes: fields[6] as int,
      postViews: fields[7] as int,
      postedTime: fields[8] as DateTime,
      postedUserId: fields[9] as String,
      postedFullname: fields[10] as String,
      commentedUsers: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ForumHiveModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.postId)
      ..writeByte(1)
      ..write(obj.postPicture)
      ..writeByte(2)
      ..write(obj.postTitle)
      ..writeByte(3)
      ..write(obj.postDescription)
      ..writeByte(4)
      ..write(obj.postTags)
      ..writeByte(5)
      ..write(obj.postLikes)
      ..writeByte(6)
      ..write(obj.postDislikes)
      ..writeByte(7)
      ..write(obj.postViews)
      ..writeByte(8)
      ..write(obj.postedTime)
      ..writeByte(9)
      ..write(obj.postedUserId)
      ..writeByte(10)
      ..write(obj.postedFullname)
      ..writeByte(11)
      ..write(obj.commentedUsers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForumHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
