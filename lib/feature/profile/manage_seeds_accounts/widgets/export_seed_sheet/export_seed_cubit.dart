import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'export_seed_state.dart';

part 'export_seed_cubit.freezed.dart';

/// Cubit that enters user password and exports seed phrase.
class ExportSeedCubit extends Cubit<ExportSeedState> {
  ExportSeedCubit(
    this.nekotonRepository,
    this.publicKey,
  ) : super(const ExportSeedState.initial());

  final NekotonRepository nekotonRepository;
  final String publicKey;

  Future<void> export(String password) async {
    final seed = nekotonRepository.seedList.findSeed(publicKey);
    if (seed != null) {
      try {
        final phrase = await seed.export(password);
        emit(ExportSeedState.success(phrase));
      } catch (_) {
        // Typically, this will never happens, as widget provides only
        // correct password, but we check error for any case.
        emit(ExportSeedState.error(LocaleKeys.passwordIsWrong.tr()));
      }
    } else {
      emit(ExportSeedState.error(LocaleKeys.seedIsMissing.tr()));
    }
  }
}
