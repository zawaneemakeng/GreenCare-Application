import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:rotnaam/utils/api_url.dart';

Future deleteTransection(int _id) async {
  // var url = Uri.https('abcd.ngrok.io', '/api/post-todolist');
  var url = Uri.http(host(), '/api/delete-transection/$_id');
  Map<String, String> header = {"Content-type": "application/json"};
  var response = await http.delete(url, headers: header);
  print('--------result--------');

  var resulttext = utf8.decode(response.bodyBytes);
  var result_json = json.decode(resulttext);
  String status = result_json['status'];

  if (status == 'deleted') {
    return status;
  }
}
