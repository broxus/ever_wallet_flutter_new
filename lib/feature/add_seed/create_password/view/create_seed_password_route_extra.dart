/// {@template create_seed_password_route_extra}
/// Extra data for <CreateSeedPasswordPage>
/// {@endtemplate}
class CreateSeedRouteExtra {
  /// {@macro create_seed_password_route_extra}
  CreateSeedRouteExtra({
    required this.phrase,
    this.name,
  });

  /// Seed phrase that is used for creation
  final List<String> phrase;

  /// Name of seed phrase that could be entered during adding though profile
  final String? name;
}
