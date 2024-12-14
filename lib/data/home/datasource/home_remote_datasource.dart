import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:eazr/core/api/api.dart';
import 'package:eazr/core/errors/api_expection_handler.dart';
import 'package:eazr/core/errors/exception.dart';
import 'package:eazr/data/category/model/category_model.dart';
import 'package:eazr/data/home/model/most_popular_model.dart';
import 'package:eazr/data/home/model/top_stories_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class HomeRemoteDatasource {
  ///GET Request.
  ///
  Future<List<PopularModel>> getLatestNews();

  Future<List<Map<String, dynamic>>> getSectionData();

  Future<List<CategoryModel>> getContentData({
    required String section,
  });

  Future<List<TopStoriesModel>> getTopStories();
}

@Singleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  HomeRemoteDatasourceImpl(
    this.apiExceptionHandler,
    this.client,
    this.api,
  );

  final ApiExceptionHandler apiExceptionHandler;
  final http.Client client;
  final API api;

  @override
  Future<List<PopularModel>> getLatestNews() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getLatestNewsIso, receivePort.sendPort);
    final result = await receivePort.first;

    // Check if the result is an error
    if (result is Exception) {
      throw result; // Re-throw the exception to be handled by the caller
    }

    // Return the list of SearchDocsModel
    return result as List<PopularModel>;
  }

  void getLatestNewsIso(SendPort sendPort) async {
    try {
      debugPrint('---------------------------------');
      debugPrint('${api.endpointUri(
        Endpoint.mostPopular,
        pathSegments: ['/emailed/7.json'],
        queryParameters: {'api-key': 'TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo'},
      )}-------------------');
      final response = await http.post(
        // TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo
        api.endpointUri(
          Endpoint.mostPopular,
          pathSegments: ['/emailed/7.json'],
          queryParameters: {'api-key': 'TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo'},
        ),
      );

      //decode response to json Map<String,dynamic>
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      debugPrint('---------------------------------');

      // check status
      if (response.statusCode == HttpStatus.ok) {
        // return the decoded response
        List<PopularModel> getPopularModel = (responseBody['results'] as List)
            .map((e) => PopularModel.fromJson(e))
            .toList();
        sendPort.send(getPopularModel);
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

  @override
  Future<List<Map<String, dynamic>>> getSectionData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getSectionDataIso, receivePort.sendPort);
    final result = await receivePort.first;

    // Check if the result is an error
    if (result is Exception) {
      throw result; // Re-throw the exception to be handled by the caller
    }

    // Return the list of SearchDocsModel
    return result as List<Map<String, dynamic>>;
  }

  void getSectionDataIso(SendPort sendPort) async {
    try {
      final response = await http.get(
        api.endpointUri(
          Endpoint.section,
          queryParameters: {'api-key': 'TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo'},
        ),
      );

      //decode response to json Map<String,dynamic>
      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      // check status
      if (response.statusCode == HttpStatus.ok) {
        // return the decoded response
        List<Map<String, dynamic>> getSectionList =
            (responseBody['results'] as List)
                .map((e) => e as Map<String, dynamic>)
                .toList();
        sendPort.send(getSectionList);
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

  @override
  Future<List<CategoryModel>> getContentData({
    required String section,
  }) async {
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn((SendPort sendPort) {
      // Call getSearchIso in the spawned isolate
      getContentDataIso(
        sendPort,
        section,
      );
    }, receivePort.sendPort);
    final result = await receivePort.first;

    // Check if the result is an error
    if (result is Exception) {
      throw result; // Re-throw the exception to be handled by the caller
    }

    // Return the list of SearchDocsModel
    return result as List<CategoryModel>;
  }

  void getContentDataIso(SendPort sendPort, String section) async {
    try {
      debugPrint('---------------------------------');
      debugPrint('section: $section');
      final response = await http.get(
        api.endpointUri(
          Endpoint.content,
          pathSegments: ['$section.json'],
          queryParameters: {'api-key': 'TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo'},
        ),
      );

      //decode response to json Map<String,dynamic>
      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      // check status
      if (response.statusCode == HttpStatus.ok) {
        // return the decoded response
        List<CategoryModel> getContentList =
            (responseBody['results'] as List<dynamic>)
                .map((e) => CategoryModel.fromJson(e))
                .toList();
        sendPort.send(getContentList);
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

  @override
  Future<List<TopStoriesModel>> getTopStories() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getTopStoriesIso, receivePort.sendPort);
    final result = await receivePort.first;

    // Check if the result is an error
    if (result is Exception) {
      throw result; // Re-throw the exception to be handled by the caller
    }

    // Return the list of SearchDocsModel
    return result as List<TopStoriesModel>;
  }

  void getTopStoriesIso(SendPort sendPort) async {
    try {
      final response = await http.get(
        api.endpointUri(
          Endpoint.topStories,
          queryParameters: {'api-key': 'TMfTPbzPCsTShvkjNIKZUws7M1WBxTzo'},
        ),
      );

      //decode response to json Map<String,dynamic>
      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      // check status
      if (response.statusCode == HttpStatus.ok) {
        // return the decoded response
        List<TopStoriesModel> getTopStoriesList =
            (responseBody['results'] as List)
                .map((e) => TopStoriesModel.fromJson(e))
                .toList();
        sendPort.send(getTopStoriesList);
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
