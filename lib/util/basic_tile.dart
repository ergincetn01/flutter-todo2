import 'package:hive/hive.dart';

class BasicTile {
  final String title;
  late bool isDone;
  // final bool isChild;

  BasicTile(
      {required this.title, required this.isDone, 
      // required this.isChild
      });
}

final basicTiles = <BasicTile>[];

class BasicTileAdapter extends TypeAdapter<BasicTile> {
  @override
  int get typeId => 0;

  @override
  BasicTile read(BinaryReader reader) {
    final title = reader.readString();
    final isDone = reader.readBool();
    // final isChild = reader.readBool();

    return BasicTile(title: title, isDone: isDone);
  }

  @override
  void write(BinaryWriter writer, BasicTile obj) {
    writer.writeString(obj.title);
    writer.writeBool(obj.isDone);
    // writer.writeBool(obj.isChild);

  }
}
