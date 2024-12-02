import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'export_seed_cubit.freezed.dart';

part 'export_seed_state.dart';

/// Cubit that enters user password and exports seed phrase.
class ExportSeedCubit extends Cubit<ExportSeedState> with BlocBaseMixin {
  ExportSeedCubit(
    this.nekotonRepository,
    this.publicKey,
  ) : super(const ExportSeedState.initial());

  final NekotonRepository nekotonRepository;
  final PublicKey publicKey;

  Future<void> export(String password) async {
    final seed = nekotonRepository.seedList.findSeed(publicKey);
    if (seed != null) {
      try {
        final phrase = await seed.export(password);
        emitSafe(ExportSeedState.success(phrase));
      } catch (_) {
        // Typically, this will never happens, as widget provides only
        // correct password, but we check error for any case.
        emitSafe(ExportSeedState.error(LocaleKeys.passwordIsWrong.tr()));
      }
    } else {
      emitSafe(ExportSeedState.error(LocaleKeys.seedIsMissing.tr()));
    }
  }
}
