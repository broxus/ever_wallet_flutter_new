import 'package:app/generated/generated.dart';

enum PasswordStatus { initial, tooWeak, mustMatch, match }

extension PasswordStatusExtension on PasswordStatus {
  String? get titleByStatus {
    switch (this) {
      case PasswordStatus.initial:
        return null;
      case PasswordStatus.tooWeak:
        return LocaleKeys.confirmWeakPasswordTitle.tr();
      case PasswordStatus.mustMatch:
        return LocaleKeys.confirmMustMatchTitle.tr();
      case PasswordStatus.match:
        return LocaleKeys.confirmPasswordsMatchTitle.tr();
    }
  }

  String get subtitleByStatus {
    switch (this) {
      case PasswordStatus.initial:
      case PasswordStatus.tooWeak:
        return LocaleKeys.confirmWeakPasswordSubtitle.tr();
      case PasswordStatus.mustMatch:
        return LocaleKeys.confirmMustMatchSubtitle.tr();
      case PasswordStatus.match:
        return LocaleKeys.confirmPasswordsMatchSubtitle.tr();
    }
  }

  String? getSvgIconByStatus() {
    switch (this) {
      case PasswordStatus.initial:
        return null;
      case PasswordStatus.tooWeak:
        return Assets.images.icTooWeak.path;
      case PasswordStatus.mustMatch:
        return Assets.images.icNotMatch.path;
      case PasswordStatus.match:
        return Assets.images.icMatch.path;
    }
  }
}
