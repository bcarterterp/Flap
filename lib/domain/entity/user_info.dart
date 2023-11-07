import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  const UserInfo({
    required this.name,
    required this.email,
    required this.jwtToken,
  });

  final String name;
  final String email;
  final String jwtToken;

  @override
  List<Object?> get props => [name, email, jwtToken];
}
