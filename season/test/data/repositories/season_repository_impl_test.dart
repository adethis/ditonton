import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:season/data/models/episode_model.dart';
import 'package:season/data/models/season_detail_model.dart';
import 'package:season/data/models/season_model.dart';
import 'package:season/data/repositories/season_repository_impl.dart';
import 'package:tv_series/data/models/network_model.dart';
import 'package:tv_series/data/models/production_country_model.dart';
import 'package:tv_series/data/models/spoken_language_model.dart';
import 'package:tv_series/data/models/tepisode_to_air_model.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeasonRepositoryImpl repository;
  late MockSeasonRemoteDataSource mockSeasonRemoteDataSource;

  setUp(() {
    mockSeasonRemoteDataSource = MockSeasonRemoteDataSource();
    repository = SeasonRepositoryImpl(
      remoteDataSource: mockSeasonRemoteDataSource,
    );
  });

  group('Get Season', () {
    const seriesId = 1;
    final tTvSeriesResponse = TvSeriesDetailModel(
      adult: false,
      backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
      createdBy: const [],
      episodeRunTime: const [15],
      firstAirDate: DateTime.parse("1952-12-26"),
      genres: const [GenreModel(id: 10763, name: "News")],
      homepage: "https://www.tagesschau.de/",
      id: 1,
      inProduction: true,
      languages: const ["de"],
      lastAirDate: DateTime.parse("2023-12-26"),
      lastEpisodeToAir: TEpisodeToAirModel(
        id: 4533232,
        name: "Episode 360",
        overview: "",
        voteAverage: 0.0,
        voteCount: 0,
        airDate: DateTime.parse("2023-12-26"),
        episodeNumber: 360,
        episodeType: "standard",
        productionCode: "",
        runtime: 15,
        seasonNumber: 72,
        showId: 94722,
        stillPath: null,
      ),
      name: "Tagesschau",
      nextEpisodeToAir: TEpisodeToAirModel(
        id: 4533233,
        name: "Episode 361",
        overview: "",
        voteAverage: 0.0,
        voteCount: 0,
        airDate: DateTime.parse("2023-12-27"),
        episodeNumber: 361,
        episodeType: "standard",
        productionCode: "",
        runtime: 15,
        seasonNumber: 72,
        showId: 94722,
        stillPath: null,
      ),
      networks: const [
        NetworkModel(
          id: 308,
          logoPath: "/nGl2dDGonksWY4fTzPPdkK3oNyq.png",
          name: "Das Erste",
          originCountry: "DE",
        )
      ],
      numberOfEpisodes: 20839,
      numberOfSeasons: 72,
      originCountry: const ["DE"],
      originalLanguage: "de",
      originalName: "Tagesschau",
      overview: "overview",
      popularity: 3557.862,
      posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
      productionCompanies: const [
        NetworkModel(
          id: 7201,
          logoPath: "/ljV8ZT3CIYCEIEDlTyBliXJVCZr.png",
          name: "NDR",
          originCountry: "DE",
        )
      ],
      productionCountries: const [
        ProductionCountryModel(
          iso31661: "DE",
          name: "Germany",
        ),
      ],
      seasons: [
        SeasonModel(
          airDate: DateTime.parse("1952-12-26"),
          episodeCount: 6,
          id: 134441,
          name: "Season 1952",
          overview: "",
          posterPath: "/lEOhLYxSlqYcAlSSunb0fbXkKM5.jpg",
          seasonNumber: 1,
          voteAverage: 3.5,
        )
      ],
      spokenLanguages: const [
        SpokenLanguageModel(
          englishName: "German",
          iso6391: "de",
          name: "Deutsch",
        )
      ],
      status: "Returning Series",
      tagline: "",
      type: "News",
      voteAverage: 6.898,
      voteCount: 191,
    );

    test(
        'should return season data when the call to remote data source is successfully',
        () async {
      when(mockSeasonRemoteDataSource.getSeason(seriesId))
          .thenAnswer((_) async => tTvSeriesResponse.seasons);

      final result = await repository.getSeason(seriesId);

      verify(mockSeasonRemoteDataSource.getSeason(seriesId));

      final resultList = result.getOrElse(() => []);
      expect(resultList, testSeason.seasons);
    });

    test(
        'should return server failure when the call to remote data source unsuccessful',
        () async {
      when(mockSeasonRemoteDataSource.getSeason(seriesId))
          .thenThrow(ServerException());

      final result = await repository.getSeason(seriesId);

      verify(mockSeasonRemoteDataSource.getSeason(seriesId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockSeasonRemoteDataSource.getSeason(seriesId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getSeason(seriesId);

      verify(mockSeasonRemoteDataSource.getSeason(seriesId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Season Detail', () {
    const seriesId = 1;
    const seasonNumber = 1;
    final tSeasonDetail = SeasonDetailModel(
      airDate: DateTime.parse("2023-06-05"),
      episodes: [
        EpisodeModel(
          airDate: DateTime.parse(
            "2023-06-05",
          ),
          episodeNumber: 1,
          episodeType: "standard",
          id: 4624162,
          name: "Episode 1",
          overview:
              "Rian comes to Gaby’s rescue, Andrea is not telling the truth, and Delia has news about Danny. Annelize is amazed by an article, Nicolette meets a lawyer, and Tertius opens up toward Louis. Diego agrees to a trade-off, and Jeremy and Henry have an appointment.",
          productionCode: "",
          runtime: null,
          seasonNumber: 19,
          showId: 206559,
          stillPath: null,
          voteAverage: 9.0,
          voteCount: 1,
          crew: const [],
          guestStars: const [],
        )
      ],
      name: "Season 19",
      overview: "",
      id: 1,
      posterPath: "/omwys5OcmSQCJwS02uOGcqBAQ4m.jpg",
      seasonNumber: 19,
      voteAverage: 9.1,
    );

    test(
        'should return Season detail data when the call to remote data source is successfully',
        () async {
      when(mockSeasonRemoteDataSource.getSeasonDetail(seriesId, seasonNumber))
          .thenAnswer((_) async => tSeasonDetail);

      final result = await repository.getSeasonDetail(seriesId, seasonNumber);

      verify(
          mockSeasonRemoteDataSource.getSeasonDetail(seriesId, seasonNumber));
      expect(result, equals(Right(testSeasonDetail)));
    });

    test(
        'should return Season detail data when the call to remote data source is unsuccessfully',
        () async {
      when(mockSeasonRemoteDataSource.getSeasonDetail(seriesId, seasonNumber))
          .thenThrow(ServerException());

      final result = await repository.getSeasonDetail(seriesId, seasonNumber);

      verify(
          mockSeasonRemoteDataSource.getSeasonDetail(seriesId, seasonNumber));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockSeasonRemoteDataSource.getSeasonDetail(seriesId, seasonNumber))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getSeasonDetail(seriesId, seasonNumber);

      verify(
          mockSeasonRemoteDataSource.getSeasonDetail(seriesId, seasonNumber));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
