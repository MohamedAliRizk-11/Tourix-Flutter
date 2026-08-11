import 'package:equatable/equatable.dart';

class AvatarState extends Equatable {
  final String? avatarPath;
  final bool isLoading;

  const AvatarState({this.avatarPath, this.isLoading = false});

  @override
  List<Object?> get props => [avatarPath, isLoading];
}
