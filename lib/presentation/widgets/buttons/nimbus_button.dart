import 'package:flutter/material.dart';
import 'package:nornknie_web/presentation/layout/adaptive.dart';
import 'package:nornknie_web/values/values.dart';
import 'package:url_launcher/link.dart';

class NimbusButton extends StatelessWidget {
  NimbusButton({
    required this.buttonTitle,
    this.width = Sizes.WIDTH_150,
    this.height = Sizes.HEIGHT_60,
    this.titleStyle,
    this.titleColor = AppColors.white,
    this.buttonColor = AppColors.violet,
    this.onPressed,
    this.padding = const EdgeInsets.all(Sizes.PADDING_8),
    this.opensUrl = false,
    this.url = "",
    this.linkTarget = LinkTarget.blank,
  });

  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String buttonTitle;
  final TextStyle? titleStyle;
  final Color titleColor;
  final Color buttonColor;

  final EdgeInsetsGeometry padding;
  final String url;
  final LinkTarget linkTarget;
  final bool opensUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: MaterialButton(
        minWidth: width,
        height: height,
        onPressed: opensUrl ? () {} : onPressed,
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: padding,
          child: buildChild(context),
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double textSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_14,
      Sizes.TEXT_SIZE_16,
      md: Sizes.TEXT_SIZE_15,
    );
    if (opensUrl) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Link(
          uri: Uri.parse(url),
          target: linkTarget,
          builder: (context, followLink) {
            return GestureDetector(
              onTap: followLink,
              child: Text(
                buttonTitle,
                style: titleStyle ??
                    textTheme.button?.copyWith(
                      color: titleColor,
                      fontSize: textSize,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            );
          },
        ),
      );
    } else {
      return Text(
        buttonTitle,
        style: titleStyle ??
            textTheme.button?.copyWith(
              color: titleColor,
              fontSize: textSize,
              letterSpacing: 1.1,
              fontWeight: FontWeight.bold,
            ),
      );
    }
  }
}
