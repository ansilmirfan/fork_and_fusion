import 'package:flutter/material.dart';

class CustomeTextField extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  Icon? prefixIcon;
  void Function(String)? onChanged;
  bool obsuceText;
  bool suffixIcon;
  bool search;
  bool doubleLine;

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
  });

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  String? Function(String?)? validator;

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
            height: widget.doubleLine ? 90 : 50,
            child: TextFormField(
              onChanged: widget.onChanged,
              validator: validator,
              controller: widget.controller,
              obscureText: widget.obsuceText,
              maxLines: widget.doubleLine ? 2 : 1,
              //--------text style--------------
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black, fontSize: 20),
              //-----------input decoration----------------
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 15.0,
                  bottom: 15.0,
                ),
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.grey, fontSize: 17),
                border: InputBorder.none,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                prefixIconColor: Theme.of(context).colorScheme.inversePrimary,
                suffixIconColor: Theme.of(context).colorScheme.inversePrimary,
                //-----------suffix icon---------------------
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
              ),
            ),
          ),
        );
      },
    );
  }
}
