import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

const _minPasswordLength = 8;

/// Helper method that shows the [ChangeSeedPasswordSheet] bottom sheet.
ModalRoute<void> changeSeedPasswordSheetRoute(
  BuildContext context,
  PublicKey publicKey,
) {
  return commonBottomSheetRoute<void>(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.changeSeedPassword.tr(),
    body: (_, __) => BlocProvider<ChangeSeedPasswordCubit>(
      create: (_) => ChangeSeedPasswordCubit(
        inject<NekotonRepository>(),
        publicKey,
        inject<BiometryService>(),
      ),
      child: const ChangeSeedPasswordSheet(),
    ),
  );
}

/// Sheet that allows user to change password of seed phrase
class ChangeSeedPasswordSheet extends StatefulWidget {
  const ChangeSeedPasswordSheet({super.key});

  @override
  State<ChangeSeedPasswordSheet> createState() =>
      _ChangeSeedPasswordSheetState();
}

class _ChangeSeedPasswordSheetState extends State<ChangeSeedPasswordSheet> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeSeedPasswordCubit, ChangeSeedPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (errorCode) => inject<MessengerService>().show(
            Message.error(context: context, message: errorCode.tr()),
          ),
          completed: () {
            Navigator.of(context).pop();
            inject<MessengerService>().show(
              Message.successful(
                context: context,
                message: LocaleKeys.passwordChanged.tr(),
              ),
            );
          },
        );
      },
      builder: (context, snapshot) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              separatorSize: DimensSize.d24,
              children: [
                SecureTextField(
                  textEditingController: _oldPasswordController,
                  validator: _inputValidator,
                  onSubmit: (_) => _newPasswordFocus.requestFocus(),
                  hintText: LocaleKeys.yourPassword.tr(),
                ),
                SecureTextField(
                  textEditingController: _newPasswordController,
                  focusNode: _newPasswordFocus,
                  validator: _inputValidator,
                  hintText: LocaleKeys.newPassword.tr(),
                  onSubmit: (_) => _changePassword(context),
                ),
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.changeWord.tr(),
                  onPressed: () => _changePassword(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _changePassword(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    context.read<ChangeSeedPasswordCubit>().changePassword(
          oldPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text,
        );
  }

  String? _inputValidator(String? password) {
    if (password == null || password.length < _minPasswordLength) {
      return LocaleKeys.passwordLength.tr();
    }

    return null;
  }
}
