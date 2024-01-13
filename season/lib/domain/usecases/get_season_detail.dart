import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:season/domain/entities/season_detail.dart';
import 'package:season/domain/repositories/season_repository.dart';

class GetSeasonDetail {
  final SeasonRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(
    int seriesId,
    int seasonNumber,
  ) {
    return repository.getSeasonDetail(
      seriesId,
      seasonNumber,
    );
  }
}
