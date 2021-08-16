import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhivesample/movie.dart';
import 'package:hive/hive.dart';
import 'add_or_edit_movie_screen.dart';

class MoviesListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoviesListState();
  }
}

class MoviesListState extends State<MoviesListScreen> {
  List<MovieFields> listMovies = [];

  void getMovies() async {
    final box = await Hive.openBox<MovieFields>('movie');
    setState(() {
      listMovies = box.values.toList();
    });
  }

  @override
  void initState() {
    getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Your Movie List"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddOrEditEmployeeScreen(false)));
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
                itemCount: listMovies.length,
                itemBuilder: (context, position) {
                  MovieFields getMovie = listMovies[position];
                  var Director = getMovie.moviedesc;
                  // var age = getMovie.moviedesc;
                  return Card(

                    elevation: 8,
                    child: Container(
                      color: Colors.red[100],
                      height: 220,
                      padding: EdgeInsets.all(15),
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 120, 200, 0),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(getMovie.moviename,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900))),
                          ),
                          CircleAvatar(backgroundImage: MemoryImage(getMovie.movieimage),radius: 60.0,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 45),
                              child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AddOrEditEmployeeScreen(
                                                true, position, getMovie)));
                                  }),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  final box = Hive.box<MovieFields>('movie');
                                  box.deleteAt(position);
                                  setState(() => {
                                    listMovies.removeAt(position)
                                  });
                                }),
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Director: $Director",
                                  style: TextStyle(fontSize: 18))),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
