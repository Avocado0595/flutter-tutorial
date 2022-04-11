// ignore_for_file: unnecessary_const

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/movie.dart';
import 'package:flutter_tutorial/models/question.dart';
import 'package:flutter_tutorial/util/hexcolor.dart';

class MovieListView extends StatelessWidget {
  MovieListView({Key? key}) : super(key: key);
  final List<Movie> movies = Movie.getMovie();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie"),
          backgroundColor: Colors.blueGrey.shade500,
        ),
        backgroundColor: Colors.blueGrey.shade500,
        body: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Stack(children: [
                movieCard(movies[index], context),
                Positioned(
                    top: 5,
                    left: 4,
                    child: movieImage(movies[index].images[0])),
              ]);
              // return Card(
              //   elevation: 4.5,
              //   color: Colors.white,
              //   child: ListTile(
              //     title: Text(movies[index].title),
              //     subtitle: Text(movies[index].plot),
              //     leading: CircleAvatar(
              //       child: Container(
              //         width: 300,
              //         height: 300,
              //         child: null,
              //         decoration: BoxDecoration(
              //             image: DecorationImage(
              //                 image: NetworkImage(movies[index].images[0]),
              //                 fit: BoxFit.cover),
              //             borderRadius: BorderRadius.circular(13.9)),
              //       ),
              //     ),
              //     trailing: Text("..."),
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) {
              //         return MovieDetail(
              //           movie: movies[index],
              //         );
              //       }));
              //     },
              //   ),
              // );
            }));
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.only(left: 50),
          width: MediaQuery.of(context).size.width,
          height: 108.0,
          child: Card(
            color: Colors.black45,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 58, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(movie.title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70)),
                      ),
                      Text("Rating: ${movie.imdbRating}/10",
                          style: mainTextStyle())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Released: ${movie.released}",
                          style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated, style: mainTextStyle())
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MovieDetail(
              movie: movie,
            );
          }));
        });
  }

  TextStyle mainTextStyle() {
    return TextStyle(color: Colors.grey.shade500);
  }

  Widget movieImage(String imgUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imgUrl ??
                  "https://images-na.ssl-images-amazon.com/images/M/MV5BMTcxOTQ3NTA5N15BMl5BanBnXkFtZTgwMzExMDUxODE@._V1_SY1000_SX1500_AL_.jpg"),
              fit: BoxFit.cover)),
    );
  }
}

//new screen
class MovieDetail extends StatelessWidget {
  //MovieDetail({Key? key}) : super(key: key);

  final Movie movie;

  const MovieDetail({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: ListView(children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailPoster(movie: movie),
          MovieDetailCast(movie: movie)
        ]));
  }
}

class MovieDetailCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textSpanDetail("Cast", movie.actor),
          textSpanDetail("Directors", movie.director),
          textSpanDetail("Awards", movie.awards),
        ],
      ),
    );
  }
}

final textSpanDetail = (String role, String listName) => Text.rich(TextSpan(
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        children: <TextSpan>[
          TextSpan(text: "${role}: ", style: TextStyle(color: Colors.grey)),
          TextSpan(text: listName),
        ]));

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key? key, required this.thumbnail})
      : super(key: key);
  // const MovieDetailsThumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumbnail), fit: BoxFit.cover),
              )),
          Icon(Icons.play_circle_outline, size: 100, color: Colors.white)
        ]),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        )
      ],
    );
  }
}

class MovieDetailPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailPoster({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            MoviePoster(poster: movie.images[0].toString()),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: MovieDetailsHeader(movie: movie),
            )
          ],
        ));
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${movie.year} . ${movie.genre}".toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan)),
        Text("${movie.title}",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500)),
        Text.rich(TextSpan(
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(text: movie.plot),
              TextSpan(
                  text: " More...", style: TextStyle(color: Colors.indigo)),
            ]))
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key? key, required this.poster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(8));
    return Card(
        child: ClipRRect(
            borderRadius: borderRadius,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(poster), fit: BoxFit.cover),
              ),
            )));
  }
}

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentIdx = 0;

  List questionBank = [
    Question.name(
        "Your posts, along with that of my colleague Charles Moylan (but let's start with you, Charles), have some insightful comments.",
        true),
    Question.name(
        "Your posts, along with that of qweqwew qeqwwqe),a b have some insightful comments.",
        false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Center(child: Text("True Citizen")),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Image.asset(
              "images/flag.png",
              width: 200,
              height: 180,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blueGrey.shade400,
                )),
            child: Text(
              questionBank[_currentIdx].questionText,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _prevQuestion,
                child: Icon(Icons.arrow_back),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.blueGrey.shade900)),
              ),
              ElevatedButton(
                onPressed: questionBank[_currentIdx].userResult == null
                    ? () => _checkAnswer(true)
                    : null,
                child: const Text("TRUE"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.blueGrey.shade900)),
              ),
              ElevatedButton(
                onPressed: questionBank[_currentIdx].userResult == null
                    ? () => _checkAnswer(false)
                    : null,
                child: const Text("FALSE"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.blueGrey.shade900)),
              ),
              ElevatedButton(
                onPressed: () {
                  _nextQuestion();
                },
                child: Icon(Icons.arrow_forward),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.blueGrey.shade900)),
              ),
            ],
          )
        ]),
      ),
    );
  }

  _checkAnswer(bool answer) {
    var result = questionBank[_currentIdx].result == answer;
    _showSnackBar(result);
    setState(() {
      questionBank[_currentIdx].userResult = result;
    });
  }

  _nextQuestion() {
    setState(() {
      _currentIdx = (_currentIdx + 1) % questionBank.length;
    });
  }

  void _prevQuestion() {
    setState(() {
      _currentIdx = _currentIdx < 1 ? questionBank.length - 1 : _currentIdx - 1;
    });
  }

  _showSnackBar(bool isTrue) {
    var snackBar = SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: isTrue ? Colors.green.shade500 : Colors.red.shade500,
      content: Text(isTrue ? "That's right!" : "That's wrong!"),
      action: SnackBarAction(
        label: 'Hide me!',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _BillSplitterState extends State<BillSplitter> {
  //init variables
  int _tipPercent = 0;
  int _personCounter = 1;
  double _billAmount = 0;
  Color _purple = HexColor("#6908D6");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.vertical, //scroll when open keyboard
        padding: EdgeInsets.all(20.5),
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: _purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Per Person",
                      style: TextStyle(
                          color: _purple.withOpacity(1), fontSize: 17)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "\$${calcTotalPerPerson(_tipPercent, _personCounter, _billAmount)}",
                      style: TextStyle(
                          color: _purple.withOpacity(1),
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount ",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (e) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 17)),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                child: Text("-",
                                    style: TextStyle(
                                        color: _purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                              ),
                            ),
                          ),
                          Text("$_personCounter",
                              style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                child: Text("+",
                                    style: TextStyle(
                                        color: _purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tip",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 17)),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "\$${(_tipPercent * _billAmount / 100).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: _purple.withOpacity(1),
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        )
                      ]),
                  //Slider
                  Column(
                    children: [
                      Text("${_tipPercent}%",
                          style: TextStyle(
                              color: _purple,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      Slider(
                        value: _tipPercent.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 10,
                        onChanged: (double value) {
                          setState(() {
                            _tipPercent = value.round();
                          });
                        },
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    ));
  }

  calcTotalPerPerson(int tipPercent, int personCounter, double billAmount) {
    if (billAmount < 0) return 0;
    return (billAmount * (tipPercent / 100 + 1) / personCounter)
        .toStringAsFixed(2);
  }
}

class Wisdom extends StatefulWidget {
  const Wisdom({Key? key}) : super(key: key);

  @override
  State<Wisdom> createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;
  List quotes = [
    "asdadasdaqwewqeqweqeqweqweqweqweqweqweqweqweqweqwwqwddadasasdasdasdasdadsadasdasdsads",
    "dasdasddd",
    "ooooooo",
    "99999",
    "11111111"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 400,
              height: 300,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 184, 255, 249),
                  boxShadow: const [
                    const BoxShadow(
                      color: Colors.black38,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    const BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ]),
              child: Text(quotes[_index])),
          GestureDetector(
            child: Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 66, 194, 255)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50))),
                  onPressed: _showQuote,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wb_sunny, color: Colors.black),
                        Text("Inspire me!",
                            style: TextStyle(color: Colors.black))
                      ]),
                )),
          )
        ],
      ),
    ));
  }

  void _showQuote() {
    setState(() {
      _index = (_index + 1) % (quotes.length);
    });
  }
}

class BizCard extends StatelessWidget {
  const BizCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BizCard"),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[_getCard(), _getAvatar()],
          ),
        ));
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(50),
      decoration: BoxDecoration(
          color: Colors.pinkAccent, borderRadius: BorderRadius.circular(14.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Thanh Xuân",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          Text("1234567890"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.person_outline), Text("thanhxuan123")],
          )
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: Colors.redAccent, width: 1.2),
          image: DecorationImage(
              image: NetworkImage("https://picsum.photos/500/500"),
              fit: BoxFit.cover)),
    );
  }
}
