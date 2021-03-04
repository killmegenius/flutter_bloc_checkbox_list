part of 'checkbox_list_bloc.dart';

@immutable
abstract class CheckboxListState {
  final UnmodifiableListView<CheckboxItem> list;

  const CheckboxListState(this.list);
}

class CheckboxListInitial extends CheckboxListState {
  CheckboxListInitial(UnmodifiableListView<CheckboxItem> list) : super(list);
}

class CheckboxCheckedAll extends CheckboxListState {
  CheckboxCheckedAll(UnmodifiableListView<CheckboxItem> list) : super(list);
}
