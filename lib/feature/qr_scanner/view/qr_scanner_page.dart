import 'package:app/di/di.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function, that opens qr page in root navigator and returns string
/// that qr was able to scan.
/// [type] - will be used to validate scanned data.
Future<String?> showQrScanner(
  BuildContext context,
  QrScanType type,
) async {
  return Navigator.of(context, rootNavigator: true).push<String>(
    MaterialPageRoute(builder: (_) => QrScannerPage(type: type)),
  );
}

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({
    required this.type,
    super.key,
  });

  final QrScanType type;

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      body: BlocProvider<QrCubit>(
        create: (_) => QrCubit(
          lifecycleService: inject(),
          permissionsService: inject(),
          type: widget.type,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocConsumer<QrCubit, QrCubitState>(
                listener: (context, state) {
                  state.whenOrNull(
                    scanning: (controller, data) {
                      if (data != null) Navigator.of(context).pop(data);
                    },
                  );
                },
                builder: (context, state) {
                  return state.when(
                    loading: () => const CommonCircularProgressIndicator(
                      size: CircularIndicatorSize.large,
                    ),
                    givePermissionsError: _permissionsErrorBody,
                    scanning: (controller, _) => MobileScanner(
                      controller: controller,
                      onDetect: context.read<QrCubit>().analyzeBarcodes,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: DefaultAppBar(
                backgroundColor: Colors.transparent,
                onClosePressed: (context) => Navigator.of(context).pop(),
                titleWidget: Text(
                  LocaleKeys.scanQrCode.tr(),
                  style: StyleRes.button.copyWith(color: colors.textContrast),
                ),
              ),
            ),
            Positioned(
              left: DimensSize.d16,
              right: DimensSize.d16,
              bottom: DimensSize.d24,
              child: Builder(
                builder: (context) {
                  return CommonButton(
                    buttonType: EverButtonType.ghost,
                    textAlign: TextAlign.center,
                    text: LocaleKeys.uploadPhotoFromGallery.tr(),
                    contentColor: colors.textContrast,
                    onPressed: context.read<QrCubit>().tryScanPhoto,
                    leading: CommonButtonIconWidget.svg(
                      svg: Assets.images.camera.path,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _permissionsErrorBody() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return Center(
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separatorSize: DimensSize.d16,
            children: [
              Text(
                LocaleKeys.needCameraPermissions.tr(),
                style: StyleRes.primaryRegular.copyWith(
                  color: colors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              CommonButton.primary(
                fillWidth: true,
                text: LocaleKeys.givePermissions.tr(),
                onPressed: () => context
                    .read<QrCubit>()
                    .openSettings(SettingsOpenType.camera),
              ),
            ],
          ),
        );
      },
    );
  }
}
