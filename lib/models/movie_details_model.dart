import 'package:tmdb_movie_app/models/company_model.dart';

class MovieDetailsModel {
  bool? isAdult;
  String? tagline;
  List<Company>? companyList;

  MovieDetailsModel({this.isAdult, this.tagline, this.companyList});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    List<Company> companies = (json['production_companies'] as List)
        .map((comp) => Company.fromJson(comp))
        .toList();

    return MovieDetailsModel(
      isAdult: json['adult'],
      tagline: json['tagline'],
      companyList: companies,
    );
  }
}
