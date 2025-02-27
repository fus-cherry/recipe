import 'package:equatable/equatable.dart';
import 'package:notepad/data/model/food.dart';

abstract class FoodBlocEvent extends Equatable {
  final Food food;

  const FoodBlocEvent(this.food);

  @override
  List<Object> get props => [];
}

class IncreaseQuantityEvent extends FoodBlocEvent {
  const IncreaseQuantityEvent(Food food) : super(food);
}

class DecreaseQuantityEvent extends FoodBlocEvent {
  const DecreaseQuantityEvent(super.food);
}

class RemoveItemEvent extends FoodBlocEvent {
  const RemoveItemEvent(super.food);
}

class AddToCartEvent extends FoodBlocEvent {
  const AddToCartEvent(super.food);
}

class FavoriteItemEvent extends FoodBlocEvent {
  const FavoriteItemEvent(super.food);
}
