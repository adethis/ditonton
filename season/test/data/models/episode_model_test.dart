import 'package:flutter_test/flutter_test.dart';
import 'package:season/data/models/episode_model.dart';
import 'package:season/domain/entities/episode.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
    airDate: DateTime.parse("2023-06-05"),
    episodeNumber: 1,
    episodeType: 'episodeType',
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 'runtime',
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
    crew: const [],
    guestStars: const [],
  );

  final tEpisode = Episode(
    airDate: DateTime.parse("2023-06-05"),
    episodeNumber: 1,
    episodeType: 'episodeType',
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 'runtime',
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
    crew: const [],
    guestStars: const [],
  );

  test('should be subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();

    expect(result, tEpisode);
  });

  test('should be return JSON map containing proper data', () async {
    final result = tEpisodeModel.toJson();

    final expectedJsonMap = {
      "air_date": "2023-06-05",
      "episode_number": 1,
      "episode_type": 'episodeType',
      "id": 1,
      "name": "name",
      "overview": "overview",
      "production_code": "productionCode",
      "runtime": "runtime",
      "season_number": 1,
      "show_id": 1,
      "still_path": "stillPath",
      "vote_average": 1.0,
      "vote_count": 1,
      "crew": [],
      "guest_stars": []
    };

    expect(result, expectedJsonMap);
  });
}
