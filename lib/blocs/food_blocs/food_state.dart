import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:notepad/data/model/food.dart';

@immutable
class FoodBlocState extends Equatable {
  final List<Food> foodList;

  const FoodBlocState({required this.foodList});

  const FoodBlocState.initial(List<Food> foods) : this.foodList = foods;

  @override
  List<Object?> get props => [foodList];

  FoodBlocState copyWith({List<Food>? foods}) {
    return FoodBlocState(foodList: foods ?? this.foodList);
  }

  @override
  String toString() => 'FoodState{foods: $foodList}';
}
