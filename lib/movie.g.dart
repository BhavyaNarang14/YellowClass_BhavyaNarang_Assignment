// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieFieldsAdapter extends TypeAdapter<MovieFields> {
  @override
  final int typeId = 0;

  @override
  MovieFields read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieFields(
      moviename: fields[0] as String,
      moviedesc: fields[1] as String,
      movieimage: fields[2] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, MovieFields obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.moviename)
      ..writeByte(1)
      ..write(obj.moviedesc)
      ..writeByte(2)
      ..write(obj.movieimage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieFieldsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
