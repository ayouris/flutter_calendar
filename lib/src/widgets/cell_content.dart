// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nawat_mobile/core/config/text_style.dart';
import 'package:nawat_mobile/core/theme/app_theme.dart';

import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;

  const CellContent({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isToday,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    final text = '${day.day}';
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    const duration = Duration(milliseconds: 250);

    if (int.parse(text) > DateTime.now().day) {
      if (isRangeEnd || isRangeStart) {
        cell =
            calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
                AnimatedContainer(
                  duration: duration,
                  margin: margin,
                  padding: padding,
                  decoration: ShapeDecoration(
                    color: AppThemeConfig().colorBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  alignment: alignment,
                  child: Text(
                    text,
                    style: CustomTextStyle().drawerTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                );
      } else if (isWithinRange) {
        cell = calendarBuilders.withinRangeBuilder
                ?.call(context, day, focusedDay) ??
            AnimatedContainer(
              duration: duration,
              margin: margin,
              padding: padding,
              alignment: alignment,
              child: Text(
                text,
                style: CustomTextStyle().drawerTitle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppThemeConfig().colorBlue,
                    ),
              ),
            );
      } else {
        cell =
            calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
                AnimatedContainer(
                  duration: duration,
                  margin: margin,
                  padding: padding,
                  decoration: calendarStyle.disabledDecoration,
                  alignment: alignment,
                  child: Text(
                    text,
                    style: CustomTextStyle().drawerTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppThemeConfig().iconPrimary,
                        ),
                  ),
                );
      }
    } else if (isSelected) {
      if (isRangeEnd || isRangeStart) {
        cell =
            calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
                AnimatedContainer(
                  duration: duration,
                  margin: margin,
                  padding: padding,
                  decoration: ShapeDecoration(
                    color: AppThemeConfig().colorBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  alignment: alignment,
                  child: Text(
                    text,
                    style: CustomTextStyle().drawerTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                );
      } else if (isWithinRange) {
        cell = calendarBuilders.withinRangeBuilder
                ?.call(context, day, focusedDay) ??
            AnimatedContainer(
              duration: duration,
              margin: margin,
              padding: padding,
              decoration: calendarStyle.withinRangeDecoration,
              alignment: alignment,
              child: Text(
                text,
                style: CustomTextStyle().drawerTitle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppThemeConfig().colorBlue,
                    ),
              ),
            );
      } else {
        cell =
            calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
                AnimatedContainer(
                  duration: duration,
                  margin: margin,
                  padding: padding,
                  alignment: alignment,
                  child: Text(
                    text,
                    style: calendarStyle.selectedTextStyle
                        .copyWith(color: AppThemeConfig().colorBlue),
                  ),
                );
      }
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: ShapeDecoration(
                  color: AppThemeConfig().colorBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                alignment: alignment,
                child: Text(
                  text,
                  style: CustomTextStyle().drawerTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                ),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: ShapeDecoration(
              color: AppThemeConfig().colorBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            alignment: alignment,
            child: Text(
              text,
              style: CustomTextStyle()
                  .drawerTitle
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.holidayDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.holidayTextStyle),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: alignment,
                child: Text(
                  text,
                  style: CustomTextStyle().drawerTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppThemeConfig().colorBlue,
                      ),
                ),
              );
    } else if (isToday) {
      return AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        alignment: alignment,
        child: Text(
          text,
          style: CustomTextStyle()
              .drawerTitle
              .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
        ),
      );
    } else {
      if (day.month > DateTime.now().month) {
        cell =
            calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
                AnimatedContainer(
                  duration: duration,
                  margin: margin,
                  padding: padding,
                  decoration: calendarStyle.disabledDecoration,
                  alignment: alignment,
                  child: Text(
                    text,
                    style: CustomTextStyle().drawerTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                );
      } else {
        cell =
            calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
                AnimatedContainer(
                  duration: duration,
                  margin: margin,
                  padding: padding,
                  decoration: calendarStyle.disabledDecoration,
                  alignment: alignment,
                  child: Text(
                    text,
                    style: CustomTextStyle().drawerTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                );
      }
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}
