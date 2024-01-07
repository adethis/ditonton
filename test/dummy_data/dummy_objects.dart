import 'package:ditonton/data/models/movies/movie_table.dart';
import 'package:ditonton/data/models/series/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movies/movie.dart';
import 'package:ditonton/domain/entities/movies/movie_detail.dart';
import 'package:ditonton/domain/entities/network.dart';
import 'package:ditonton/domain/entities/production_country.dart';
import 'package:ditonton/domain/entities/series/tv_series.dart';
import 'package:ditonton/domain/entities/series/tv_series_detail.dart';
import 'package:ditonton/domain/entities/series/tv_series_season.dart';
import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:ditonton/domain/entities/tepisode_to_air.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: 'jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
  genreIds: const [1, 2],
  id: 1,
  originCountry: const ['DE'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  createdBy: const [],
  episodeRunTime: const [15],
  firstAirDate: DateTime.parse("1952-12-26"),
  genres: const [Genre(id: 10763, name: "News")],
  homepage: "https://www.tagesschau.de/",
  id: 1,
  inProduction: true,
  languages: const ["de"],
  lastAirDate: DateTime.parse("2023-12-26"),
  lastEpisodeToAir: TEpisodeToAir(
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
  nextEpisodeToAir: TEpisodeToAir(
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
  networks: [
    Network(
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
  productionCompanies: [
    Network(
      id: 7201,
      logoPath: "/ljV8ZT3CIYCEIEDlTyBliXJVCZr.png",
      name: "NDR",
      originCountry: "DE",
    )
  ],
  productionCountries: [
    ProductionCountry(
      iso31661: "DE",
      name: "Germany",
    ),
  ],
  seasons: [
    TvSeriesSeason(
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
  spokenLanguages: [
    SpokenLanguage(
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

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'Tagesschau',
  posterPath: '/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
  overview: 'overview',
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'Tagesschau',
  posterPath: '/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'Tagesschau',
  'posterPath': '/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
  'overview': 'overview',
};
