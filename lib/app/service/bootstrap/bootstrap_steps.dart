/// Steps that will be handled during bootstrap process.
/// If app fails during some step, then it will be easy to rerun this process.
/// [storage] - failed at storage step initialization
/// [connection] - failed during creating connection
/// [features] - failed during creating features
/// [completed] - everything is ok, app works normally
enum BootstrapSteps {
  empty,
  remoteNetworks,
  storage,
  connection,
  features,
  completed,
}
