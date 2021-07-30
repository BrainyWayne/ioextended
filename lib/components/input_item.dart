import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  /// This is the custom built Textfield component
  InputField(
      {required this.name,
      this.suffixIcon,
      this.textEditingController,
      this.errorMessage = '',
      this.maxLines,
      this.minLines,
      this.borderColor = Colors.green,
      this.initialValue,
      this.maxLength,
      this.hint,
      required this.onChanged,
      this.inputFormatters = const [],
      this.obscureText,
      this.keyboardType = TextInputType.text});

  final String name;
  final Widget? suffixIcon;
  final Function(String) onChanged;
  final String errorMessage;
  final String? hint;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;

  final TextEditingController? textEditingController;
  final Color borderColor;
  final String? initialValue;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        TextFormField(
          maxLength: maxLength ?? null,
          controller: textEditingController,
          inputFormatters: inputFormatters,
          initialValue: initialValue,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? 10,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          style: theme.textTheme.bodyText1,
          onChanged: onChanged,
          decoration: InputDecoration(
              isDense: true,
              hintText: name,
              hintStyle: Theme.of(context).textTheme.bodyText1,
              contentPadding: const EdgeInsets.all(8),
              prefixIcon: Prefix(prefixIcon: suffixIcon ?? Icon(Icons.edit)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor),
              )),
        ),
        errorMessage != ''
            ? Text(
                errorMessage,
                style: theme.textTheme.bodyText2!.copyWith(color: Colors.red),
              )
            : Container(),
      ],
    );
  }
}

class Prefix extends StatelessWidget {
  const Prefix({Key? key, required this.prefixIcon}) : super(key: key);
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: prefixIcon,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 50, minHeight: 28),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 1,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
