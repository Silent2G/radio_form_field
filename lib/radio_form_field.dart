import 'package:flutter/material.dart';

class RadioFormField<T> extends FormField<T> {
  RadioFormField({
    Key? key,
    FormFieldSetter<T>? onSaved,
    required List<T> items,
    T? initialValue,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: (value) {
            if (value == null) {
              return 'Please choose some variant';
            }
            return null;
          },
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (FormFieldState<T> state) {
            return _ListBuilder<T>(
              state: state,
              items: items,
            );
          },
        );
}

class _ListBuilder<T> extends StatelessWidget {
  _ListBuilder({
    Key? key,
    required this.state,
    required this.items,
  }) : super(key: key);

  final FormFieldState<T> state;
  final List<T> items;

  final ScrollController controller = ScrollController();
  void _scrollDown() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  List<Widget> generateItems(FormFieldState<T> state, List<T> items) {
    List<Widget> result = [];

    for (int i = 0; i < items.length; i++) {
      result.add(_ListItem(item: items[i], state: state));
    }

    if (state.hasError == true && state.value == null) {
      result.add(
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            state.errorText!,
            style: TextStyle(
              color: Colors.red[700],
              fontSize: 11.5,
            ),
          ),
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final list = generateItems(state, items);

    return ListView.builder(
      controller: controller,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        if (state.hasError == true && state.value == null) {
          _scrollDown();
        }
        return list[index];
      },
    );
  }
}

class _ListItem<T> extends StatelessWidget {
  const _ListItem({Key? key, required this.item, required this.state})
      : super(key: key);

  final T item;
  final FormFieldState<T> state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.toString()),
      leading: Radio<T>(
        value: item,
        groupValue: state.value,
        onChanged: (T? value) {
          state.didChange(value);
        },
      ),
    );
  }
}
