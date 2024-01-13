import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:season/domain/entities/season.dart';
import 'package:season/domain/repositories/season_repository.dart';

class GetSeason {
  final SeasonRepository repository;

  GetSeason(this.repository);

  Future<Either<Failure, List<Season>>> execute(int seriesId) {
    return repository.getSeason(seriesId);
  }
}
