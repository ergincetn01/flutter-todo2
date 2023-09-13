import 'package:hive/hive.dart';

class BasicTile {
  final String title;
  late bool isDone;
  final List<BasicTile> tiles;

  BasicTile({
    required this.title,
    required this.isDone,
    this.tiles= const [],
  });
}

final basicTiles = <BasicTile>[];

class BasicTileAdapter extends TypeAdapter<BasicTile> {
  @override
  int get typeId => 0;
  final children = basicTiles.cast<BasicTile>().toList();
  @override
  BasicTile read(BinaryReader reader) {
    final title = reader.readString();
    final isDone = reader.readBool();
    final tiles = reader.read()?.cast<String>();

    return BasicTile(title: title, isDone: isDone, tiles: tiles);
  }

  @override
  void write(BinaryWriter writer, BasicTile obj) {
    writer.writeString(obj.title);
    writer.writeBool(obj.isDone);
    writer.writeList(obj.tiles);
  }
}
