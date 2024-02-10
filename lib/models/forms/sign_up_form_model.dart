class SignUpFormModel {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? password;
  final String? blocked;

  SignUpFormModel({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.blocked,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'username': username,
      'email': email,
      'blocked': blocked,
      'password': password,
    };
  }
}
