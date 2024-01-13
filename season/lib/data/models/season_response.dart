import 'package:equatable/equatable.dart';
import 'package:season/data/models/season_model.dart';

class SeasonResponse extends Equatable {
  final List<SeasonModel> seasonList;

  const SeasonResponse({required this.seasonList});

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => SeasonResponse(
        seasonList: List<SeasonModel>.from(
            (json["seasons"] as List).map((x) => SeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {"seasons": List<dynamic>.from(seasonList.map((e) => e.toJson()))};

  @override
  List<Object> get props => [seasonList];
}
