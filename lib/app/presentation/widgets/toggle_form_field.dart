import 'package:flutter/material.dart';

class ToggleFormField extends FormField<bool> {
  ToggleFormField({
    Key? key,
    required FormFieldSetter<bool> onSaved,
    bool initialValue = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return SizedBox(
              height: 60.0,
              child: IconButton(
                color: Colors.blue,
                icon: state.value!
                    ? const Icon(Icons.check)
                    : const Icon(Icons.check_box_outline_blank),
                onPressed: () {
                  state.didChange(!state.value!);
                },
              ),
            );
          },
        );
}
