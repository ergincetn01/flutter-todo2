import 'package:flutter/material.dart';
import 'package:todo2/util/basic_tile.dart';

  Widget buildTile(BasicTile tile){
    if(tile.tiles.isEmpty){
      return ListTile();
    }
    else {
      return ExpansionTile(title: Text(tile.title));
    }
  }
  