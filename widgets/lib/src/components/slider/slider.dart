import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'slider_enums.dart';
import 'slider_size.dart';
import 'slider_theme.dart';

export 'slider_enums.dart';
export 'slider_size.dart';
export 'slider_theme.dart';

class MechanixSlider extends StatefulWidget {
  const MechanixSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.size = MechanixSliderSize.medium,
    this.direction = Axis.horizontal,
    this.variant = MechanixSliderVariant.standard,
    this.showValueLabel = true,
    this.labelFormatter,
    this.focusNode,
    this.autofocus = false,
    this.theme,
  }) : assert(min <= max),
       assert(value >= min && value <= max),
       assert(divisions == null || divisions > 0);

  /// The currently selected value. Must be between [min] and [max].
  final double value;

  /// Called continuously while the user changes the value.
  ///
  /// If null, the slider is disabled.
  final ValueChanged<double>? onChanged;

  /// Called once when the user starts changing the value.
  final ValueChanged<double>? onChangeStart;

  /// Called once when the user is done changing the value.
  final ValueChanged<double>? onChangeEnd;

  /// The minimum selectable value.
  final double min;

  /// The maximum selectable value.
  final double max;

  /// The number of equal steps the range is split into.
  ///
  /// If null, the slider is continuous. Otherwise the value snaps to the
  /// nearest step and one tick is drawn per step.
  final int? divisions;

  /// The sizing token controlling bar and pointer heights.
  final MechanixSliderSize size;

  /// Whether the slider runs horizontally (filling from the start edge) or
  /// vertically (filling from the bottom).
  final Axis direction;

  /// The visual variant. Only [MechanixSliderVariant.standard] is supported.
  final MechanixSliderVariant variant;

  /// Whether to show the value next to the pointer while pressed or dragging.
  final bool showValueLabel;

  /// Formats the value shown in the label. Defaults to the rounded value.
  final String Function(double value)? labelFormatter;

  /// Optional FocusNode.
  final FocusNode? focusNode;

  /// Whether this slider should auto focus on init.
  final bool autofocus;

  /// Custom theme override for this slider instance.
  final SliderThemeDataConfig? theme;

  bool get isEnabled => onChanged != null;

  @override
  State<MechanixSlider> createState() => _MechanixSliderState();
}

class _MechanixSliderState extends State<MechanixSlider> {
  /// Fallback length used when the slider is laid out with unbounded constraints.
  static const double _defaultLength = 200.0;

  /// Space between the pointer and the value label.
  static const double _labelGap = 4.0;

  bool _isHovered = false;
  bool _isFocused = false;
  bool _isDragging = false;
  bool _isPressed = false;
  double? _lastEmittedValue;

  double get _range => widget.max - widget.min;

  double get _step =>
      widget.divisions != null ? _range / widget.divisions! : _range / 100;

  double get _pageStep => _range / 10 > _step ? _range / 10 : _step;

  String _format(double value) =>
      widget.labelFormatter?.call(value) ?? value.round().toString();

  double _snap(double value) {
    final clamped = value.clamp(widget.min, widget.max).toDouble();
    final divisions = widget.divisions;
    if (divisions == null || _range == 0) return clamped;
    final t = (clamped - widget.min) / _range;
    return widget.min + (t * divisions).round() / divisions * _range;
  }

  bool _isReversed(TextDirection textDirection) =>
      widget.direction == Axis.vertical || textDirection == TextDirection.rtl;

  /// Converts a local position into a value, along the slider axis.
  double _valueForPosition(
    Offset position,
    double length,
    double pointerWidth,
    TextDirection textDirection,
  ) {
    var main = widget.direction == Axis.horizontal ? position.dx : position.dy;
    if (_isReversed(textDirection)) main = length - main;
    final track = length - pointerWidth;
    final t = track <= 0
        ? 0.0
        : ((main - pointerWidth / 2) / track).clamp(0.0, 1.0);
    return _snap(widget.min + t * _range);
  }

  void _emit(double value) {
    _lastEmittedValue = value;
    if (value != widget.value) widget.onChanged?.call(value);
  }

  /// Applies a one-shot change (tap, keyboard, accessibility action).
  void _commit(double value) {
    if (!widget.isEnabled) return;
    widget.onChangeStart?.call(widget.value);
    _emit(value);
    widget.onChangeEnd?.call(value);
  }

  void _handleDragStart(double value) {
    setState(() => _isDragging = true);
    widget.onChangeStart?.call(widget.value);
    _emit(value);
  }

  void _handleDragEnd() {
    if (!_isDragging) return;
    setState(() => _isDragging = false);
    widget.onChangeEnd?.call(_lastEmittedValue ?? widget.value);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.isEnabled || event is KeyUpEvent) {
      return KeyEventResult.ignored;
    }
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final key = event.logicalKey;

    double? target;
    if (key == LogicalKeyboardKey.arrowUp) {
      target = widget.value + _step;
    } else if (key == LogicalKeyboardKey.arrowDown) {
      target = widget.value - _step;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      target = widget.value + (rtl ? -_step : _step);
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      target = widget.value + (rtl ? _step : -_step);
    } else if (key == LogicalKeyboardKey.pageUp) {
      target = widget.value + _pageStep;
    } else if (key == LogicalKeyboardKey.pageDown) {
      target = widget.value - _pageStep;
    } else if (key == LogicalKeyboardKey.home) {
      target = widget.min;
    } else if (key == LogicalKeyboardKey.end) {
      target = widget.max;
    }

    if (target == null) return KeyEventResult.ignored;
    _commit(_snap(target));
    return KeyEventResult.handled;
  }

  Set<WidgetState> get _states => {
    if (!widget.isEnabled) WidgetState.disabled,
    if (_isHovered) WidgetState.hovered,
    if (_isFocused) WidgetState.focused,
    if (_isPressed) WidgetState.pressed,
    if (_isDragging) WidgetState.dragged,
  };

  @override
  void didUpdateWidget(MechanixSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isEnabled) {
      _isDragging = false;
      _isPressed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant != MechanixSliderVariant.standard) {
      throw UnimplementedError(
        'MechanixSlider variant ${widget.variant.name} is not implemented yet.',
      );
    }

    final textDirection = Directionality.of(context);
    final sizeConfig = SliderSizeConfig.of(widget.size);
    final themeConfig = MechanixSliderTheme.of(context).merge(widget.theme);
    final states = _states;
    final isHorizontal = widget.direction == Axis.horizontal;
    final isEnabled = widget.isEnabled;

    final t = _range == 0
        ? 0.0
        : ((widget.value - widget.min) / _range).clamp(0.0, 1.0);

    final valueText = _format(widget.value);
    final isActive = _isPressed || _isDragging;

    return Semantics(
      slider: true,
      enabled: isEnabled,
      focusable: isEnabled,
      focused: _isFocused,
      value: valueText,
      increasedValue: _format(_snap(widget.value + _step)),
      decreasedValue: _format(_snap(widget.value - _step)),
      textDirection: textDirection,
      onIncrease: isEnabled ? () => _commit(_snap(widget.value + _step)) : null,
      onDecrease: isEnabled ? () => _commit(_snap(widget.value - _step)) : null,
      child: Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        canRequestFocus: isEnabled,
        onKeyEvent: _handleKeyEvent,
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: MouseRegion(
          cursor: isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxLength = isHorizontal
                  ? constraints.maxWidth
                  : constraints.maxHeight;
              final length = maxLength.isFinite ? maxLength : _defaultLength;

              double valueAt(Offset position) => _valueForPosition(
                position,
                length,
                sizeConfig.pointerWidth,
                textDirection,
              );

              final painter = _SliderPainter(
                fraction: t,
                divisions: widget.divisions,
                direction: widget.direction,
                reversed: _isReversed(textDirection),
                sizeConfig: sizeConfig,
                activeTickColor:
                    themeConfig.activeTickColor?.resolve(states) ?? Colors.grey,
                inactiveTickColor:
                    themeConfig.inactiveTickColor?.resolve(states) ??
                    Colors.grey.shade800,
                pointerColor:
                    themeConfig.pointerColor?.resolve(states) ?? Colors.orange,
                showPointer: isActive,
                label: widget.showValueLabel && isActive ? valueText : null,
                labelStyle: themeConfig.valueLabelStyle,
                labelGap: _labelGap,
                textDirection: textDirection,
              );

              // A raw Listener reacts to the press immediately; the tap
              // recognizer only fires after the gesture arena resolves.
              return Listener(
                onPointerDown: isEnabled
                    ? (_) => setState(() => _isPressed = true)
                    : null,
                onPointerUp: (_) => setState(() => _isPressed = false),
                onPointerCancel: (_) => setState(() => _isPressed = false),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  excludeFromSemantics: true,
                  onTapUp: isEnabled
                      ? (details) => _commit(valueAt(details.localPosition))
                      : null,
                  onHorizontalDragStart: isEnabled && isHorizontal
                      ? (details) =>
                            _handleDragStart(valueAt(details.localPosition))
                      : null,
                  onHorizontalDragUpdate: isEnabled && isHorizontal
                      ? (details) => _emit(valueAt(details.localPosition))
                      : null,
                  onHorizontalDragEnd: isEnabled && isHorizontal
                      ? (_) => _handleDragEnd()
                      : null,
                  onHorizontalDragCancel: isEnabled && isHorizontal
                      ? _handleDragEnd
                      : null,
                  onVerticalDragStart: isEnabled && !isHorizontal
                      ? (details) =>
                            _handleDragStart(valueAt(details.localPosition))
                      : null,
                  onVerticalDragUpdate: isEnabled && !isHorizontal
                      ? (details) => _emit(valueAt(details.localPosition))
                      : null,
                  onVerticalDragEnd: isEnabled && !isHorizontal
                      ? (_) => _handleDragEnd()
                      : null,
                  onVerticalDragCancel: isEnabled && !isHorizontal
                      ? _handleDragEnd
                      : null,
                  child: CustomPaint(
                    painter: painter,
                    size: isHorizontal
                        ? Size(length, sizeConfig.pointerHeight)
                        : Size(sizeConfig.pointerHeight, length),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Paints the tick bar and, while active, the value pointer and the optional
/// value label.
///
/// Positions are computed along the "main" axis measured from the start of
/// the fill (the minimum value), then mapped onto the canvas.
class _SliderPainter extends CustomPainter {
  _SliderPainter({
    required this.fraction,
    required this.divisions,
    required this.direction,
    required this.reversed,
    required this.sizeConfig,
    required this.activeTickColor,
    required this.inactiveTickColor,
    required this.pointerColor,
    required this.showPointer,
    required this.label,
    required this.labelStyle,
    required this.labelGap,
    required this.textDirection,
  });

  final double fraction;
  final int? divisions;
  final Axis direction;
  final bool reversed;
  final SliderSizeConfig sizeConfig;
  final Color activeTickColor;
  final Color inactiveTickColor;
  final Color pointerColor;
  final bool showPointer;
  final String? label;
  final TextStyle? labelStyle;
  final double labelGap;
  final TextDirection textDirection;

  bool get _isHorizontal => direction == Axis.horizontal;

  /// A rect centered at [main] along the axis, spanning [thickness] along it
  /// and [extent] across it.
  Rect _rect(Size size, double main, double thickness, double extent) {
    final length = _isHorizontal ? size.width : size.height;
    final along = reversed ? length - main : main;
    final crossCenter = (_isHorizontal ? size.height : size.width) / 2;
    return _isHorizontal
        ? Rect.fromCenter(
            center: Offset(along, crossCenter),
            width: thickness,
            height: extent,
          )
        : Rect.fromCenter(
            center: Offset(crossCenter, along),
            width: extent,
            height: thickness,
          );
  }

  /// Centers of every tick along the main axis.
  List<double> _tickCenters(double length) {
    final tickWidth = sizeConfig.tickWidth;
    final divisions = this.divisions;
    if (divisions != null) {
      final track = length - sizeConfig.pointerWidth;
      return [
        for (var i = 0; i <= divisions; i++)
          sizeConfig.pointerWidth / 2 + track * i / divisions,
      ];
    }
    final pitch = tickWidth + sizeConfig.tickGap;
    final count = ((length + sizeConfig.tickGap) / pitch).floor();
    if (count < 2) return [length / 2];
    final spacing = (length - tickWidth) / (count - 1);
    return [for (var i = 0; i < count; i++) tickWidth / 2 + spacing * i];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final length = _isHorizontal ? size.width : size.height;
    final pointerWidth = sizeConfig.pointerWidth;
    final pointerCenter = pointerWidth / 2 + fraction * (length - pointerWidth);
    final clearance = pointerWidth / 2 + sizeConfig.tickGap;

    final activePaint = Paint()..color = activeTickColor;
    final inactivePaint = Paint()..color = inactiveTickColor;

    for (final center in _tickCenters(length)) {
      if (showPointer && (center - pointerCenter).abs() < clearance) continue;
      canvas.drawRect(
        _rect(size, center, sizeConfig.tickWidth, sizeConfig.barHeight),
        center < pointerCenter ? activePaint : inactivePaint,
      );
    }

    if (!showPointer) return;
    final pointerRect = _rect(
      size,
      pointerCenter,
      pointerWidth,
      sizeConfig.pointerHeight,
    );
    canvas.drawRect(pointerRect, Paint()..color = pointerColor);

    final label = this.label;
    if (label == null) return;
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: textDirection,
    )..layout();

    // The label is painted outside the slider bounds: above the pointer when
    // horizontal, beside it on the start side when vertical.
    final Offset labelOffset;
    if (_isHorizontal) {
      labelOffset = Offset(
        pointerRect.center.dx - textPainter.width / 2,
        pointerRect.top - labelGap - textPainter.height,
      );
    } else {
      final dx = textDirection == TextDirection.rtl
          ? pointerRect.right + labelGap
          : pointerRect.left - labelGap - textPainter.width;
      labelOffset = Offset(dx, pointerRect.center.dy - textPainter.height / 2);
    }
    textPainter.paint(canvas, labelOffset);
    textPainter.dispose();
  }

  @override
  bool shouldRepaint(_SliderPainter oldDelegate) {
    return fraction != oldDelegate.fraction ||
        divisions != oldDelegate.divisions ||
        direction != oldDelegate.direction ||
        reversed != oldDelegate.reversed ||
        sizeConfig.barHeight != oldDelegate.sizeConfig.barHeight ||
        sizeConfig.pointerHeight != oldDelegate.sizeConfig.pointerHeight ||
        activeTickColor != oldDelegate.activeTickColor ||
        inactiveTickColor != oldDelegate.inactiveTickColor ||
        pointerColor != oldDelegate.pointerColor ||
        showPointer != oldDelegate.showPointer ||
        label != oldDelegate.label ||
        labelStyle != oldDelegate.labelStyle ||
        textDirection != oldDelegate.textDirection;
  }
}
