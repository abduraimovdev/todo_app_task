import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

sealed class SvgIcons {
  static SvgPicture edit =
      SvgPicture.asset("assets/icons/svg_ic_edit.svg");
  static SvgPicture fluentDeleteFilled =
      SvgPicture.asset("assets/icons/svg_ic_fluent_delete_filled.svg");
  static SvgPicture fluentLocationFilled =
      SvgPicture.asset("assets/icons/svg_ic_fluent_location_filled.svg");
  static SvgPicture notification =
      SvgPicture.asset("assets/icons/svg_ic_notification.svg");
  static SvgPicture roundAccessTimeFilled =
      SvgPicture.asset("assets/icons/svg_ic_round_access_time_filled.svg");
}

extension SvgExt on SvgPicture {
  SvgPicture copyWith({double? width, double? height, Color? color}) {
    return SvgPicture(
      bytesLoader,
      width: width ?? this.width,
      height: height ?? this.height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : colorFilter,
    );
  }
}
