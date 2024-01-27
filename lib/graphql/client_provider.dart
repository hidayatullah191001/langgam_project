import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientProvider extends StatelessWidget {
  final Widget child;
  final String uri;
  String? subscriptionUri;

  ClientProvider({
    required this.child,
    required this.uri,
    this.subscriptionUri,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: HttpLink(uri),
        cache: GraphQLCache(),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}
