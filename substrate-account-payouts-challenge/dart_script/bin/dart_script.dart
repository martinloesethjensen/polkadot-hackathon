import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/// KSM Precision [kusama guide](https://guide.kusama.network/docs/en/kusama-parameters#precision)
const ksmPrecision = 1000000000000;

void main(List<String> args) async {
  var parser = ArgParser();
  var authorId;
  var depth;

  parser.addOption('author-id', abbr: 'a', defaultsTo: 'none');
  parser.addOption('depth', abbr: 'd', defaultsTo: '1');

  var results = parser.parse(args);

  /// Do http request to get latest block response if [author-id] was not set as argument.
  /// Else set [authorId] with [author-id] argument.
  if (!results.wasParsed('author-id')) {
    final latestBlockResponse =
        await getRequest('http://127.0.0.1:8080/blocks/head');

    /// Early return if latestBlockResponse is null
    if (latestBlockResponse == null) return;

    authorId = latestBlockResponse['authorId'];
  } else {
    authorId = results['author-id'];
  }

  print('Author ID: $authorId');

  depth = int.tryParse(results['depth']);

  print('Depth: $depth');

  var payoutInfoResponse = await getRequest(
      'http://127.0.0.1:8080/accounts/$authorId/staking-payouts?depth=${depth ?? 1}');

  /// Early return if payoutInfoResponse is null
  if (payoutInfoResponse == null) return;

  var total = calculatePendingPayouts(payoutInfoResponse);
  print('Total pending payout: $total KSM');
}

/// simple get request that returns a json body
Future<dynamic> getRequest(url) async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return null;
}

/// Calculates pending payouts for a specified author
double calculatePendingPayouts(json) {
  var totalPendingAmount = 0;

  final List<dynamic> eraPayouts = json['erasPayouts'];

  eraPayouts.forEach((era) {
    final List<dynamic> payouts = era['payouts'];
    if (payouts.isNotEmpty) {
      totalPendingAmount += payouts.fold(
        0,
        (prev, validator) =>
            prev + int.tryParse(validator['nominatorStakingPayout']),
      );
    }
  });

  return totalPendingAmount / ksmPrecision;
}
