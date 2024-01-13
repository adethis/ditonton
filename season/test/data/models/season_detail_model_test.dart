import 'package:flutter_test/flutter_test.dart';
import 'package:season/data/models/episode_model.dart';
import 'package:season/data/models/season_detail_model.dart';
import 'package:season/domain/entities/episode.dart';
import 'package:season/domain/entities/season_detail.dart';

void main() {
  final tSeasonDetailModel = SeasonDetailModel(
    id: 1,
    airDate: DateTime.parse("2023-06-05"),
    episodes: [
      EpisodeModel(
        airDate: DateTime.parse("2023-06-05"),
        episodeNumber: 1,
        episodeType: 'episodeType',
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        runtime: null,
        seasonNumber: 1,
        showId: 1,
        stillPath: 'stillPath',
        voteAverage: 1.0,
        voteCount: 1,
        crew: const [],
        guestStars: const [],
      ),
    ],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  final tSeasonDetail = SeasonDetail(
    id: 1,
    airDate: DateTime.parse("2023-06-05"),
    episodes: [
      Episode(
        airDate: DateTime.parse("2023-06-05"),
        episodeNumber: 1,
        episodeType: 'episodeType',
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        runtime: null,
        seasonNumber: 1,
        showId: 1,
        stillPath: 'stillPath',
        voteAverage: 1.0,
        voteCount: 1,
        crew: const [],
        guestStars: const [],
      ),
    ],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  test('should be subclass of Season Detail entity', () async {
    final result = tSeasonDetailModel.toEntity();

    expect(result, tSeasonDetail);
  });

  test('should be return JSON map containing proper data', () async {
    final result = tSeasonDetailModel.toJson();

    final expectedJsonMap = {
      "id": 1,
      "air_date": "2023-06-05",
      "episodes": [
        {
          "air_date": "2023-06-05",
          "episode_number": 1,
          "episode_type": 'episodeType',
          "id": 1,
          "name": 'name',
          "overview": 'overview',
          "production_code": 'productionCode',
          "runtime": null,
          "season_number": 1,
          "show_id": 1,
          "still_path": 'stillPath',
          "vote_average": 1.0,
          "vote_count": 1,
          "crew": const [],
          "guest_stars": const [],
        }
      ],
      "name": 'name',
      "overview": 'overview',
      "poster_path": 'posterPath',
      "season_number": 1,
      "vote_average": 1.0,
    };

    expect(result, expectedJsonMap);
  });
}
