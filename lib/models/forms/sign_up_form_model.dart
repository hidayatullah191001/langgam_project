class SignUpFormModel {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? password;
  final String? blocked;
  final String? confirmed;

  SignUpFormModel({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.blocked,
    this.confirmed,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'username': username,
      'email': email,
      'blocked': blocked,
      'confirmed': confirmed,
      'password': password,
    };
  }
}
