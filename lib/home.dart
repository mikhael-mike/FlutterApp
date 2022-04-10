import 'package:flutter/material.dart';
import 'package:quizapp/model/movie.dart';
import 'package:quizapp/util/hexColor.dart';

// MovieApp code
class MovieView extends StatelessWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Movie> movieList = Movie.getMovies();

    final List movies = [
      'Titanic',
      'Blade runner',
      'hello',
      'Rambo',
      'The avengers',
      'Avatar',
      'I am legend',
      '300',
      'The wold of wall street',
      'Instellator',
      'Game of thrones',
      'Vikings',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Name'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: <Widget>[
              MovieCard(movieList[index], context),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0])),
            ]);
            // return Card(
            //   elevation: 4.5,
            //   color: Colors.white,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       child: Container(
            //         width: 200,
            //         height: 200,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: NetworkImage(movieList[index].images[0]),
            //             fit: BoxFit.cover
            //           ),
            //           borderRadius: BorderRadius.circular(13.5),
            //           color: Colors.blue
            //         ),
            //         child: null,
            //       ),
            //     ),
            //     trailing: Text('...'),
            //     title: Text(movieList[index].title),
            //     subtitle: Text('${movieList[0].title}'),
            //     onTap: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListViewDetails(
            //         movieName: movieList.elementAt(index).title,
            //         movie: movieList[index],
            //         )));
            //     }
            //   ),
            // );
          }),
    );
  }

  Widget MovieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      Text(
                        'Raiting: ${movie.imdbRating} / 10',
                        style: TextStyle(color: Colors.grey, fontSize: 17.0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Released: ${movie.released}',
                          style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MovieListViewDetails(movieName: movie.title, movie: movie))),
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 15.0, color: Colors.grey);
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imageUrl ??
                'http://ia.media-imdb.com/images/M/MV5BMTU4NzMyNDk1OV5BMl5BanBnXkFtZTcwOTEwMzU1MQ@@._V1_SX300.jpg'),
            fit: BoxFit.cover,
          )),
    );
  }
}

// new page
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails(
      {Key? key, required this.movieName, required this.movie})
      : super(key: key);

  // const MovieListViewDetails({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
        backgroundColor: Colors.blueGrey.shade400,
      ),
      body: ListView(
        children: <Widget>[
          // thumbdetailImage
          MovieDetailsThunmbail(thunmbail: movie.images[0]),
          MovieDetailsHeaderPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsExtraPoster(posters: movie.images),
        ],
      ),
      // body: Center(
      //   child: Container(
      //     child: RaisedButton(
      //       child: Text('Go back: ${this.movie.director}'),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}

class MovieDetailsThunmbail extends StatelessWidget {
  final String thunmbail;

  const MovieDetailsThunmbail({Key? key, required this.thunmbail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(thunmbail),
                fit: BoxFit.cover,
              )),
            ),
            Icon(
              Icons.play_circle_filled_outlined,
              size: 100,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 80,
        )
      ],
    );
  }
}

class MovieDetailsHeaderPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderPoster({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: MovieDetailsHeader(
              movie: movie,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${movie.year} . ${movie.genre}'.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.cyan,
          ),
        ),
        Text(
          '${movie.title}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
        ),
        Text.rich(TextSpan(
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
            children: <TextSpan>[
              TextSpan(text: movie.plot),
              TextSpan(
                  text: 'More...',
                  style: TextStyle(
                    color: Colors.indigoAccent,
                  )),
            ])),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Container(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          MovieField(field: 'Cast', value: movie.actors),
          MovieField(field: 'Directors', value: movie.director),
          MovieField(field: 'Awards', value: movie.awards),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key? key, required this.field, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${field}',
          style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w300,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsExtraPoster extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsExtraPoster({Key? key, required this.posters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'More movie poster',
          style: TextStyle(fontSize: 14, color: Colors.black26),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8,),
              itemCount: posters.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(posters[index]),
                    fit: BoxFit.cover)
                  ),
                ),
              ),
              ),
        )
      ],
    );
  }
}

// BillSpinter code
class BillSplinter extends StatefulWidget {
  const BillSplinter({Key? key}) : super(key: key);

  @override
  State<BillSplinter> createState() => _BillSplinterState();
}

class _BillSplinterState extends State<BillSplinter> {
  int _tipPersonAge = 0;
  int _personCounter = 0;
  double _billAmount = 0.0;

  Color _purple = HexColor('#6908D6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1), //Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.5),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Total per person'),
                    Text('\$ 123'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      prefixText: 'Bill AMount',
                      prefixIcon: Icon(Icons.monetization_on_sharp),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Splittt',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                }
                                {
                                  // do something
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                              color: _purple,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                // if(_personCounter >= 0) {
                                //   _personCounter++;
                                //   debugPrint('clicked $_personCounter');
                                // }
                                _personCounter++;
                                //it's right what we have in top its my code
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    color: _purple,
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
