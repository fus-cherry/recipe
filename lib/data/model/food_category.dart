import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:notepad/data/model/food.dart';

@immutable
class FoodCategory extends Equatable {
  final FoodType type;

  final bool isSelected;

  const FoodCategory({required this.type, this.isSelected = false});

  @override
  List<Object?> get props => [type, isSelected];

  FoodCategory copyWith({FoodType? foodType, bool? isSelected}) {
    return FoodCategory(
      type: foodType ?? this.type,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  String toString() {
    return """
      FoodCategory{
        foodType: $type, 
        isSelected: $isSelected,
      }""";
  }
}
