import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../checkbox_list.dart';
import 'checkbox_list_view.dart';

class CheckboxListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CheckboxListPage');

    return BlocProvider(
      create: (context) => CheckboxListBloc(CheckboxItemRepository().list),
      child: CheckboxListView(),
    );
    // return BlocProvider(
    //   create: (context) => FilteredListBloc(CheckboxItemRepository().list),
    //   child: CheckboxListView(),
    // );
  }
}
