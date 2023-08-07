import 'package:flutter/cupertino.dart';

sealed class AppSized {
  static SizedBox sized(BuildContext context, {double? width, double? height}) {
    return SizedBox(
      width: width != null ? MediaQuery.sizeOf(context).width * width : null,
      height: height != null ? MediaQuery.sizeOf(context).height * height : null,
    );
  }
}