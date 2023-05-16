import 'dart:convert';

import 'package:http/http.dart';
import 'package:tmdb_movie_app/models/movie_details_model.dart';
import 'package:tmdb_movie_app/models/movies_model.dart';

class ApiService {
  final apiKey = "api_key=a803617875904ce5a08809481285cb29";
  final popular = "https://api.themoviedb.org/3/movie/popular?";

  // get popular movies

  Future<List<Movie>> getMovies({required int pageNo}) async {
    // send request
    Response response = await get(Uri.parse("$popular$apiKey&page=$pageNo"));
    // check response status
    if (response.statusCode == 200) {
      // extract response from the body
      Map<String, dynamic> body = jsonDecode(response.body);
      // extract result from body
      List<dynamic> data = body["results"];
      // map to Movie model
      List<Movie> movies = data.map((movie) => Movie.fromJson(movie)).toList();

      return movies;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<MovieDetailsModel> getDetails({required String id}) async {
    Response response =
        await get(Uri.parse("https://api.themoviedb.org/3/movie/$id?$apiKey"));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(json);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
