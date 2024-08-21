import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _defaultContainerSize = 3;

/// Page with all colors
class CommonStory extends StatefulWidget {
  const CommonStory({super.key});

  @override
  State<CommonStory> createState() => _CommonStoryState();
}

class _CommonStoryState extends State<CommonStory> {
  late final tabSwitcherNotifier1 = ValueNotifier<int>(
    tabSwitcherValues.first.value,
  );
  late final tabSwitcherNotifier2 = ValueNotifier<int>(
    tabSwitcherValues.first.value,
  );
  final tabSwitcherValues = [
    CommonTabSwitcherItem(title: 'One', value: 1),
    CommonTabSwitcherItem(title: 'Two', value: 2),
    CommonTabSwitcherItem(title: 'Three', value: 3),
  ];

  final currencyDecimal = 2;
  late final money = Money.fromBigIntWithCurrency(
    BigInt.parse('4004299'),
    Currency.create(
      'USD',
      currencyDecimal,
      pattern: '0.${'#' * currencyDecimal}',
      symbol: 'USD',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'CommonWidgets'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            DefaultAppBar(
              leading: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.backgroundPrimary,
                ),
                child: Icon(Icons.ac_unit, color: colors.textContrast),
              ),
              titleText: 'Center title',
              subtitleTopText: 'TopSubtitle',
              subtitleBottomText: 'BottomSubtitle',
              actions: [
                CommonButton(
                  height: appBarButtonSize,
                  fillWidth: false,
                  buttonType: EverButtonType.ghost,
                  text: 'Action',
                  // ignore: no-empty-block
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            DefaultAppBar(
              leading: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.backgroundPrimary,
                ),
                child: Icon(Icons.ac_unit, color: colors.textContrast),
              ),
              centerTitle: false,
              titleText: 'Not centered title',
              subtitleTopText: 'TopSubtitle',
              subtitleBottomWidget: CommonButton(
                height: DimensSize.d20,
                padding: EdgeInsets.zero,
                buttonType: EverButtonType.ghost,
                fillWidth: false,
                text: 'SubtitleBottom button',
                // ignore: no-empty-block
                onPressed: () {},
              ),
              actions: [
                CommonButton(
                  height: appBarButtonSize,
                  fillWidth: false,
                  buttonType: EverButtonType.ghost,
                  text: 'Action',
                  // ignore: no-empty-block
                  onPressed: () {},
                ),
                CommonIconButton.icon(
                  icon: Icons.access_alarm_sharp,
                  buttonType: EverButtonType.primary,
                  size: CommonIconButtonSize.small,
                  // ignore: no-empty-block
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: DimensSize.d28),
            CommonCard(
              titleText: 'Card Title',
              leadingText: 'leading',
              trailingChild: CommonButtonIconWidget.icon(icon: Icons.delete),
            ),
            const SizedBox(height: DimensSize.d8),
            CommonCard(
              titleText: 'Card Title',
              leadingChild:
                  CommonButtonIconWidget.icon(icon: Icons.access_alarm_sharp),
              borderColor: colors.alert,
              trailingChild: CommonButtonIconWidget.icon(icon: Icons.delete),
            ),
            const SizedBox(height: DimensSize.d8),
            const Row(
              children: [
                Expanded(child: CommonCard(titleText: 'Card fill width')),
              ],
            ),
            const SizedBox(height: DimensSize.d8),
            CommonCard(
              titleText: 'Card Title',
              topSubtitleText: 'TopSubtitle',
              leadingChild:
                  CommonButtonIconWidget.icon(icon: Icons.access_alarm_sharp),
              trailingChild: CommonButtonIconWidget.icon(icon: Icons.delete),
            ),
            const SizedBox(height: DimensSize.d32),
            CommonListTile(
              // ignore: no-empty-block
              onPressed: () {},
              leading: CommonBackgroundedIconWidget.icon(icon: Icons.add),
              titleText: 'ListTile tite',
              subtitleText: 'ListTile subtitle',
              trailing:
                  CommonIconWidget.icon(icon: Icons.arrow_forward_ios_rounded),
            ),
            const SizedBox(height: DimensSize.d8),
            CommonListTile(
              // ignore: no-empty-block
              onPressed: () {},
              backgroundColor: colors.backgroundSecondary,
              leading: CommonBackgroundedIconWidget.icon(icon: Icons.add),
              titleText: 'ListTile tite with color',
              subtitleText: 'ListTile subtitle',
              trailing:
                  CommonIconWidget.icon(icon: Icons.arrow_forward_ios_rounded),
            ),
            const SizedBox(height: DimensSize.d8),
            const Text('Icon with background'),
            const SizedBox(height: DimensSize.d4),
            SeparatedRow(
              children: [
                CommonBackgroundedIconWidget.icon(icon: Icons.add),
                CommonBackgroundedIconWidget.icon(
                  icon: Icons.add,
                  backgroundColor: colors.alert,
                  iconColor: colors.textPrimary,
                ),
              ],
            ),
            const SizedBox(height: DimensSize.d24),

            // containers
            Text('DIFFERENT CONTAINERS', style: StyleRes.h2),
            const SizedBox(height: DimensSize.d8),
            ShapedContainerColumn(
              titleText: 'ShapedContainerColumn',
              children: List.generate(
                _defaultContainerSize,
                (index) => CommonListTile(titleText: 'Item $index'),
              ),
            ),
            const SizedBox(height: DimensSize.d8),
            ShapedContainerColumn(
              titleText: 'ShapedContainerColumn',
              children: List.generate(
                _defaultContainerSize,
                (index) => Text('Item $index'),
              ),
            ),
            const SizedBox(height: DimensSize.d8),
            ShapedContainerColumn(
              separator: const CommonDivider(),
              children: List.generate(
                _defaultContainerSize,
                (index) => CommonListTile(titleText: 'Item $index'),
              ),
            ),
            const SizedBox(height: DimensSize.d8),
            ShapedContainerRow(
              titleText: 'ShapedContainerRow',
              children: List.generate(
                _defaultContainerSize,
                (index) => Text('Item $index'),
              ),
            ),
            const SizedBox(height: DimensSize.d8),
            ShapedContainerRow(
              children: List.generate(
                _defaultContainerSize,
                (index) => Expanded(child: Text('Item $index')),
              ),
            ),
            const SizedBox(height: DimensSize.d20),
            Container(
              color: colors.backgroundPrimary,
              height: DimensSize.d64,
              alignment: Alignment.center,
              child: ValueListenableBuilder<int>(
                valueListenable: tabSwitcherNotifier1,
                builder: (_, value, __) {
                  return IntrinsicHeight(
                    child: CommonTabSwitcher(
                      onTabChanged: (v) => tabSwitcherNotifier1.value = v,
                      values: tabSwitcherValues,
                      currentValue: value,
                    ),
                  );
                },
              ),
            ),
            Container(
              color: colors.backgroundPrimary,
              height: DimensSize.d64,
              alignment: Alignment.center,
              child: ValueListenableBuilder<int>(
                valueListenable: tabSwitcherNotifier2,
                builder: (_, value, __) {
                  return IntrinsicHeight(
                    child: CommonTabSwitcher(
                      fillWidth: false,
                      onTabChanged: (v) => tabSwitcherNotifier2.value = v,
                      values: tabSwitcherValues,
                      currentValue: value,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: DimensSize.d16),
            MoneyWidget(money: money, style: MoneyWidgetStyle.big),
            const SizedBox(height: DimensSize.d8),
            MoneyWidget(money: money, style: MoneyWidgetStyle.primary),
            const SizedBox(height: DimensSize.d8),
            MoneyWidget(money: money, style: MoneyWidgetStyle.secondary),

            const SizedBox(height: DimensSize.d16),
            SeparatedRow(
              children: const [
                CommonCircularProgressIndicator(
                  size: CircularIndicatorSize.small,
                ),
                CommonCircularProgressIndicator(),
                CommonCircularProgressIndicator(
                  size: CircularIndicatorSize.large,
                ),
              ],
            ),

            const SizedBox(height: DimensSize.d32),
          ],
        ),
      ),
    );
  }
}
