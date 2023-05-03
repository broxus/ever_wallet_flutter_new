import 'package:app/feature/add_seed_to_app/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'create_seed_cubit.freezed.dart';

/// Cubit that helps generating seed phrase.
class CreateSeedCubit extends Cubit<CreateSeedCubitState> {
  CreateSeedCubit() : super(const CreateSeedCubitState.initial());

  Future<void> init() async {
    final seed = await generateKey(accountType: defaultMnemonicType);
    emit(CreateSeedCubitState.generated(seed.words));
  }
}

@freezed
class CreateSeedCubitState with _$CreateSeedCubitState {
  const factory CreateSeedCubitState.initial() = _Initial;

  const factory CreateSeedCubitState.generated(List<String> words) = _Generated;
}
