import 'dart:collection';

import 'package:flutter/material.dart';

class CheckboxItem {
  final int id;
  final String title;
  bool isChecked;

  CheckboxItem({
    @required this.id,
    @required this.title,
    this.isChecked = false,
  })  : assert(id != null),
        assert(title != null),
        assert(isChecked != null);

  CheckboxItem copyWith({int id, String title, bool isChecked}) => CheckboxItem(
        id: id ?? this.id,
        title: title ?? this.title,
        isChecked: isChecked ?? this.isChecked,
      );

  // @override
  // List<Object> get props => [id, title, isChecked];

  @override
  String toString() => 'Todo { id: $id, title: $title, isChecked: $isChecked }';

  CheckboxItem.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          isChecked: json['checked'],
        );
}

class CheckboxItemRepository {
  // final Map<String, bool> _list = {
  //   'First': false,
  //   'Second': false,
  //   'Third': false,
  // };

  final List<String> _list = ['First', 'Second', 'Third'];

  UnmodifiableListView<CheckboxItem> get list {
    final List<CheckboxItem> list = [];
    _list
        .asMap()
        .forEach((id, title) => list.add(CheckboxItem(id: id, title: title)));
    return UnmodifiableListView(list);
  }

  // Future<void> toggleCheckbox(String title) {
  //   _list.update(title, (value) => !value);
  // }
}
