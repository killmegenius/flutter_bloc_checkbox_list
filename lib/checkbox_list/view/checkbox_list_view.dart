import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../checkbox_list.dart';

class CheckboxListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CheckboxListView');

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox List'),
        actions: [
          _SortButton(),
          _CheckboxIconButton(),
        ],
      ),
      body: _ListView(),
    );
  }
}

class _SortButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.sort),
      onPressed: () {
        context.read<CheckboxListBloc>().add(Sort());
      },
    );
  }
}

class _CheckboxIconButton extends StatelessWidget {
  const _CheckboxIconButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        context.select<CheckboxListBloc, bool>(
                (model) => model.state is CheckboxCheckedAll)
            ? Icons.check_box_outline_blank_outlined
            : Icons.check_box_outlined,
      ),
      onPressed: () {
        context.read<CheckboxListBloc>().add(ToggleAll());
      },
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckboxListBloc, CheckboxListState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) => _CheckboxTile(state.list[index]),
        );
      },
    );
  }
}

class _CheckboxTile extends StatelessWidget {
  final CheckboxItem item;

  const _CheckboxTile(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isChecked = context.select<CheckboxListBloc, bool>((model) =>
        model.state.list.singleWhere((e) => e.id == item.id).isChecked);

    return CheckboxListTile(
      value: isChecked,
      onChanged: (value) {
        context.read<CheckboxListBloc>().add(ToggleCheckbox(item.id, value));
      },
      title: Text(item.title),
    );
  }
}
