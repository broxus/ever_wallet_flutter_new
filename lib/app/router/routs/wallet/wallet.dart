import 'dart:convert';

import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/add_seed_enable_biometry/add_seed_enable_biometry.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const selectNewAssetAddressPathParam = 'selectNewAssetAddress';
const tonWalletDetailsAddressPathParam = 'tonWalletDetailsAddress';
const tokenWalletDetailsOwnerAddressPathParam = 'tonWalletDetailsOwnerAddress';
const tokenWalletDetailsContractAddressPathParam =
    'tonWalletDetailsContractAddress';
const walletPrepareTransferAddressPathParam = 'walletPrepareAddress';
const walletPrepareTransferRootTokenAddressPathParam =
    'walletPrepareRootTokenAddress';

const tonWalletSendAddressQueryParam = 'tonWalletSendAddress';
const tonWalletSendPublicKeyQueryParam = 'tonWalletSendPublicKey';
const tonWalletSendCommentQueryParam = 'tonWalletSendComment';
const tonWalletSendDestinationQueryParam = 'tonWalletSendDestination';
const tonWalletSendAmountQueryParam = 'tonWalletSendAmount';

const tokenWalletSendOwnerQueryParam = 'tokenWalletSendOwner';
const tokenWalletSendContractQueryParam = 'tokenWalletSendContract';
const tokenWalletSendPublicKeyQueryParam = 'tokenWalletSendPublicKey';
const tokenWalletSendCommentQueryParam = 'tokenWalletSendComment';
const tokenWalletSendDestinationQueryParam = 'tokenWalletSendDestination';
const tokenWalletSendAmountQueryParam = 'tokenWalletSendAmount';
const tokenWalletSendAttachedAmountQueryParam = 'tokenWalletSendAttachedAmount';

const walletDeployAddressPathParam = 'walletDeployAddress';
const walletDeployPublicKeyPathParam = 'walletDeployPublicKey';

const tonWalletConfirmTransactionWalletAddressQueryParam =
    'tonWalletConfirmTransactionAddress';
const tonWalletConfirmTransactionLocalCustodiansQueryParam =
    'tonWalletConfirmTransactionLocalCustodians';
const tonWalletConfirmTransactionTransactionIdQueryParam =
    'tonWalletConfirmTransactionTransactionId';
const tonWalletConfirmTransactionDestinationQueryParam =
    'tonWalletConfirmTransactionDestination';
const tonWalletConfirmTransactionAmountQueryParam =
    'tonWalletConfirmTransactionAmount';
const tonWalletConfirmTransactionCommentQueryParam =
    'tonWalletConfirmTransactionComment';

const networkConnectionDataIdQueryParam = 'connectionDataId';

/// Branch that is root for wallet.
StatefulShellBranch get walletBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.wallet.name,
        path: AppRoute.wallet.path,
        builder: (context, state) => const WalletPage(),
        routes: [
          GoRoute(
            path: AppRoute.enableBiometryAfterOnboarding.path,
            builder: (_, __) => const AddSeedEnableBiometryPage(),
          ),
          GoRoute(
            path: AppRoute.selectNewAsset.path,
            builder: (_, state) => SelectNewAssetPage(
              address: Address(
                address: state.pathParameters[selectNewAssetAddressPathParam]!,
              ),
            ),
          ),
          addSeedNamedRoute,
          tonWalletDetailsRoute,
          tokenWalletDetailsRoute,
          walletPrepareTransferRoute,
          walletDeployRoute,
          tonConfirmTranscationRoute,
          configureNetworksRoute,
        ],
      ),
    ],
  );
}

GoRoute get tonWalletDetailsRoute {
  return GoRoute(
    path: AppRoute.tonWalletDetails.path,
    builder: (_, state) => TonWalletDetailsPage(
      address: Address(
        address: state.pathParameters[tonWalletDetailsAddressPathParam]!,
      ),
    ),
    routes: [
      walletPrepareTransferLockedRoute,
      tonConfirmTranscationRoute,
    ],
  );
}

GoRoute get tokenWalletDetailsRoute {
  return GoRoute(
    path: AppRoute.tokenWalletDetails.path,
    builder: (_, state) => TokenWalletDetailsPage(
      owner: Address(
        address: state.pathParameters[tokenWalletDetailsOwnerAddressPathParam]!,
      ),
      rootTokenContract: Address(
        address:
            state.pathParameters[tokenWalletDetailsContractAddressPathParam]!,
      ),
    ),
    routes: [
      walletPrepareTransferLockedRoute,
    ],
  );
}

/// Prepare transfer with selecting token
GoRoute get walletPrepareTransferRoute {
  return GoRoute(
    path: AppRoute.walletPrepareTransfer.path,
    builder: (_, state) => WalletPrepareTransferPage(
      address: Address(
        address: state.pathParameters[walletPrepareTransferAddressPathParam]!,
      ),
    ),
    routes: [
      tonWalletSendRoute,
      tokenWalletSendRoute,
    ],
  );
}

/// Prepare transfer with specified token
GoRoute get walletPrepareTransferLockedRoute {
  return GoRoute(
    path: AppRoute.walletPrepareTransferSpecified.path,
    builder: (_, state) => WalletPrepareTransferPage(
      address: Address(
        address: state.pathParameters[walletPrepareTransferAddressPathParam]!,
      ),
      rootTokenContract: Address(
        address: state
            .pathParameters[walletPrepareTransferRootTokenAddressPathParam]!,
      ),
    ),
    routes: [
      tonWalletSendRoute,
      tokenWalletSendRoute,
    ],
  );
}

/// Send native token from TonWallet
GoRoute get tonWalletSendRoute {
  return GoRoute(
    path: AppRoute.tonWalletSend.path,
    builder: (context, state) {
      return TonWalletSendPage(
        address: Address(
          address: state.uri.queryParameters[tonWalletSendAddressQueryParam]!,
        ),
        publicKey: PublicKey(
          publicKey:
              state.uri.queryParameters[tonWalletSendPublicKeyQueryParam]!,
        ),
        destination: Address(
          address:
              state.uri.queryParameters[tonWalletSendDestinationQueryParam]!,
        ),
        amount: BigInt.parse(
          state.uri.queryParameters[tonWalletSendAmountQueryParam]!,
        ),
        comment: state.uri.queryParameters[tonWalletSendCommentQueryParam],
      );
    },
  );
}

/// Send not native tokens
GoRoute get tokenWalletSendRoute {
  return GoRoute(
    path: AppRoute.tokenWalletSend.path,
    builder: (context, state) {
      return TokenWalletSendPage(
        owner: Address(
          address: state.uri.queryParameters[tokenWalletSendOwnerQueryParam]!,
        ),
        rootTokenContract: Address(
          address:
              state.uri.queryParameters[tokenWalletSendContractQueryParam]!,
        ),
        publicKey: PublicKey(
          publicKey:
              state.uri.queryParameters[tokenWalletSendPublicKeyQueryParam]!,
        ),
        destination: Address(
          address:
              state.uri.queryParameters[tokenWalletSendDestinationQueryParam]!,
        ),
        attachedAmount: BigInt.tryParse(
          state.uri.queryParameters[tokenWalletSendAttachedAmountQueryParam] ??
              '',
        ),
        amount: BigInt.parse(
          state.uri.queryParameters[tokenWalletSendAmountQueryParam]!,
        ),
        comment: state.uri.queryParameters[tokenWalletSendCommentQueryParam],
      );
    },
  );
}

/// Deploy account to blockchain
GoRoute get walletDeployRoute {
  return GoRoute(
    path: AppRoute.walletDeploy.path,
    builder: (context, state) {
      return WalletDeployPage(
        address: Address(
          address: state.pathParameters[walletDeployAddressPathParam]!,
        ),
        publicKey: PublicKey(
          publicKey: state.pathParameters[walletDeployPublicKeyPathParam]!,
        ),
      );
    },
  );
}

/// Confirm multisig transaction for TonWallet
GoRoute get tonConfirmTranscationRoute {
  return GoRoute(
    path: AppRoute.tonConfirmTransaction.path,
    builder: (context, state) {
      final decoded = (jsonDecode(
        state.uri.queryParameters[
            tonWalletConfirmTransactionLocalCustodiansQueryParam]!,
      ) as List<dynamic>)
          .cast<String>();

      return TonConfirmTransactionPage(
        walletAddress: Address(
          address: state.uri.queryParameters[
              tonWalletConfirmTransactionWalletAddressQueryParam]!,
        ),
        localCustodians: decoded.map((e) => PublicKey(publicKey: e)).toList(),
        transactionId: state.uri.queryParameters[
            tonWalletConfirmTransactionTransactionIdQueryParam]!,
        destination: Address(
          address: state.uri.queryParameters[
              tonWalletConfirmTransactionDestinationQueryParam]!,
        ),
        amount: BigInt.parse(
          state.uri
              .queryParameters[tonWalletConfirmTransactionAmountQueryParam]!,
        ),
        comment: state
            .uri.queryParameters[tonWalletConfirmTransactionCommentQueryParam],
      );
    },
  );
}

/// Configure networks
GoRoute get configureNetworksRoute {
  return GoRoute(
    path: AppRoute.configureNetworks.path,
    builder: (_, __) => const ConfigureNetworksPage(),
    routes: [
      GoRoute(
        path: AppRoute.editNetwork.path,
        builder: (_, state) => EditNetworkPage(
          connectionDataId:
              state.uri.queryParameters[networkConnectionDataIdQueryParam],
        ),
      ),
    ],
  );
}
