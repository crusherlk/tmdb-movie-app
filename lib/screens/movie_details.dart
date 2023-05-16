import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/models/movie_details_model.dart';
import 'package:tmdb_movie_app/models/movies_model.dart';
import 'package:tmdb_movie_app/services/api_services.dart';

class MovieDetails extends StatefulWidget {
  Movie movie;
  MovieDetails({required this.movie, super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: FutureBuilder(
      future: service.getDetails(id: widget.movie.id.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MovieDetailsModel data = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${widget.movie.backdropPath.toString()}"))),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.movie.title.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.5,
                        height: size.width * .8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500${widget.movie.posterPath.toString()}"))),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [Text(
                              data.tagline.toString(),
                              style: const TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold),)],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.movie.overview.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Text(
                  "Production Companies",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          data.companyList!.length,
                          (index) => data.companyList![index].logo.toString() ==
                                  ""
                              ? const SizedBox()
                              : Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                            "https://image.tmdb.org/t/p/w500${data.companyList![index].logo}",
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.contain),
                                        Text(
                                          data.companyList![index].name
                                              .toString(),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                )
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
