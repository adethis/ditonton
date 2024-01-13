import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tepisode_to_air_model.dart';

void main() {
  final tEpisodeToAirModel = TEpisodeToAirModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1.0,
    voteCount: 1,
    airDate: DateTime.parse('1991-10-10'),
    episodeNumber: 1,
    episodeType: 'episodeType',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
  );

  test('Episode To Air Model should return a JSON map containing proper data',
      () async {
    final result = tEpisodeToAirModel.toJson();

    final expectedJsonMap = {
      "id": 1,
      "name": 'name',
      "overview": 'overview',
      "vote_average": 1.0,
      "vote_count": 1,
      "air_date": '1991-10-10',
      "episode_number": 1,
      "episode_type": 'episodeType',
      "production_code": 'productionCode',
      "runtime": 1,
      "season_number": 1,
      "show_id": 1,
      "still_path": 'stillPath',
    };

    expect(result, expectedJsonMap);
  });
}
