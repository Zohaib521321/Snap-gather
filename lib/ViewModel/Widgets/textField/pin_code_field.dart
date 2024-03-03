import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:flutter/material.dart';

class PinCodeField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PinCodeField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
            (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: ColorUtils.pinkShade,
              controller: _createSubController(index),
              validator: validator,
              onChanged: (value) {
                _handlePinCodeChange(context, index, value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorUtils.lightGrey,
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController _createSubController(int index) {
    return TextEditingController(
      text: controller.text.length > index ? controller.text[index] : '',
    );
  }

  void _handlePinCodeChange(BuildContext context, int index, String value) {
    if (value.isNotEmpty) {
      controller.text = controller.text.padLeft(index, '0') + value;
    }
    if (index < 3 && value.isNotEmpty) {
      FocusScope.of(context).nextFocus();
    }
  }
}
