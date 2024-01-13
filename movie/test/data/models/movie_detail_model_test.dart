import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_model.dart';

void main() {
  const tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [GenreModel(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: true,
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be return JSON map containing proper data', () async {
    final result = tMovieDetailModel.toJson();

    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": 'backdropPath',
      "budget": 1,
      "genres": [
        {'id': 1, 'name': 'name'}
      ],
      "homepage": 'homepage',
      "id": 1,
      "imdb_id": 'imdbId',
      "original_language": 'originalLanguage',
      "original_title": 'originalTitle',
      "overview": 'overview',
      "popularity": 1.0,
      "poster_path": 'posterPath',
      "release_date": 'releaseDate',
      "revenue": 1,
      "runtime": 1,
      "status": 'status',
      "tagline": 'tagline',
      "title": 'title',
      "video": true,
      "vote_average": 1.0,
      "vote_count": 1,
    };

    expect(result, expectedJsonMap);
  });
}
