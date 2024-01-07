import 'dart:convert';

import 'package:ditonton/data/models/series/tv_series_model.dart';
import 'package:ditonton/data/models/series/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [10763],
    id: 1,
    originCountry: ["DE"],
    originalLanguage: "de",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "1952-12-26",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvSeriesResponse =
      const TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_now_playing.json'));

      // act
      final result = TvSeriesResponse.fromJson(jsonMap);

      // assert
      expect(result, tTvSeriesResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvSeriesResponse.toJson();

      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [10763],
            "id": 1,
            "origin_country": ["DE"],
            "original_language": "de",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "first_air_date": "1952-12-26",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
