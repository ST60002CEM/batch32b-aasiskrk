import 'package:equatable/equatable.dart';

class PostFailure extends Equatable {
  final String message;

  const PostFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
