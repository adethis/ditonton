import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/network_model.dart';
import 'package:ditonton/data/models/production_country_model.dart';
import 'package:ditonton/data/models/series/tv_series_detail_model.dart';
import 'package:ditonton/data/models/series/tv_series_season_model.dart';
import 'package:ditonton/data/models/spoken_language_model.dart';
import 'package:ditonton/data/models/tepisode_to_air_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailModel(
    adult: false,
    backdropPath: 'backdropPath',
    createdBy: const ['createdBy'],
    episodeRunTime: const ['episodeRunTime'],
    firstAirDate: DateTime.parse('1991-10-10'),
    genres: const [GenreModel(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    languages: const ['EN'],
    lastAirDate: DateTime.parse('1991-10-10'),
    lastEpisodeToAir: TEpisodeToAirModel(
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
    ),
    name: 'name',
    nextEpisodeToAir: TEpisodeToAirModel(
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
    ),
    networks: const [
      NetworkModel(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      )
    ],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    productionCompanies: const [
      NetworkModel(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      )
    ],
    productionCountries: const [
      ProductionCountryModel(
        iso31661: 'iso31661',
        name: 'name',
      )
    ],
    seasons: [
      SeasonModel(
        airDate: DateTime.parse('1991-10-10'),
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1.0,
      )
    ],
    spokenLanguages: const [
      SpokenLanguageModel(
        englishName: 'englishName',
        iso6391: 'iso6391',
        name: 'name',
      )
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('TV Series Detail Model should return a JSON containing proper data',
      () async {
    final result = tTvSeriesDetailModel.toJson();

    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": 'backdropPath',
      "created_by": ['createdBy'],
      "episode_run_time": ['episodeRunTime'],
      "first_air_date": '1991-10-10',
      "genres": [
        {'id': 1, 'name': 'name'}
      ],
      "homepage": 'homepage',
      "id": 1,
      "in_production": false,
      "languages": ['EN'],
      "last_air_date": '1991-10-10',
      "last_episode_to_air": {
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
      },
      "name": 'name',
      "next_episode_to_air": {
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
      },
      "networks": [
        {
          "id": 1,
          "logoPath": 'logoPath',
          "name": 'name',
          "originCountry": 'originCountry',
        }
      ],
      "number_of_episodes": 1,
      "number_of_seasons": 1,
      "origin_country": ['originCountry'],
      "original_language": 'originalLanguage',
      "original_name": 'originalName',
      "overview": 'overview',
      "popularity": 1.0,
      "poster_path": 'posterPath',
      "production_companies": [
        {
          "id": 1,
          "logoPath": 'logoPath',
          "name": 'name',
          "originCountry": 'originCountry',
        }
      ],
      "production_countries": [
        {
          "iso31661": 'iso31661',
          "name": 'name',
        }
      ],
      "seasons": [
        {
          "air_date": '1991-10-10',
          "episode_count": 1,
          "id": 1,
          "name": 'name',
          "overview": 'overview',
          "poster_path": 'posterPath',
          "season_number": 1,
          "vote_average": 1.0,
        }
      ],
      "spoken_languages": [
        {
          "englishName": 'englishName',
          "iso6391": 'iso6391',
          "name": 'name',
        }
      ],
      "status": 'status',
      "tagline": 'tagline',
      "type": 'type',
      "vote_average": 1.0,
      "vote_count": 1,
    };

    expect(result, expectedJsonMap);
  });
}
