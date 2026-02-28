class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;

  String get fullName => '$firstName $lastName'.trim();

  factory AuthUser.fromMap(Map<String, dynamic> json) {
    final name = (json['name'] as Map?)?.cast<String, dynamic>() ?? const {};
    return AuthUser(
      id: (json['id'] as num?)?.toInt() ?? 0,
      email: (json['email'] as String?) ?? '',
      username: (json['username'] as String?) ?? '',
      firstName: (name['firstname'] as String?) ?? '',
      lastName: (name['lastname'] as String?) ?? '',
      phone: (json['phone'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'name': <String, dynamic>{'firstname': firstName, 'lastname': lastName},
    };
  }
}
