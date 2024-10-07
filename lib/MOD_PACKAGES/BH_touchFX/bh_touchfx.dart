import 'package:flutter/material.dart';

/// SECTION - BHTouchEffect
/// 터치할때 들어가는 것 같은 시각적 효과를 주는 기능 세트.
///
/// touch effect wrapper widget.
/// 아무 위젯이나 감싸면 터치 효과를 줄 수 있음.
/// NOTE: 그러나 ListTile과 같은 위젯은 자주 쓰이므로 코드의 간결함을 위해 따로 구현되어 있음.
class BHTouchEffectWrapper extends StatefulWidget {
  final Widget child;
  final Color? $clickedColor;
  const BHTouchEffectWrapper({Key? key, required this.child, this.$clickedColor}) : super(key: key);

  @override
  BHTouchEffectWrapperState createState() => BHTouchEffectWrapperState();
}

class BHTouchEffectWrapperState extends State<BHTouchEffectWrapper> with SingleTickerProviderStateMixin {
  static double __scale = 1;
  Color? _$clickedColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _$clickedColor = widget.$clickedColor ?? Colors.grey.withAlpha(50);
    return GestureDetector(
      onPanEnd: (details) {
        setState(() {
          __scale = 1;
        });
      },
      onPanDown: (details) {
        setState(() {
          __scale = 0.95;
        });
      },
      onPanCancel: () {
        setState(() {
          __scale = 1;
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.all(0),
        duration: Duration(milliseconds: (__scale == 0.95) ? 100 : 400),
        curve: (__scale == 0.95) ? Curves.easeOutCirc : Curves.easeOutBack,
        decoration: BoxDecoration(
          color: (__scale == 0.95) ? _$clickedColor : _$clickedColor!.withAlpha(0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: AnimatedScale(
          scale: __scale,
          duration: Duration(milliseconds: (__scale == 0.95) ? 50 : 400),
          curve: (__scale == 0.95) ? Curves.linear : Curves.easeOutBack,
          child: widget.child,
        ),
      ),
    );
  }
}

class BHTouchFXListTile extends ListTile {
  /// Highlight color when tapped.
  final Color? $clickedColor;
  const BHTouchFXListTile({
    Key? key,
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    bool isThreeLine = false,
    bool enabled = true,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    MouseCursor? mouseCursor,
    bool selected = false,
    Color? tileColor,
    Color? focusColor,
    Color? hoverColor,
    Color? selectedTileColor,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minVerticalPadding,
    bool? enableFeedback,
    EdgeInsetsGeometry? contentPadding,
    this.$clickedColor,
  }) : super(
          key: key,
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          isThreeLine: isThreeLine,
          enabled: enabled,
          onTap: onTap,
          onLongPress: onLongPress,
          mouseCursor: mouseCursor,
          selected: selected,
          tileColor: tileColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          selectedTileColor: selectedTileColor,
          shape: shape,
          focusNode: focusNode,
          autofocus: autofocus,
          minVerticalPadding: minVerticalPadding,
          enableFeedback: enableFeedback,
          contentPadding: contentPadding,
        );

  @override
  Widget build(BuildContext context) {
    return BHTouchEffectWrapper(
      $clickedColor: $clickedColor,
      child: super.build(context),
    );
  }
}

class BHTouchFXInkWell extends InkWell {
  /// Highlight color when tapped.
  final Color? $clickedColor;
  const BHTouchFXInkWell({
    Widget? child,
    Key? key,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate,
    GestureLongPressUpCallback? onLongPressUp,
    GestureLongPressEndCallback? onLongPressEnd,
    GestureTapDownCallback? onTapDown,
    GestureTapCancelCallback? onTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    MouseCursor? mouseCursor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool enableFeedback = true,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Brightness? splashFactoryBrightness,
    InteractiveInkFeatureFactory? highlightFactory,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    VoidCallback? onFocusChange,
    bool autofocus = false,
    MaterialStatesController? statesController,
    this.$clickedColor,
  }) : super(
          key: key,
          child: child,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          mouseCursor: mouseCursor,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          excludeFromSemantics: excludeFromSemantics,
          focusNode: focusNode,
          canRequestFocus: canRequestFocus,
          autofocus: autofocus,
          statesController: statesController,
        );

  @override
  Widget build(BuildContext context) {
    return BHTouchEffectWrapper(
      $clickedColor: $clickedColor,
      child: super.build(context),
    );
  }
}
