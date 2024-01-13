import 'package:core/core.dart';
import 'package:season/domain/entities/episode.dart';
import 'package:season/domain/entities/season.dart';
import 'package:season/domain/entities/season_detail.dart';
import 'package:tv_series/domain/entities/network.dart';
import 'package:tv_series/domain/entities/production_country.dart';
import 'package:tv_series/domain/entities/spoken_language.dart';
import 'package:tv_series/domain/entities/tepisode_to_air.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final testSeason = TvSeriesDetail(
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
    Season(
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

final testSeasonDetail = SeasonDetail(
  airDate: DateTime.parse("2023-06-05"),
  episodes: [
    Episode(
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
