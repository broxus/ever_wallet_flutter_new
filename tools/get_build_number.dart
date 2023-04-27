import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart';

const String _buildUrl = 'https://broxus.firebaseio.com/mobileApp/build.json';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    stderr.write('Usage: get_build <path_to_service_account.json>');
    exit(42);
  }

  final credentials = await getCredentials(arguments[0]);
  final client = await obtainAuthenticatedClient(credentials);
  final build = await getBuild(client);
  // ignore: avoid_print
  print(build);

  client.close();

  exit(0);
}

Future<Map<String, dynamic>> getCredentials(String filename) async {
  final credentials = await File(filename).readAsString();
  return jsonDecode(credentials) as Map<String, dynamic>;
}

Future<AuthClient> obtainAuthenticatedClient(Map<String, dynamic> json) async {
  final accountCredentials = ServiceAccountCredentials.fromJson(json);
  final scopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/firebase.database',
  ];

  return clientViaServiceAccount(accountCredentials, scopes);
}

Future<int> getBuild(AuthClient client, {int retryCount = 3}) async {
  final getResponse = await client.get(
    Uri.parse(_buildUrl),
    headers: {
      'X-Firebase-ETag': 'true',
    },
  );

  if (getResponse.statusCode != 200) {
    stderr.write('GET error: ${getResponse.statusCode} ${getResponse.body}');
    exit(43);
  }

  final oldVersion = jsonDecode(getResponse.body) as int? ?? 0;
  final newVersion = oldVersion + 1;
  final etag = getResponse.headers['etag'] ?? '';

  final putResponse = await client.put(
    Uri.parse(_buildUrl),
    body: '$newVersion',
    headers: {
      'if-match': etag,
    },
  );

  if (putResponse.statusCode == 412) {
    stderr.write('Transactin failed due to concurrency, retrying...');
    if (retryCount > 0) {
      return getBuild(client, retryCount: retryCount - 1);
    } else {
      stderr.write('Transaction failed due to concurrency, no more retries');
      exit(44);
    }
  }

  if (putResponse.statusCode != 200) {
    stderr.write('PUT error: ${putResponse.statusCode} ${putResponse.body}');
    exit(43);
  }

  return newVersion;
}
