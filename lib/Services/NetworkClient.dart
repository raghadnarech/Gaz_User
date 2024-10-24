// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

enum RequestType { GET, POST }

enum RequestTypeImage { POST_WITH_IMAGE, POST_WITH_MULTI_IMAGE }

class NetworkClient {
  static final String _baseUrl = AppApi.url;

  final Client _client;

  NetworkClient(this._client);
  Future<MultipartRequest> requestimage({
    required String path,
    Map<String, String>? body,
    http.MultipartFile? image,
  }) async {
    // print("$_baseUrl$path");
    String? token = ServicesProvider.gettoken();
    log(token);
    return http.MultipartRequest(
      "POST",
      Uri.parse('$_baseUrl$path'),
    )
      ..fields.addAll(body!)
      ..files.add(image!)
      ..headers.addAll(
        {
          "Accept": "application/json",
          'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
        },
      );
  }

  Future<MultipartRequest> requestwithoutimage({
    required String path,
    Map<String, String>? body,
  }) async {
    // print("$_baseUrl$path");
    String? token = ServicesProvider.gettoken();
    log(token);
    return http.MultipartRequest(
      "POST",
      Uri.parse('$_baseUrl$path'),
    )
      ..fields.addAll(body!)
      ..headers.addAll(
        {
          "Accept": "application/json",
          'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
        },
      );
  }

  Future<Response> request(
      {required RequestType requestType,
      required String path,
      Map<String, dynamic>? body,
      int TimeOut = 30}) async {
    log("$_baseUrl$path");
    log(ServicesProvider.gettoken());
    switch (requestType) {
      case RequestType.GET:
        if (ServicesProvider.user?.token != null) {
          return _client.get(Uri.parse("$_baseUrl$path"), headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
          }).timeout(Duration(seconds: TimeOut));
        } else {
          return _client.get(Uri.parse("$_baseUrl$path"), headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
          }).timeout(Duration(seconds: TimeOut));
        }

      case RequestType.POST:
        if (ServicesProvider.user?.token != null) {
          log(ServicesProvider.user?.token.toString() ?? '');
          log(body.toString());
          log("$_baseUrl$path");
          return _client
              .post(Uri.parse("$_baseUrl$path"),
                  headers: {
                    "Accept": "application/json",
                    'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
                  },
                  body: json.encode(body))
              .timeout(Duration(seconds: TimeOut));
        } else {
          return _client
              .post(Uri.parse("$_baseUrl$path"),
                  headers: {
                    "Accept": "application/json",
                    'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
                  },
                  body: body)
              .timeout(Duration(seconds: TimeOut));
        }
    }
  }
}
