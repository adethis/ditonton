import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:season/data/models/season_detail_model.dart';
import 'package:season/data/models/season_model.dart';
import 'package:season/data/models/season_response.dart';

abstract class SeasonRemoteDataSource {
  Future<List<SeasonModel>> getSeason(int seriesId);
  Future<SeasonDetailModel> getSeasonDetail(int seriesId, int seasonNumber);
}

class SeasonRemoteDataSourceImpl implements SeasonRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  SeasonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SeasonModel>> getSeason(int seriesId) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$seriesId?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonResponse.fromJson(json.decode(response.body)).seasonList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getSeasonDetail(
    int seriesId,
    int seasonNumber,
  ) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$seriesId/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
