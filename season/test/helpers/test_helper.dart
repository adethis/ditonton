import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:season/data/datasources/season_remote_data_source.dart';
import 'package:season/domain/repositories/season_repository.dart';

@GenerateMocks([
  SeasonRepository,
  SeasonRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
