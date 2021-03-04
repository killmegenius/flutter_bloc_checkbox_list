part of 'checkbox_list_bloc.dart';

@immutable
abstract class CheckboxListEvent {}

class ToggleCheckbox extends CheckboxListEvent {
  final int id;
  final bool value;

  ToggleCheckbox(this.id, this.value)
      : assert(id != null),
        assert(value != null);
}

class ToggleAll extends CheckboxListEvent {}

class Sort extends CheckboxListEvent {}
