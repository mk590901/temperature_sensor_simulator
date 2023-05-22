import 'package:flutter/material.dart';

import 'interfaces/i_iterator.dart';

class CustomGridTile {
  CustomGridTile(this.crossAxisCount, this.mainAxisCount, this._widget);

  CustomGridTile add(IIterator iterator) {
    this.iterator = iterator;
    return this;
  }

  Widget widget() {
    return _widget;
  }

  final int crossAxisCount;
  final int mainAxisCount;

  final Widget _widget;
  late  IIterator iterator;


}
