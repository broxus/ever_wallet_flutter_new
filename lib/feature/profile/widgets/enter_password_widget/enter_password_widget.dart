import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/profile/widgets/enter_password_widget/enter_password_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// This is a widget that allows user to enter password for any action or
/// user biometry if available.
///
/// Also widget stores/get password from biometry storage.
///
/// This widget can be displayed in any sheet.
///
/// !!! This widget must be an entry point for entering any password, because
/// this widget contains internal logic for checking biometry.
///
/// !!! Widget provides only valid password via [onPasswordEntered].
class EnterPasswordWidget extends StatefulWidget {
  const EnterPasswordWidget({
    required this.onPasswordEntered,
    required this.publicKey,
    super.key,
  });

  /// Callback that will be called when user entered password.
  /// Password in this callback always valid.
  final ValueChanged<String> onPasswordEntered;

  /// Key for which password must be entered.
  final String publicKey;

  @override
  State<EnterPasswordWidget> createState() => _EnterPasswordWidgetState();
}

class _EnterPasswordWidgetState extends State<EnterPasswordWidget> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnterPasswordCubit>(
      create: (_) => EnterPasswordCubit(
        inject<BiometryService>(),
        inject<NekotonRepository>(),
        widget.publicKey,
      )..init(),
      child: BlocConsumer<EnterPasswordCubit, EnterPasswordState>(
        listener: (context, state) {
          state.whenOrNull(
            entered: (password, _, __) => widget.onPasswordEntered(password),
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            biometry: _biometryBody,
            password: _passwordBody,
            entered: (_, fromBiometry, isFaceBiometry) {
              if (fromBiometry) {
                return _biometryBody(isFaceBiometry);
              }
              return _passwordBody();
            },
          );
        },
      ),
    );
  }

  Widget _biometryBody(bool isFace) {
    return SizedBox(
      height: DimensSize.d100,
      child: Builder(
        builder: (context) {
          return Center(
            child: CommonIconWidget.svg(
              svg: isFace
                  ? Assets.images.faceId.path
                  : Assets.images.finger.path,
              size: DimensSize.d100,
              color: context.themeStyle.colors.textPrimary,
            ),
          );
        },
      ),
    );
  }

  Widget _passwordBody() {
    return Builder(
      builder: (context) {
        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          separatorSize: DimensSize.d24,
          children: [
            PasswordInput(
              controller: _passwordController,
              submit: () => context
                  .read<EnterPasswordCubit>()
                  .enterPassword(_passwordController.text),
            ),
            CommonButton.primary(
              fillWidth: true,
              text: LocaleKeys.submitWord.tr(),
              onPressed: () => context
                  .read<EnterPasswordCubit>()
                  .enterPassword(_passwordController.text),
            ),
          ],
        );
      },
    );
  }
}
