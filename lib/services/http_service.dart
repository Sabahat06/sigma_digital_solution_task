import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sigma_digital_solution/model/movie_detail_model.dart';
import 'package:sigma_digital_solution/model/popular_movie_model.dart';
import 'package:sigma_digital_solution/model/upcoming_movie_model.dart';

class HttpService {

  static Future<PopularMoviesModel?> getPopularMovies() async {
    Uri _uri = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=7426471606c35de8668c3a3fc475203e&language=en-US");
    try {
      var response = await http.get(
        _uri,
      );
      if (response.statusCode == 200) {
        return PopularMoviesModel.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<UpcomingMoviesModel?> getUpcomingMovies() async {
    Uri _uri = Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=7426471606c35de8668c3a3fc475203e&language=en-US");
    try {
      var response = await http.get(
        _uri,
      );
      if (response.statusCode == 200) {
        return UpcomingMoviesModel.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<MovieDetailModel?> getMovieDetail(String movieID) async {
    Uri _uri = Uri.parse("https://api.themoviedb.org/3/movie/${movieID}?api_key=7426471606c35de8668c3a3fc475203e&language=en-US");
    try {
      var response = await http.get(
        _uri,
      );
      if (response.statusCode == 200) {
        return MovieDetailModel.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

}