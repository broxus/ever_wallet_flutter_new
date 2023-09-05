import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to add some token with [details] to
/// [account].
/// Returns true, if user agreed and false otherwise.
Future<bool> showAddTip3TokenSheet({
  required BuildContext context,
  required Uri origin,
  required Address account,
  required TokenContractAsset details,
}) async {
  final res = await showCommonBottomSheet<bool>(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.addAsset.tr(),
    body: (context, scroll) => AddTip3TokenSheet(
      account: account,
      origin: origin,
      details: details,
      controller: scroll,
    ),
  );

  return res ?? false;
}

class AddTip3TokenSheet extends StatelessWidget {
  const AddTip3TokenSheet({
    required this.origin,
    required this.account,
    required this.details,
    required this.controller,
    super.key,
  });

  final Uri origin;
  final Address account;
  final TokenContractAsset details;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorSize: DimensSize.d16,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller,
            child: ShapedContainerColumn(
              margin: EdgeInsets.zero,
              children: [
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.originWord.tr(),
                  subtitleText: origin.host,
                ),
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  height: null,
                  subtitleMaxLines: null,
                  titleText: LocaleKeys.accountWord.tr(),
                  subtitleText: account.address,
                ),
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.versionWord.tr(),
                  subtitleText: details.version.toString(),
                ),
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.nameWord.tr(),
                  subtitleText: details.name,
                ),
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.symbolWord.tr(),
                  subtitleText: details.symbol,
                ),
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.decimalsWord.tr(),
                  subtitleText: details.decimals.toString(),
                ),
                if (details.ownerAddress != null)
                  CommonListTile(
                    invertTitleSubtitleStyles: true,
                    height: null,
                    subtitleMaxLines: null,
                    titleText: LocaleKeys.ownerAddress.tr(),
                    subtitleText: details.ownerAddress!.address,
                  ),
                if (details.totalSupply != null)
                  CommonListTile(
                    invertTitleSubtitleStyles: true,
                    titleText: LocaleKeys.totalSupply.tr(),
                    subtitleText: details.totalSupply,
                  ),
              ],
            ),
          ),
        ),
        SeparatedRow(
          children: [
            Expanded(
              child: CommonButton.ghost(
                fillWidth: true,
                text: LocaleKeys.rejectWord.tr(),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            Expanded(
              child: CommonButton.primary(
                fillWidth: true,
                text: LocaleKeys.submitWord.tr(),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
