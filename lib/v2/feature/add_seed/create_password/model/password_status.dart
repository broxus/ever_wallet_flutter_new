import 'package:app/generated/assets.gen.dart';

enum PasswordStatus { initial, tooWeak, mustMatch, match }

extension PasswordStatusExtension on PasswordStatus {
  String? getTitleByStatus() {
    switch (this) {
      case PasswordStatus.initial:
        return null;
      case PasswordStatus.tooWeak:
        return 'Password too weak';
      case PasswordStatus.mustMatch:
        return 'Passwords must match';
      case PasswordStatus.match:
        return 'Passwords match';
    }
  }

  String getSubtitleByStatus() {
    switch (this) {
      case PasswordStatus.initial:
      case PasswordStatus.tooWeak:
        return 'Password should contain at least 8 characters. Please update your password.';
      case PasswordStatus.mustMatch:
        return 'To continue, re-enter your password exactly as before.';
      case PasswordStatus.match:
        return 'In order to continue, re-enter your password exactly the same as before';
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
