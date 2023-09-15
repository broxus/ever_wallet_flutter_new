import 'package:app/di/di.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function, that opens qr page in root navigator and returns string
/// that qr was able to scan.
Future<String?> showQrScanner(BuildContext context) async {
  return Navigator.of(context, rootNavigator: true).push<String>(
    MaterialPageRoute(builder: (_) => const QrScannerPage()),
  );
}

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        backgroundColor: Colors.transparent,
        onClosePressed: (context) => Navigator.of(context).pop(),
        titleText: LocaleKeys.scanQrCode.tr(),
      ),
      body: BlocProvider<QrCubit>(
        create: (_) => QrCubit(inject()),
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocBuilder<QrCubit, QrCubitState>(
                builder: (context, state) {
                  return state.when(
                    loading: () => const CommonCircularProgressIndicator(
                      size: CircularIndicatorSize.large,
                    ),
                    givePermissionsError: _permissionsErrorBody,
                    scanning: (controller) => MobileScanner(
                      controller: controller,
                      // ignore: prefer-extracting-callbacks
                      onDetect: (barcodes) {
                        final codes = barcodes.barcodes;
                        if (codes.isNotEmpty && codes.first.rawValue != null) {
                          Navigator.of(context).pop(codes.first.rawValue);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: DimensSize.d16,
              right: DimensSize.d16,
              bottom: DimensSize.d24,
              child: Builder(
                builder: (context) {
                  return CommonButton.ghost(
                    text: LocaleKeys.uploadPhotoFromGallery.tr(),
                    fillWidth: true,
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
                onPressed: context.read<QrCubit>().openSettings,
              ),
            ],
          ),
        );
      },
    );
  }
}
