import 'package:flutter_test/flutter_test.dart';
import 'package:season/data/models/season_model.dart';
import 'package:season/domain/entities/season.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: DateTime.parse("2023-06-05"),
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  final tSeason = Season(
    airDate: DateTime.parse("2023-06-05"),
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  test('should be subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();

    expect(result, tSeason);
  });

  test('Season Model should return a JSON containing proper data', () async {
    final result = tSeasonModel.toJson();

    final expectedJsonMap = {
      "air_date": "2023-06-05",
      "episode_count": 1,
      "id": 1,
      "name": "name",
      "overview": "overview",
      "poster_path": "posterPath",
      "season_number": 1,
      "vote_average": 1.0,
    };

    expect(result, expectedJsonMap);
  });
}
