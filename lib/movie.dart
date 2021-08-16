import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'movie.g.dart';

@HiveType(typeId: 0)
class MovieFields{

  @HiveField(0)
  String moviename;

  @HiveField(1)
  String moviedesc;

  @HiveField(2)
  Uint8List movieimage;

  MovieFields({ this.moviename,this.moviedesc,this.movieimage});

}