import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:season/data/datasources/season_remote_data_source.dart';
import 'package:season/data/models/season_detail_model.dart';
import 'package:season/data/models/season_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late SeasonRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = SeasonRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Season', () {
    const seriesId = 1;
    final tSeasonData =
        SeasonResponse.fromJson(json.decode(readJson('dummy_data/season.json')))
            .seasonList;

    test('should return list of Season Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$seriesId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/season.json'), 200));

      final result = await dataSourceImpl.getSeason(seriesId);

      expect(result, equals(tSeasonData));
    });

    test(
        'should return server exception when the call remote data unsuccessful',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$seriesId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSourceImpl.getSeason(seriesId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Season Detail', () {
    const seriesId = 1;
    const seasonNumber = 1;
    final tSeasonDetail = SeasonDetailModel.fromJson(
        json.decode(readJson('dummy_data/season_detail.json')));

    test('should return season detail when the response code is 200', () async {
      when(mockHttpClient.get(
              Uri.parse('$baseUrl/tv/$seriesId/season/$seasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/season_detail.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));

      final result =
          await dataSourceImpl.getSeasonDetail(seriesId, seasonNumber);

      expect(result, equals(tSeasonDetail));
    });

    test('should return season detail when the response code is 200', () async {
      when(mockHttpClient.get(
              Uri.parse('$baseUrl/tv/$seriesId/season/$seasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSourceImpl.getSeasonDetail(seriesId, seasonNumber);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
