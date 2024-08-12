import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'rename_sheet_cubit.freezed.dart';
part 'rename_sheet_state.dart';

/// Cubit of sheet that renames key or seed phrase.
/// Same logic for both of them, but seed/key depends difference needs only for
/// snackbar text.
class RenameSheetCubit extends Cubit<RenameSheetState> {
  RenameSheetCubit({
    required this.nekotonRepository,
    required this.publicKey,
    required this.renameSeed,
  }) : super(const RenameSheetState.init());

  final NekotonRepository nekotonRepository;
  final PublicKey publicKey;

  /// if true, then seed with [publicKey] will be renamed, else plain key
  final bool renameSeed;

  void rename(String name) {
    final newName = name.trim();
    if (newName.isEmpty) return;

    if (renameSeed) {
      final seed = nekotonRepository.seedList.findSeed(publicKey);
      if (seed == null) {
        return;
      }
      seed.rename(name: newName);
    } else {
      final key = nekotonRepository.seedList.findSeedKey(publicKey);
      if (key != null) {
        key.rename(name: newName);
      }
    }

    emit(RenameSheetState.completed(isSeed: renameSeed));
  }
}
