import 'package:flutter/material.dart';
import 'package:movie_mania/movie.dart';

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key key, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumbnail), fit: BoxFit.cover),
              ),
            ),
            Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  // colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  colors: [
                Color(0x00f5f5f5),
                Color(0xfff5f5f5),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          height: 70,
        ),
      ],
    );
  }
}

class MovieDetailsPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPoster({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: MovieDetailsHeader(
            movie: movie,
          )),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10.0));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(poster),
            fit: BoxFit.cover,
          )),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          movie.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Text.rich(TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            children: <TextSpan>[
              TextSpan(text: movie.plot),
              TextSpan(text: " More...", style: TextStyle(color: Colors.blue))
            ])),
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;
  const MovieDetailsCast({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Director", value: movie.director),
          MovieField(
            field: "Awards",
            value: movie.awards,
          )
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field, value;
  const MovieField({Key key, this.field, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${field} : ",
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        height: 0.7,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsPosterScroll extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsPosterScroll({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              "More Movie Posters",
              style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(
                width: 5,
              ),
              itemCount: posters.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(posters[index]), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
