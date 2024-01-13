import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:season/data/models/season_model.dart';
import 'package:tv_series/data/models/network_model.dart';
import 'package:tv_series/data/models/production_country_model.dart';
import 'package:tv_series/data/models/spoken_language_model.dart';
import 'package:tv_series/data/models/tepisode_to_air_model.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/4Mt7WHox67uJ1yErwTBFcV8KWgG.jpg",
    genreIds: [10759, 35, 16],
    id: 37854,
    originCountry: ["JP"],
    originalLanguage: "ja",
    originalName: "ワンピース",
    overview:
        "Years ago, the fearsome Pirate King, Gol D. Roger was executed leaving a huge pile of treasure and the famous \"One Piece\" behind. Whoever claims the \"One Piece\" will be named the new King of the Pirates.\n\nMonkey D. Luffy, a boy who consumed a \"Devil Fruit,\" decides to follow in the footsteps of his idol, the pirate Shanks, and find the One Piece. It helps, of course, that his body has the properties of rubber and that he's surrounded by a bevy of skilled fighters and thieves to help him along the way.\n\nLuffy will do anything to get the One Piece and become King of the Pirates!",
    popularity: 534.839,
    posterPath: "/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
    firstAirDate: "1999-10-20",
    name: "One Piece",
    voteAverage: 8.727,
    voteCount: 4219,
  );

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/4Mt7WHox67uJ1yErwTBFcV8KWgG.jpg",
    genreIds: const [10759, 35, 16],
    id: 37854,
    originCountry: const ["JP"],
    originalLanguage: "ja",
    originalName: "ワンピース",
    overview:
        "Years ago, the fearsome Pirate King, Gol D. Roger was executed leaving a huge pile of treasure and the famous \"One Piece\" behind. Whoever claims the \"One Piece\" will be named the new King of the Pirates.\n\nMonkey D. Luffy, a boy who consumed a \"Devil Fruit,\" decides to follow in the footsteps of his idol, the pirate Shanks, and find the One Piece. It helps, of course, that his body has the properties of rubber and that he's surrounded by a bevy of skilled fighters and thieves to help him along the way.\n\nLuffy will do anything to get the One Piece and become King of the Pirates!",
    popularity: 534.839,
    posterPath: "/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
    firstAirDate: "1999-10-20",
    name: "One Piece",
    voteAverage: 8.727,
    voteCount: 4219,
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);

      // act
      final result = await repository.getNowPlayingTvSeries();

      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());

      final result = await repository.getNowPlayingTvSeries();

      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getNowPlayingTvSeries();

      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);

      final result = await repository.getPopularTvSeries();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());

      final result = await repository.getPopularTvSeries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getPopularTvSeries();

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);

      final result = await repository.getTopRatedTvSeries();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());

      final result = await repository.getTopRatedTvSeries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTopRatedTvSeries();

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Series Detail', () {
    const tId = 1;
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
        'should return TV Series data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);

      final result = await repository.getTvSeriesDetail(tId);

      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvSeriesDetail(tId);

      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTvSeriesDetail(tId);

      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Series Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    const tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesList);

      final result = await repository.getTvSeriesRecommendations(tId);

      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));

      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvSeriesRecommendations(tId);

      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTvSeriesRecommendations(tId);

      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TV Series', () {
    const tQuery = 'one piece';

    test('should return tv series list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);

      final result = await repository.searchTvSeries(tQuery);

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());

      final result = await repository.searchTvSeries(tQuery);

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.searchTvSeries(tQuery);

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Save Watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalDataSource.insertWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchlistTvSeries(testTvSeriesDetail);

      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchlistTvSeries(testTvSeriesDetail);

      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalDataSource.removeWatchlistTvSeries(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      final result =
          await repository.removeWatchlistTvSeries(testTvSeriesDetail);

      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlistTvSeries(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      final result =
          await repository.removeWatchlistTvSeries(testTvSeriesDetail);

      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      const tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlistTvSeries(tId);

      expect(result, false);
    });
  });

  group('Get Watchlist TV Series', () {
    test('should return list of TV Series', () async {
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);

      final result = await repository.getWatchlistTvSeries();

      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
