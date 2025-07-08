import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';

/// This [IconWidget] class is responsible for creating an icon used in the app.
class IconWidget extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final bool? hasBackground;

  const IconWidget(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.padding,
    this.hasBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    // This build logic was used to avoid the padding when your
    // value is null
    Icon iconBuild() {
      return Icon(
        icon,
        size: size,
        color: color,
      );
    }

    if (hasBackground!) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusBig),
          color: color?.withAlpha(30),
        ),
        child: padding != null
            ? Padding(
                padding: padding!,
                child: iconBuild(),
              )
            : iconBuild(),
      );
    } else {
      if (padding != null) {
        return Padding(
          padding: padding!,
          child: iconBuild(),
        );
      } else {
        return iconBuild();
      }
    }
  }
}