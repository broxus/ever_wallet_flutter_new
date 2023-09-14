import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Button that allows to select network from wallet screen
class NetworkSelectionCard extends StatefulWidget {
  const NetworkSelectionCard({super.key});

  @override
  State<NetworkSelectionCard> createState() => _NetworkSelectionCardState();
}

class _NetworkSelectionCardState extends State<NetworkSelectionCard> {
  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return BlocProvider(
      create: (context) => ManageNetworksBloc(
        inject<ConnectionsStorageService>(),
      ),
      child: PressScaleWidget(
        // ignore: no-empty-block
        onPressed: () {
          showSelectNetworkSheet(context: context);
        },
        child: BlocBuilder<ManageNetworksBloc, ManageNetworksState>(
          builder: (context, state) {
            final currentConnection =
                context.watch<ManageNetworksBloc>().currentConnection;

            return CommonCard(
              padding: EdgeInsets.zero,
              leadingChild: Container(
                padding: const EdgeInsets.all(DimensSize.d12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.backgroundSecondary,
                ),
                child: CommonIconWidget.svg(
                  avoidContentColor: true,
                  svg: Assets.images.sparxLogoSmall.path,
                ),
              ),
              width: null,
              backgroundColor: Colors.transparent,
              topSubtitleText: LocaleKeys.networkWord.tr(),
              titleChild: SeparatedRow(
                separatorSize: DimensSize.d4,
                children: [
                  Flexible(
                    child: Text(
                      currentConnection.name,
                      style:
                          StyleRes.button.copyWith(color: colors.textPrimary),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                  CommonIconWidget.svg(
                    svg: Assets.images.caretDown.path,
                    color: colors.textSecondary,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
