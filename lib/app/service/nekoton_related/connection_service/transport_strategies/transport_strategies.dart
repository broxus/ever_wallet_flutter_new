import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:app/http/http.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'custom_transport_strategy.dart';
part 'ever_transport_strategy.dart';
part 'ton_transport_strategy.dart';
part 'tycho_transport_strategy.dart';
part 'venom_transport_strategy.dart';

sealed class AppTransportStrategy extends TransportStrategy {}
