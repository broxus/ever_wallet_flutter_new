import 'package:app/generated/generated.dart';

class DateTimeUtils {
  static String formatExpirationDate(DateTime dateTime) {
    final now = DateTime.now();
    final duration = dateTime.difference(now);

    final hours = duration.inHours.toString();
    final minutes = (duration.inMinutes % 60).toString();

    final formattedDate = DateFormat('MMM d').format(dateTime);
    final formattedTime = DateFormat('HH:mm').format(dateTime);

    return LocaleKeys.expirationTimeDetails.tr(
      args: [
        hours,
        minutes,
        formattedDate,
        formattedTime,
      ],
    );
  }
}
