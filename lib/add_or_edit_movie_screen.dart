import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterhivesample/movie.dart';
import 'package:flutterhivesample/movie_list_screen.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddOrEditEmployeeScreen extends StatefulWidget {
  bool isEdit;
  int position;
  MovieFields movieFields;

  AddOrEditEmployeeScreen( this.isEdit,[this.position,this.movieFields]);

  @override
  State<StatefulWidget> createState() {
    return AddEditEmployeeState();
  }
}

class AddEditEmployeeState extends State<AddOrEditEmployeeScreen> {
  Uint8List _currentImageBytes;
  File _currentImage;
  File imageFile;
  bool isImageSelected = false;
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerSalary = new TextEditingController();
  TextEditingController controllerAge = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    if (widget.isEdit) {
      controllerName.text = widget.movieFields.moviename;
      controllerSalary.text = widget.movieFields.moviedesc.toString();
      // controllerAge.text = widget.movieFields.movieimage.toString();
    }

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Movie Name:", style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(controller: controllerName),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Movie Director", style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                            controller: controllerSalary,),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     Text("Employee Age:", style: TextStyle(fontSize: 18)),
                  //     SizedBox(width: 20),
                  //     Expanded(
                  //       child: TextField(
                  //           controller: controllerAge,
                  //           keyboardType: TextInputType.number),
                  //     )
                  //   ],
                  // ),
                  FlatButton(onPressed: () async{
                    try{
                      // final XFile? image = await ImagePicker.pi(source: ImageSource.gallery);
                      final  ImagePicker picker = ImagePicker();
                      final XFile image = await picker.pickImage(source: ImageSource.gallery);
                      _currentImage = File(image.path);
                      _currentImageBytes = await image.readAsBytes();
                      print("\n\nuint8list\n\n$_currentImageBytes");
                      isImageSelected = true;
                    }on Exception catch(e){
                      // setState(() {
                      isImageSelected = false;
                      print("\nisImageSelected:\n$isImageSelected");
                      // });

                    }
                  }, child: Text("Click here to add Movie Poster")),
                  SizedBox(height: 50),
                  RaisedButton(
                    color: Colors.grey,
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () async {
                      var getmovieName = controllerName.text;
                      var getmovieDesc = controllerSalary.text;
                      Uint8List getmovieImage = _currentImageBytes;
                      if (getmovieName.isNotEmpty &&
                          getmovieDesc.isNotEmpty ) {
                        if (widget.isEdit) {
                          MovieFields updateEmployee = new MovieFields(
                              moviename: getmovieName,
                              moviedesc: getmovieDesc,
                              movieimage : getmovieImage,
                            );
                          var box = await Hive.openBox<MovieFields>('movie');
                          box.putAt(widget.position,updateEmployee);
                        } else {
                          MovieFields addEmployee = new MovieFields(
                              moviename: getmovieName,
                              moviedesc: getmovieDesc,
                              movieimage : getmovieImage,
                            );
                          var box = await Hive.openBox<MovieFields>('movie');
                          box.add(addEmployee);
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => MoviesListScreen()),
                                (r) => false);
                      }
                    },
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
