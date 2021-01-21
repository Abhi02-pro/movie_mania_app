import 'package:flutter/material.dart';
import 'package:movie_mania/movie_ui.dart';

import 'movie.dart';

void main() {
  runApp(
    new MaterialApp(
      home: MovieList(),
    ),
  );
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("Movies"),
      ),
      backgroundColor: Colors.blueGrey[900],
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                movieCard(movieList[index], context),
                Positioned(
                  top: 10.0,
                  child: movieImage(movieList[index].images[2]),
                ),
              ],
            );
          }),
    );
  }

  Widget movieImage(String imageURL) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            DecorationImage(image: NetworkImage(imageURL), fit: BoxFit.cover),
      ),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 50),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 50.0, right: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Ratings : ${movie.imdbRating} / 10",
                        style: mainTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Released : ${movie.released}",
                        style: mainTextStyle(),
                      ),
                      Text(
                        movie.runtime,
                        style: mainTextStyle(),
                      ),
                      Text(
                        movie.rated,
                        style: mainTextStyle(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                      movie: movie,
                    )));
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(
      color: Colors.grey,
      fontSize: 12,
    );
  }
}

class MovieDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieDetails({Key key, this.movieName, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey[900],
      ),

      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsPosterScroll(posters: movie.images),
        ],
      ),

      // body: Center(
      //   child: RaisedButton(
      //     child: Text("Go Back ${this.movie.director}"),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
    );
  }
}
