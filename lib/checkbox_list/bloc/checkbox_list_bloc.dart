import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../checkbox_list.dart';

part 'checkbox_list_event.dart';
part 'checkbox_list_state.dart';

class CheckboxListBloc extends Bloc<CheckboxListEvent, CheckboxListState> {
  CheckboxListBloc(UnmodifiableListView<CheckboxItem> list)
      : super(CheckboxListInitial(list));

  @override
  Stream<CheckboxListState> mapEventToState(
    CheckboxListEvent event,
  ) async* {
    if (event is ToggleCheckbox) {
      yield* _mapCheckboxToggledToState(event);
    } else if (event is ToggleAll) {
      yield* _mapAllToggledToState();
    } else if (event is Sort) {
      yield* _mapSortToState();
    }
  }

  bool get _isAllChecked => state.list.any((item) => item.isChecked == false);

  Stream<CheckboxListState> _mapCheckboxToggledToState(
      ToggleCheckbox event) async* {
    state.list.singleWhere((item) => item.id == event.id).isChecked =
        event.value;
    yield _isAllChecked
        ? CheckboxListInitial(state.list)
        : CheckboxCheckedAll(state.list);
  }

  Stream<CheckboxListState> _mapAllToggledToState() async* {
    final bool isAll = _isAllChecked;
    state.list.map((item) => item.isChecked = isAll).toList();
    yield isAll
        ? CheckboxCheckedAll(state.list)
        : CheckboxListInitial(state.list);
  }

  bool _isSortedUp = true;

  Stream<CheckboxListState> _mapSortToState() async* {
    final List<CheckboxItem> list = state.list.toList();
    if (_isSortedUp) {
      list.sort(
          (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
      _isSortedUp = false;
    } else {
      list.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      _isSortedUp = true;
    }
    final UnmodifiableListView<CheckboxItem> unmod = UnmodifiableListView(list);
    yield _isAllChecked
        ? CheckboxListInitial(unmod)
        : CheckboxCheckedAll(unmod);
  }
}
