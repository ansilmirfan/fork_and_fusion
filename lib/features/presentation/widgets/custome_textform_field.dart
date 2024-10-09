// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final void Function(String)? onChanged;
  bool obsuceText;
  final bool obscureIcon;
  void Function()? action;
  final bool search;
  final int multiLine;
  final String? Function(String?)? validator;
  TextInputType? keyboardType;
  String? helperText;
  double width;
  int? maxLength;

  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.onChanged,
    this.obsuceText = false,
    this.obscureIcon = false,
    this.search = false,
    this.multiLine = 1,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.width = .90,
    this.maxLength,
    this.helperText,
    this.action,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            ElevatedContainer(
              padding: 0.0,
              child: SizedBox(
                width: constraints.maxWidth * widget.width,
                child: TextFormField(
                  enabled: false,
                  maxLines: widget.multiLine,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: widget.multiLine == 1 ? 18.0 : 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * widget.width,
              child: TextFormField(
                maxLength: widget.maxLength,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: widget.keyboardType,
                onChanged: widget.onChanged,
                validator: widget.validator,
                controller: widget.controller,
                obscureText: widget.obsuceText,
                maxLines: widget.multiLine,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                decoration: InputDecoration(
                  errorBorder: _errorBorder(context),
                  focusedErrorBorder: _errorBorder(context),
                  helperText: widget.helperText,
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  hintMaxLines: 1,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 15.0,
                  ),
                  hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                  labelText: Utils.capitalizeEachWord(widget.hintText),
                  suffixIcon: widget.search
                      ? _textFieldClearButton(widget.action)
                      : widget.obscureIcon
                          ? _obscureEyeButton()
                          : null,
                  errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                  enabledBorder: _border(),
                  focusedBorder: _border(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  OutlineInputBorder _border() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));
  }

  OutlineInputBorder _errorBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: Constants.radius,
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
    );
  }

  InkWell _obscureEyeButton() {
    return InkWell(
      onTap: () {
        setState(() {
          widget.obsuceText = !widget.obsuceText;
        });
      },
      child: Icon(
        Icons.remove_red_eye,
        color: widget.obsuceText ? Colors.grey : Colors.blue,
      ),
    );
  }

  InkWell _textFieldClearButton(void Function()? action) {
    return InkWell(
      onTap: action,
      child: const Icon(Icons.close),
    );
  }
}
