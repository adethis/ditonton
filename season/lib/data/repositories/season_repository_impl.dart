import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:season/data/datasources/season_remote_data_source.dart';
import 'package:season/domain/entities/season.dart';
import 'package:season/domain/entities/season_detail.dart';
import 'package:season/domain/repositories/season_repository.dart';

class SeasonRepositoryImpl implements SeasonRepository {
  final SeasonRemoteDataSource remoteDataSource;

  SeasonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Season>>> getSeason(int seriesId) async {
    try {
      final result = await remoteDataSource.getSeason(seriesId);
      return Right(result.map((data) => data.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
    int seriesId,
    int seasonNumber,
  ) async {
    try {
      final result = await remoteDataSource.getSeasonDetail(
        seriesId,
        seasonNumber,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
