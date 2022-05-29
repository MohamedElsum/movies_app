import 'package:movies_app/core/constants/strings.dart';
import 'package:movies_app/domain/models/upcomingMoviesResponse.dart';
import 'package:dio/dio.dart';

class MoviesWebServices {
  late Dio dio;

  MoviesWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    );
    dio = Dio(options);
  }

  Future<dynamic> getUpcomingMovies() async {
    try {
      Response response = await dio.get(
        'upcoming',
        queryParameters: {
          'api_key': AppConstants.apiKey,
        },
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> getMovieDetails(int movieId) async {
    try {
      Response response = await dio.get(
        '$movieId',
        queryParameters: {
          'api_key': AppConstants.apiKey,
        },
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
