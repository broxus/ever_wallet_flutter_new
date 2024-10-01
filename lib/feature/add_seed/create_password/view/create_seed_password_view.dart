import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/widgets/password_info_section.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class CreateSeedPasswordView extends StatefulWidget {
  const CreateSeedPasswordView({
    required this.needBiometryIfPossible,
    required this.passwordController,
    required this.confirmController,
    required this.onPressedNext,
    required this.isLoading,
    this.passwordStatus,
    super.key,
  });

  /// If true, then biometry will be requested if possible
  final bool needBiometryIfPossible;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final VoidCallback onPressedNext;
  final PasswordStatus? passwordStatus;
  final bool isLoading;

  @override
  State<CreateSeedPasswordView> createState() => _CreateSeedPasswordViewState();
}

class _CreateSeedPasswordViewState extends State<CreateSeedPasswordView> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        LocaleKeys.confirmPasswordTitle.tr(),
                        style: themeStyle.textStyles.headingLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: DimensSize.d8),
                    PrimaryText(LocaleKeys.confirmPasswordSubtitle.tr()),
                    const SizedBox(height: DimensSize.d24),
                    SecureTextField(
                      focusNode: _focusNode,
                      hintText: LocaleKeys.confirmSetPasswordHint.tr(),
                      textEditingController: widget.passwordController,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    SecureTextField(
                      hintText: LocaleKeys.confirmRepeatPasswordHint.tr(),
                      textEditingController: widget.confirmController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: DimensSize.d24),
                    PasswordInfoSection(
                      themeStyle: themeStyle,
                      status: widget.passwordStatus ?? PasswordStatus.initial,
                    ),
                    const SizedBox(height: DimensSize.d12),
                  ],
                ),
              ),
            ),
            AccentButton(
              title: LocaleKeys.continueWord.tr(),
              onPressed: widget.passwordStatus == PasswordStatus.match
                  ? widget.onPressedNext
                  : null,
              isLoading: widget.isLoading,
              buttonShape: ButtonShape.pill,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FocusScope.of(context).hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }
}
