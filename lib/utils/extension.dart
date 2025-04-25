import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notepad/animations/fade_animation.dart';
import 'package:notepad/data/model/food.dart';

extension BlocBaseExt on BlocBase {
  void dispose() {}
}

extension IterableExt on List<Food> {
  getIndex(Food food) {
    int index = indexWhere((Element) => Element.id == food.id);
    return index;
  }
}

extension FadeAnminationExt on Widget {
  Widget fadeAnimation(double delay) {
    return FadeAnimation(
      delay: delay,
      child: this,
    );
  }
}

extension TextThemeExt on BuildContext {
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;

  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;

  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;

  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;

  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;

  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
}

//拓展map方法 .将map转换为格式化字符串,便于查看层级
extension MaptoStringExt on Map {
  /**
     * indentation:首行缩进数量 ,类似于首行缩进2这种,传递参数int ,默认为0
     *  prefix : 首行缩进字符, 用于缩进站位,默认为空格,可自定为任意字符, 传参为String
     */
  String mapToStructureString({int indentation = 0, String prefix = " "}) {
    if (this.isEmpty || this.length == 0) {
      return "$this";
    }
    String result = "";
    final String indentationContent = prefix * indentation;

    result += "{";
    this.forEach((key, value) {
      if (value is Map) {
        result += "\n$indentationContent" +
            "\"$key\": ${value.mapToStructureString(indentation: indentation + 1)},";
      } else if (value is List) {
        result += "\n$indentationContent" +
            "\"$key\": ${value.listToStructureString(indentation: indentation + 1)},";
      } else {
        result += "\n$indentationContent" +
            "\"$key\": ${value is String ? "\"$value\"," : "$value,"}";
      }
    });

    return result;
  }
}

/// List 拓展，List 转结构化字符串输出。
extension List2StringEx on List {
  String listToStructureString({int indentation = 0, String space = "  "}) {
    if (this.isEmpty) {
      return "$this";
    }
    String result = "";
    String indentationContent = space * indentation;
    result += "[";
    for (var value in this) {
      if (value is Map) {
        result += "\n$indentationContent" +
            space +
            "${value.mapToStructureString(indentation: indentation + 1)},"; // 加空格更好看
      } else if (value is List) {
        result += value.listToStructureString(indentation: indentation + 1);
      } else {
        result += "\n$indentationContent" + "\"$value\",";
      }
    }
    result = result.substring(0, result.length - 1); // 去掉最后一个逗号
    result += "\n$indentationContent]";
    return result;
  }
}
