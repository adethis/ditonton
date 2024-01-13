import 'package:equatable/equatable.dart';
import 'package:season/data/models/episode_model.dart';
import 'package:season/domain/entities/season_detail.dart';

class SeasonDetailModel extends Equatable {
  const SeasonDetailModel({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final int? id;
  final DateTime? airDate;
  final List<EpisodeModel>? episodes;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        id: json["id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: json["episodes"] != null
            ? List<EpisodeModel>.from(
                json["episodes"].map((x) => EpisodeModel.fromJson(x)))
            : null,
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["voteAverage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episodes": List<dynamic>.from(episodes!.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };

  SeasonDetail toEntity() {
    return SeasonDetail(
      id: id,
      airDate: airDate,
      episodes: episodes?.map((episode) => episode.toEntity()).toList(),
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
