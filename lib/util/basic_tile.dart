import 'package:hive/hive.dart';

class BasicTile {
  final String title;
  final bool isDone;
  final List<BasicTile> tiles;

  const BasicTile(
      {required this.title, required this.isDone, this.tiles = const []});
}

final basicTiles = <BasicTile>[];

class BasicTileAdapter extends TypeAdapter<BasicTile> {
  @override
  int get typeId => 0; // Unique ID for the adapter

  @override
  BasicTile read(BinaryReader reader) {
    final title = reader.readString();
    final isDone = reader.readBool();
    final tiles = reader.readList();

    return BasicTile(title: title, isDone: isDone, tiles: basicTiles);
  }

  @override
  void write(BinaryWriter writer, BasicTile obj) {
    writer.writeString(obj.title);
    writer.writeBool(obj.isDone);
    writer.writeList(obj.tiles);
  }
}
