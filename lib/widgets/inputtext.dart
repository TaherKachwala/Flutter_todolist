// ignore_for_file: must_be_immutable

// import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:flutter_svg/svg.dart';

class InputText extends StatefulWidget {
  InputText({
    super.key,
    this.textEditingController,
    required this.title,
    required this.onPressed,
    this.onChanged,
    this.width = 300,
    this.height = 40,
    this.widthMain = 120,
    this.heightMain = 80,
    this.textWidth = 80,
    this.hintText = "",
    this.svgPath = "",
    this.maxLines = 1,
    required this.icon,
    this.showIcon = true,
    this.readOnly = false,
    this.titleOff = false,
    this.numberOnly = false,
  });

  final TextEditingController? textEditingController;
  final Function onPressed;
  final ValueChanged? onChanged;
  final String title;
  final String hintText;
  final String svgPath;
  final IconData icon;
  bool showIcon, readOnly, titleOff, numberOnly;
  int maxLines;
  double height, heightMain, width, widthMain, textWidth;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widthMain,
      height: widget.heightMain,
      child: GestureDetector(
        onTap: () => widget.onPressed(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.titleOff
                  ? SizedBox(
                      height: 0,
                    )
                  : Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
              Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(width: 0.4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: widget.textWidth,
                        child: TextField(
                          // key: UniqueKey(),
                          readOnly: widget.readOnly,
                          controller: widget.textEditingController,
                          keyboardType: widget.numberOnly
                              ? TextInputType.number
                              : TextInputType.text,
                          inputFormatters: [
                            widget.numberOnly
                                ? FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'))
                                : FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z0-9 ]")),
                          ],
                          onChanged: widget.onChanged,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black38),
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.only(left: 8),
                            hintText: widget.hintText,
                          ),
                        )),

                    // widget.showIcon
                    //     ? Icon(widget.icon)
                    //     : Opacity(opacity: 0.5,child: SvgPicture.asset(widget.svgPath,fit: BoxFit.contain,height: 24)),

                    // Text("1", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ]),
     ),
);
}
}
