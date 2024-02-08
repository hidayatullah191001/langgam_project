class SignInFormModel {
  final String? identifier;
  final String? password;

  SignInFormModel({
    this.identifier,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'password': password,
    };
  }
}
