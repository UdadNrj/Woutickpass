import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/custom_Icons.dart';

class CustomIconButton extends StatelessWidget {
  final bool? isNumberValid;
  final String text;
  final VoidCallback onPressed;
  final IconData? iconData;
  final int color;
  final double borderRadius;
  final TextStyle textStyle;
  final double iconSize;
  final Color iconColor;
  final bool showIcon;
  final EdgeInsetsGeometry? padding;

  CustomIconButton({
    this.isNumberValid,
    required this.text,
    required this.onPressed,
    this.iconData,
    this.color = 0xFF000000,
    this.borderRadius = 80,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 14),
    this.iconSize = 14.0,
    this.iconColor = Colors.white,
    this.showIcon = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF202B37),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon && iconData != null)
              CustomIconWidget(
                iconData: iconData!,
                text: text,
                iconSize: iconSize,
                iconColor: iconColor,
                textStyle: textStyle,
              ),
            if (showIcon &&
                iconData !=
                    null) // Separador entre el icono y el texto si el icono se muestra
              const SizedBox(width: 8),
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomValidadButton extends StatelessWidget {
  final bool isNumberValid;
  final String text;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final EdgeInsetsGeometry? padding;

  CustomValidadButton({
    required this.text,
    required this.isNumberValid,
    this.onPressed,
    this.iconData,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = isNumberValid ? const Color(0xFF202B37) : Colors.red;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onPressed != null ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null) Icon(iconData),
            if (iconData != null) SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
