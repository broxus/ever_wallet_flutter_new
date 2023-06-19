import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'rename_sheet_state.dart';

part 'rename_sheet_cubit.freezed.dart';

/// Cubit of sheet that renames key or seed phrase.
/// Same logic for both of them, but seed/key depends difference needs only for
/// snackbar text.
class RenameSheetCubit extends Cubit<RenameSheetState> {
  RenameSheetCubit(
    this.nekotonRepository,
    this.publicKey,
  ) : super(const RenameSheetState.init());

  final NekotonRepository nekotonRepository;
  final String publicKey;

  void rename(String newName) {
    final key = nekotonRepository.seedList.findSeedKey(publicKey);
    if (key == null || newName.isEmpty) {
      return;
    }
    key.rename(name: newName);
    emit(RenameSheetState.completed(isSeed: key.isMaster));
  }
}
