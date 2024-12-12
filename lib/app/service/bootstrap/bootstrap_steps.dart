/// Steps that will be handled during bootstrap process.
/// If app fails during some step, then it will be easy to rerun this process.
/// [storage] - failed at storage step initialization
/// [connection] - failed during creating connection
/// [features] - failed during creating features
/// [completed] - everything is ok, app works normally
enum BootstrapSteps {
  empty,
  storage,
  connection,
  features,
  completed,
}
// enum BootstrapSteps {
//   empty,
//   storage,
//   connection,
//   features,
//   completed,
//   error,
//   errorConnection;
//
//   bool get isError => this == error || this == errorConnection;
// }
// class BootstrapStep {
//   const BootstrapStep._();
//
//   static const empty = BootstrapEmptyStep._();
//   static const storage = BootstrapStorageStep._();
//   static const connection = BootstrapConnectionStep._();
//   static const features = BootstrapFeaturesStep._();
//   static const completed = BootstrapCompletedStep._();
//   static const errorStorage = BootstrapErrorStorage._();
//   static const errorConnection = BootstrapErrorConnection._();
//   static const errorFeature = BootstrapErrorFeature._();
//
//   static final steps = [
//     empty,
//     storage,
//     connection,
//     features,
//     completed,
//   ];
//
//   String get name {
//     return toString();
//   }
//
//   int get index {
//     final index = steps.indexOf(this);
//     if (index == -1) {
//       return 0;
//     }
//
//     return index;
//   }
//
//   static bool checkIsError(BootstrapStep step) => switch (step) {
//         BootstrapStep.errorStorage ||
//         BootstrapStep.errorConnection ||
//         BootstrapStep.errorFeature =>
//           true,
//         _ => false,
//       };
// }
//
// class BootstrapEmptyStep extends BootstrapStep {
//   const BootstrapEmptyStep._() : super._();
// }
//
// class BootstrapStorageStep extends BootstrapStep {
//   const BootstrapStorageStep._() : super._();
// }
//
// class BootstrapConnectionStep extends BootstrapStep {
//   const BootstrapConnectionStep._() : super._();
// }
//
// class BootstrapFeaturesStep extends BootstrapStep {
//   const BootstrapFeaturesStep._() : super._();
// }
//
// class BootstrapCompletedStep extends BootstrapStep {
//   const BootstrapCompletedStep._() : super._();
// }
//
// class BootstrapErrorStorage extends BootstrapStorageStep {
//   const BootstrapErrorStorage._() : super._();
// }
//
// class BootstrapErrorConnection extends BootstrapConnectionStep {
//   const BootstrapErrorConnection._() : super._();
// }
//
// class BootstrapErrorFeature extends BootstrapFeaturesStep {
//   const BootstrapErrorFeature._() : super._();
// }
