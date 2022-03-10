import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class DefaultButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double height;
  final bool isExpanded;
  final double elevation;
  final double borderRadius;
  final TextStyle? textStyle;
  final ButtonType buttonType;
  final void Function()? onPressed;
  final bool forceEnabling;

  const DefaultButton({
    Key? key,
    this.color,
    this.onPressed,
    this.textStyle,
    this.height = 55,
    this.elevation = 2,
    required this.child,
    this.borderRadius = 16,
    this.isExpanded = false,
    this.buttonType = ButtonType.primary,
    this.forceEnabling = false,
  }) : super(key: key);

  bool get _isPrimary => buttonType == ButtonType.primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = color ?? theme.buttonTheme.colorScheme!.primary;
    final fillColor = _isPrimary ? buttonColor : theme.scaffoldBackgroundColor;
    final textStyle = TextStyle(color: _isPrimary ? Colors.white : buttonColor).merge(this.textStyle);

    return Opacity(
      opacity: (onPressed == null && forceEnabling == false) ? 0.25 : 1,
      child: SizedBox(
        height: height,
        width: isExpanded ? double.infinity : null,
        child: RawMaterialButton(
          elevation: elevation,
          splashColor: color?.withOpacity(.3),
          highlightElevation: elevation + 2,
          onPressed: onPressed,
          fillColor: fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: _isPrimary ? BorderSide.none : BorderSide(color: buttonColor),
          ),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.button!.merge(textStyle),
            child: child,
          ),
        ),
      ),
    );
  }
}
