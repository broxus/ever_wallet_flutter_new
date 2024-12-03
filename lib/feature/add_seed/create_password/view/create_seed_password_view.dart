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
  final FocusNode _pwd1focusNode = FocusNode();
  final FocusNode _pwd2focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _pwd1focusNode.addListener(() {
      if (_pwd1focusNode.hasFocus) {
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
                    Text(
                      LocaleKeys.confirmPasswordTitle.tr(),
                      style: themeStyle.textStyles.headingLarge,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    PrimaryText(
                      LocaleKeys.confirmPasswordSubtitle.tr(),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: DimensSize.d24),
                    SecureTextField(
                      focusNode: _pwd1focusNode,
                      hintText: LocaleKeys.confirmSetPasswordHint.tr(),
                      textEditingController: widget.passwordController,
                      textInputAction: TextInputAction.next,
                      isAutofocus: true,
                      onSubmit: _onPwd1Submit,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    SecureTextField(
                      focusNode: _pwd2focusNode,
                      hintText: LocaleKeys.confirmRepeatPasswordHint.tr(),
                      textEditingController: widget.confirmController,
                      textInputAction: TextInputAction.done,
                      onSubmit: _onPwd2Submit,
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
    _pwd1focusNode.dispose();
    _pwd2focusNode.dispose();
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

  void _onPwd1Submit(String? _) =>
      FocusScope.of(context).requestFocus(_pwd2focusNode);

  void _onPwd2Submit(String? _) {
    if (widget.passwordStatus == PasswordStatus.match) {
      widget.onPressedNext();
    }
  }
}
