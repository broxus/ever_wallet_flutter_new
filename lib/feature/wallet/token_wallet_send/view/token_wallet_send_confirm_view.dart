import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// View that allows confirm send token transaction by entering password
class TokenWalletSendConfirmView extends StatelessWidget {
  const TokenWalletSendConfirmView({
    required this.recipient,
    required this.amount,
    required this.comment,
    required this.publicKey,
    this.fee,
    this.feeError,
    this.attachedAmount,
    super.key,
  });

  final Address recipient;
  final BigInt amount;
  final BigInt? attachedAmount;
  final BigInt? fee;
  final String? comment;
  final String? feeError;
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TokenWalletSendBloc>();
    final isLoading = fee == null && feeError == null;
    final amountMoney = Money.fromBigIntWithCurrency(
      amount,
      bloc.tokenCurrency,
    );

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              separatorSize: DimensSize.d16,
              children: [
                if (bloc.account != null) AccountInfo(account: bloc.account!),
                TokenTransferInfoWidget(
                  amount: amountMoney,
                  recipient: recipient,
                  fee: fee,
                  feeError: feeError,
                  attachedAmount: attachedAmount,
                  comment: comment,
                  rootTokenContract: bloc.rootTokenContract,
                ),
              ],
            ),
          ),
        ),
        EnterPasswordWidgetV2(
          publicKey: publicKey,
          title: LocaleKeys.confirmTransaction.tr(),
          isLoading: isLoading,
          onPasswordEntered: (pwd) => bloc.add(TokenWalletSendEvent.send(pwd)),
        ),
        const SizedBox(height: DimensSize.d16),
      ],
    );
  }
}
