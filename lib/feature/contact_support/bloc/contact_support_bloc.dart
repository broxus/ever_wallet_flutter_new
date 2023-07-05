import 'package:app/app/service/messenger/messenger.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'contact_support_event.dart';
part 'contact_support_state.dart';
part 'contact_support_bloc.freezed.dart';

class ContactSupportBloc
    extends Bloc<ContactSupportEvent, ContactSupportState> {
  ContactSupportBloc() : super(const _Initial()) {
    on<ContactSupportEvent>((event, emit) async {
      await event.map(
        sendEmail: (event) async {
          emit(const ContactSupportState.busy());
          try {
            await contactSupportEmailSend(event.mode);
          } catch (e, s) {
            _log.severe(e, null, s);
            emit(const ContactSupportState.initial());
            inject<MessengerService>().show(
              Message.error(
                message: LocaleKeys.contactSupportCantFindEmailClient.tr(),
              ),
            );
          }
          emit(const ContactSupportState.initial());
        },
      );
    });
  }
  final _log = Logger('ContactSupportBloc');
}
