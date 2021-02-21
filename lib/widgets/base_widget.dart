import 'package:flutter/material.dart';

TextStyle lTextStyle({
  Color color,
  double size,
  bool bold,
}) {
  size ??= 14;
  bold ??= false;
  color ??= Colors.black;
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
  );
}

Widget lText(
  String text, {
  Color color,
  double size,
  bool bold,
  TextOverflow overflow,
}) {
  size ??= 14;
  bold ??= false;
  color ??= Colors.black;
  return Text(
    '$text',
    overflow: overflow,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}

Widget lHeight(double height) {
  height ??= 10;
  return SizedBox(height: height);
}

Widget lWidth(double width) {
  width ??= 10;
  return SizedBox(width: width);
}

Widget lBlank() {
  return Container();
}

Widget lExpanded({int flex, Widget child}) {
  flex ??= 1;
  child ??= Container();
  return Expanded(flex: flex, child: Center(child: child));
}

Widget lTextField({
  String hintText,
  double padding,
  Function(String) onChanged,
  Function(String) onSubmitted,
  TextInputType keyboardType,
}) {
  hintText ??= '请输入...';
  padding ??= 10;
  onChanged ??= (_) {};
  onSubmitted ??= (_) {};
  keyboardType ??= TextInputType.number;
  return Container(
    child: TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(padding),
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget lButton(
  String text, {
  void Function() onTap,
  double height,
  double fontSize,
  double width,
  double radius,
  Color colorText,
  Color colorBg,
}) {
  height ??= 30;
  width ??= height * 2 / 0.7;
  radius ??= height / 2;
  fontSize ??= 14;
  colorText ??= Colors.black;
  colorBg ??= Colors.grey[100];
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: colorBg,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(radius))),
      child: lText(text,
          color: colorText ?? Colors.black, size: fontSize, bold: true),
    ),
  );
}

Widget lIconButton(
  IconData icon, {
  double size,
  Color color,
  Function onTap,
}) {
  size ??= 36;
  color ??= Colors.white;
  return IconButton(
    iconSize: size,
    icon: Icon(
      icon,
      size: size,
      color: color,
    ),
    onPressed: onTap,
  );
}
