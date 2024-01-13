import 'package:flutter_test/flutter_test.dart';
import 'package:season/data/models/season_model.dart';
import 'package:season/data/models/season_response.dart';

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
  final tSeasonResponseModel =
      SeasonResponse(seasonList: <SeasonModel>[tSeasonModel]);

  test('should return a JSON map containing proper data', () async {
    final result = tSeasonResponseModel.toJson();

    final expectedJsonMap = {
      "seasons": [
        {
          "air_date": "2023-06-05",
          "episode_count": 1,
          "id": 1,
          "name": "name",
          "overview": "overview",
          "poster_path": "posterPath",
          "season_number": 1,
          "vote_average": 1.0
        }
      ]
    };

    expect(result, expectedJsonMap);
  });

  test('Check props tv series detail event', () {
    final event = SeasonResponse(seasonList: <SeasonModel>[tSeasonModel]);

    expect(event.props, [
      [tSeasonModel]
    ]);
  });
}
