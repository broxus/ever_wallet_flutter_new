import 'package:go_router/go_router.dart';

String? getQueryParams(GoRouterState state, String key) {
  return state.uri.queryParameters[key];
}
