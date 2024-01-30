part of 'queries.dart';

class AuthQuery {
  static String login = """
    mutation Login(\$identifier: String!, \$password: String!) {
        login(
            input: {
                identifier: \$identifier
                password: \$password
                provider: "local"
            }
        ) {
            jwt
            user {
                id
                username
                email
                confirmed
                blocked
            }
        }
    }
  """;

  static String register(String username, String email, String password) => """
mutation Register {
    register(input: { username: $username email: $email password: $password }) {
        jwt
        user {
            id
            username
            email
            confirmed
            blocked
            role {
                id
                name
                description
                type
            }
        }
    }
}
""";

  static String emailConfirmation(String confirmation) => """
mutation EmailConfirmation {
    emailConfirmation(confirmation: $confirmation) {
        jwt
        user {
            id
            username
            email
            confirmed
            blocked
            role {
                id
                name
                description
                type
            }
        }
    }
}
""";
}
