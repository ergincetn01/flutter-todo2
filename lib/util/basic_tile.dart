import 'package:hive/hive.dart';

class BasicTile {
  final String title;
  final bool isDone;
  final bool isChild;
  // final List<BasicTile> tiles;

  const BasicTile(
      {required this.title, required this.isDone, required this.isChild});
}

final basicTiles = <BasicTile>[];

class BasicTileAdapter extends TypeAdapter<BasicTile> {
  @override
  int get typeId => 0; // Unique ID for the adapter

  @override
  BasicTile read(BinaryReader reader) {
    final title = reader.readString();
    final isDone = reader.readBool();
    final isChild = reader.readBool();
// final tiles = reader.readList(_tiles.length);
// The argument type 'List<dynamic>' can't be assigned to the parameter type 'List<BasicTile>'
    return BasicTile(title: title, isDone: isDone,isChild: isChild);
    //tiles: "tiles:" part must be matched with read. ... value
  }

  @override
  void write(BinaryWriter writer, BasicTile obj) {
    writer.writeString(obj.title);
    writer.writeBool(obj.isDone);
    writer.writeBool(obj.isChild);
    // writer.writeList(obj.tiles);
  }
}
