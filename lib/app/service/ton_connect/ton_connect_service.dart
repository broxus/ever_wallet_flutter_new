import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class TonConnectService {
  final _bridgeUrl = 'https://bridge.tonapi.io/bridge';

  void connect(List<String> clientIds) {
    final client = http.Client();
    final request = http.Request(
      'GET',
      Uri.parse('$_bridgeUrl/events?client_id=${clientIds.join(',')}'),
    )..headers['Accept'] = 'text/event-stream';

    client.send(request).then((response) {
      response.stream.listen((event) {
        response.stream.transform(EventSourceTransformer()).listen((event) {
          print(event);
        });
      });
    });
  }

  String _getLastEventId() => throw UnimplementedError();

  String _saveLastEventId() => throw UnimplementedError();
}

class EventSourceTransformer implements StreamTransformer<List<int>, SseEvent> {
  @override
  Stream<SseEvent> bind(Stream<List<int>> stream) {
    late StreamController<SseEvent> controller;
    controller = StreamController(
      onListen: () {
        // the event we are currently building
        var currentEvent = SseEvent();
        // the regexes we will use later
        final lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');
        final removeEndingNewlineRegex = RegExp(r'^((?:.|\n)*)\n$');
        // This stream will receive chunks of data that is not necessarily a
        // single event. So we build events on the fly and broadcast the event as
        // soon as we encounter a double newline, then we start a new one.
        stream
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .listen((String line) {
          if (line.isEmpty) {
            // event is done
            // strip ending newline from data
            if (currentEvent.data != null) {
              final match =
                  removeEndingNewlineRegex.firstMatch(currentEvent.data!)!;
              currentEvent.data = match.group(1);
            }
            controller.add(currentEvent);
            currentEvent = SseEvent();
            return;
          }
          // match the line prefix and the value using the regex
          final match = lineRegex.firstMatch(line)!;
          final field = match.group(1)!;
          final value = match.group(2) ?? '';

          if (field.isEmpty) {
            // lines starting with a colon are to be ignored
            return;
          }

          switch (field) {
            case 'event':
              currentEvent.event = value;
              break;
            case 'data':
              currentEvent.data = '${currentEvent.data ?? ''}$value\n';
              break;
            case 'id':
              currentEvent.id = value;
              break;
          }
        });
      },
    );
    return controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() =>
      StreamTransformer.castFrom<List<int>, SseEvent, RS, RT>(this);
}

class SseEvent implements Comparable<SseEvent> {
  SseEvent({
    this.id,
    this.event,
    this.data,
  });

  SseEvent.message({this.id, this.data}) : event = 'message';

  /// An identifier that can be used to allow a client to replay
  /// missed Events by returning the Last-Event-Id header.
  /// Return empty string if not required.
  String? id;

  /// The name of the event. Return empty string if not required.
  String? event;

  /// The payload of the event.
  String? data;

  @override
  int compareTo(SseEvent other) => id!.compareTo(other.id!);
}
