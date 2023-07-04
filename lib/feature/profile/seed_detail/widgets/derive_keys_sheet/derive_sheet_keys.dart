import 'package:app/di/di.dart';
import 'package:app/feature/profile/seed_detail/widgets/derive_keys_sheet/derive_keys_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method that displays [DeriveKeysSheet] sheet.
/// Showing this sheet means, that [password] is correct for [publicKey].
ModalRoute<void> deriveKeysSheet(PublicKey publicKey, String password) {
  return commonBottomSheetRoute(
    title: LocaleKeys.selectKeysYouNeed.tr(),
    body: (_, controller) => BlocProvider<DeriveKeysCubit>(
      create: (context) => DeriveKeysCubit(
        inject<NekotonRepository>(),
        publicKey,
        password,
      )..init(),
      child: DeriveKeysSheet(
        controller: controller,
        masterKey: publicKey,
      ),
    ),
  );
}

/// Widget that shows keys that could be derived from publicKey of seed.
class DeriveKeysSheet extends StatelessWidget {
  const DeriveKeysSheet({
    required this.controller,
    required this.masterKey,
    super.key,
  });

  final ScrollController controller;

  /// For master key changing its state must be disabled (it's always checked)
  final PublicKey masterKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeriveKeysCubit, DeriveKeysState>(
      listener: (context, state) {
        state.whenOrNull(
          data: (
            _,
            __,
            ___,
            ____,
            _____,
            ______,
            _______,
            ________,
            completed,
          ) {
            if (completed) {
              Navigator.of(context).pop();
            }
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          data: (
            canPrevPage,
            canNextPage,
            currentPageIndex,
            pageCount,
            displayDerivedKeys,
            selectedKeys,
            keyNames,
            isLoading,
            isCompleted,
          ) {
            return SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              children: [
                SeparatedRow(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.pageCountOf.tr(
                          args: [
                            '${currentPageIndex + 1}',
                            '$pageCount',
                          ],
                        ),
                      ),
                    ),
                    // TODO(alex-a4): replace to svg when it will be added
                    CommonIconButton.icon(
                      icon: Icons.arrow_back_ios_new_rounded,
                      buttonType: EverButtonType.ghost,
                      onPressed: canPrevPage
                          ? () => context.read<DeriveKeysCubit>().prevPage()
                          : null,
                    ),
                    CommonIconButton.svg(
                      svg: Assets.images.caretRight.path,
                      buttonType: EverButtonType.ghost,
                      onPressed: canNextPage
                          ? () => context.read<DeriveKeysCubit>().nextPage()
                          : null,
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: SeparatedColumn(
                      mainAxisSize: MainAxisSize.min,
                      children: displayDerivedKeys
                          .map(
                            (k) => _keyItem(
                              key: k,
                              name: keyNames[k],
                              isSelected: selectedKeys.contains(k),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                _selectButton(isLoading),
              ],
            );
          },
        );
      },
    );
  }

  Widget _selectButton(bool isLoading) {
    return Builder(
      builder: (context) {
        return CommonButton.primary(
          fillWidth: true,
          isLoading: isLoading,
          text: LocaleKeys.selectWord.tr(),
          onPressed: () => context.read<DeriveKeysCubit>().select(),
        );
      },
    );
  }

  Widget _keyItem({
    required PublicKey key,
    required bool isSelected,
    String? name,
  }) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        final disabled = key == masterKey;

        return CommonListTile(
          onPressed: disabled
              ? null
              : () => isSelected
                  ? context.read<DeriveKeysCubit>().uncheckKey(key)
                  : context.read<DeriveKeysCubit>().checkKey(key),
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.key.path,
          ),
          titleText: name ?? key.toEllipseString(),
          trailing: CommonIconWidget.svg(
            svg: isSelected
                ? Assets.images.checkSquare.path
                : Assets.images.checkEmpty.path,
            color: disabled
                ? colors.textSecondary
                : isSelected
                    ? colors.textPrimary
                    : colors.strokePrimary,
          ),
        );
      },
    );
  }
}
