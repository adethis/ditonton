import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:season/domain/entities/season.dart';
import 'package:season/domain/entities/season_detail.dart';

abstract class SeasonRepository {
  Future<Either<Failure, List<Season>>> getSeason(int seriesId);
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
    int seriesId,
    int seasonNumber,
  );
}
