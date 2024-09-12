import 'package:flutter/material.dart';

class CustomeTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final void Function(String)? onChanged;
  bool obsuceText;
  final bool suffixIcon;
  final bool search;
  final bool doubleLine;
  final String? Function(String?)? validator;

  CustomeTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.onChanged,
    this.obsuceText = false,
    this.suffixIcon = false,
    this.search = false,
    this.doubleLine = false,
    this.validator,
  });

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          child: SizedBox(
            width: constraints.maxWidth * .9,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: widget.onChanged,
              validator: widget.validator,
              controller: widget.controller,
              obscureText: widget.obsuceText,
              maxLines: widget.doubleLine ? 2 : 1,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                  ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 15.0,
                ),
                hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                border: InputBorder.none,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon
                    ? widget.search
                        ? InkWell(
                            onTap: () {
                              widget.controller.clear();
                            },
                            child: const Icon(Icons.close),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                widget.obsuceText = !widget.obsuceText;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color:
                                  widget.obsuceText ? Colors.grey : Colors.blue,
                            ),
                          )
                    : null,
                errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.red,
                      fontSize: 12,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
