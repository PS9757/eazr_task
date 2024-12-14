import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:eazr/core/api/api.dart';
import 'package:eazr/core/errors/api_expection_handler.dart';
import 'package:eazr/core/errors/exception.dart';
import 'package:eazr/data/search/model/search_docs_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class SearchDatasource {
  Future<List<SearchDocsModel>> getSearchData({
    required String query,
    required int page,
  });
}

@Singleton(as: SearchDatasource)
class SearchDatasourceImpl extends SearchDatasource {
  SearchDatasourceImpl(
    this.apiExceptionHandler,
    this.client,
    this.api,
  );

  final ApiExceptionHandler apiExceptionHandler;
  final http.Client client;
  final API api;

  @override
  Future<List<SearchDocsModel>> getSearchData({
    required String query,
    required int page,
  }) async {
    ReceivePort receivePort = ReceivePort();

    // Spawn a new isolate
    await Isolate.spawn(
      (SendPort sendPort) {
        // Call getSearchIso in the spawned isolate
        getSearchIso(sendPort, query, page);
      },
      receivePort.sendPort,
    );

    final result = await receivePort.first;

    // Check if the result is an error
    if (result is Exception) {
      throw result; // Re-throw the exception to be handled by the caller
    }

    // Return the list of SearchDocsModel
    return result as List<SearchDocsModel>;
  }

  void getSearchIso(SendPort sendPort, String query, int page) async {
    try {
      debugPrint('---------------------------------');
      debugPrint('${api.endpointUri(
        Endpoint.search,
        // pathSegments: ['/emailed/7.json'],
        queryParameters: {
          'q': query,
          'page': page.toString(),
          'api-key': 'TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo',
        },
      )}-------------------');
      final response = await http.get(
        // TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo
        api.endpointUri(
          Endpoint.search,
          queryParameters: {
            'q': query,
            'page': page.toString(),
            'api-key': 'TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo',
          },
        ),
      );

      //decode response to json Map<String,dynamic>
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      debugPrint('---------------------------------');

      // check status
      if (response.statusCode == HttpStatus.ok) {
        // check if response is not empty
        if (responseBody['response']['docs'] != null) {
          // convert json to model
          final List<SearchDocsModel> searchDocsModel = (responseBody[
                  'response']['docs'] as List)
              .map((e) => SearchDocsModel.fromJson(e as Map<String, dynamic>))
              .toList();
          sendPort.send(searchDocsModel);
        } else {
          sendPort.send(NotFoundException());
        }
      } else {
        sendPort.send(apiExceptionHandler
            .throwHttpExceptionBasedOnStatusCode(response.statusCode));
      }
    } on SocketException {
      sendPort.send(NoInternetConnectionException());
    } on FormatException {
      sendPort.send(ParseJsonException());
    }
  }
}
