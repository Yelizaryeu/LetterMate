// import 'package:core_ui/core_ui.dart';
// import 'package:flutter/material.dart';
//
// class AppButton extends StatefulWidget {
//   final String? image;
//   final TextStyle? textStyle;
//   final String? text;
//   final Widget? childWidget;
//   final Color? color;
//   final double radius;
//   final Color? borderColor;
//   final Color? hoveredBackgroundColor;
//   final double? borderWidth;
//   final Color? overlayColor;
//   final void Function()? onPressed;
//   final bool isDisabled;
//   final bool isLoading;
//
//   const AppButton({
//     super.key,
//     this.color,
//     this.radius = 8,
//     this.text,
//     this.childWidget,
//     this.borderColor,
//     this.borderWidth,
//     this.overlayColor,
//     this.textStyle,
//     this.image,
//     this.onPressed,
//     this.hoveredBackgroundColor,
//     this.isDisabled = false,
//     this.isLoading = false,
//   });
//
//   @override
//   State<AppButton> createState() => _AppButtonState();
// }
//
// class _AppButtonState extends State<AppButton> {
//   bool _isHovered = false;
//
//   void _onHover(bool isHovered) {
//     setState(() {
//       _isHovered = isHovered;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final AppColors colors = AppColors.of(context);
//     Color? backgroundColor;
//     Function()? onTap;
//     Color bordersColor = Colors.transparent;
//     Widget child = widget.text != null ? _textWidget(context) : widget.childWidget ?? const SizedBox.shrink();
//
//     if (widget.isLoading) {
//       backgroundColor = widget.color ?? colors.alizarin50;
//       onTap = null;
//       child = _loadingWidget(child, colors);
//     } else if (widget.isDisabled) {
//       backgroundColor = widget.color ?? colors.alizarin10;
//       onTap = null;
//     } else if (_isHovered) {
//       backgroundColor = widget.hoveredBackgroundColor ?? colors.purpleSand;
//       onTap = widget.onPressed;
//     } else {
//       backgroundColor = widget.color ?? colors.alizarin;
//       onTap = widget.onPressed;
//       bordersColor = (widget.borderColor == null) ? colors.alizarin : widget.borderColor!;
//     }
//
//     return InkWell(
//       onHover: _onHover,
//       onTap: onTap,
//       child: Container(
//         padding: widget.childWidget == null
//             ? const EdgeInsets.symmetric(
//                 horizontal: AppDimens.PADDING_16,
//                 vertical: AppDimens.PADDING_8,
//               )
//             : null,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(widget.radius),
//           border: Border.all(
//             width: (widget.borderWidth == null) ? 0 : widget.borderWidth!,
//             color: bordersColor,
//           ),
//         ),
//         child: Center(child: child),
//       ),
//     );
//   }
//
//   Widget _textWidget(BuildContext context) {
//     return Text(
//       widget.text ?? '',
//       style: widget.textStyle ??
//           AppFonts.normal16.copyWith(
//             color: AppColors.of(context).white,
//           ),
//     );
//   }
//
//   Widget _loadingWidget(Widget child, AppColors colors) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         child,
//         const SizedBox(width: AppDimens.ITEM_SIZE_8),
//         AppLoader(
//           width: AppDimens.ITEM_SIZE_14,
//           height: AppDimens.ITEM_SIZE_14,
//           color: colors.white,
//         ),
//         if (widget.childWidget != null) const SizedBox(width: AppDimens.ITEM_SIZE_8),
//       ],
//     );
//   }
// }
