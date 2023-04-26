import 'dart:convert';
import 'package:etsemployee/Network/api_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future postData({required String paramUri, required Map params}) async {
  var response = await http.post(Uri.parse(ApiConstant.baseUrl + paramUri), body: params);
  if (kDebugMode) {
    print(response.body);
  }
  return jsonDecode(response.body);
}

Future postDataWithHeader({required String paramUri, required Map params}) async {
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'X-Access-Token': ApiConstant.userToken,
  };
  var response = await http.post(
    Uri.parse(ApiConstant.baseUrl + paramUri),
    headers: requestHeaders,
    body: params,
  );

  if (kDebugMode) {
    print(response.body);
  }

  if (response.body.isNotEmpty) {
    var body = json.decode(response.body);
    return body;
  }
}

Future getData({required String paramUri}) async {
  if (kDebugMode) {
    print(ApiConstant.userToken);
  }
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Access-Token': ApiConstant.userToken,
  };
  var response = await http.get(Uri.parse(ApiConstant.baseUrl + paramUri), headers: requestHeaders);

  if (response.body.isNotEmpty) {
    var body = json.decode(response.body);

    return body;
  }
}
