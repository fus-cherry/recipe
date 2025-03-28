import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/blocs/food_blocs/food_event.dart';
import 'package:notepad/blocs/food_blocs/food_state.dart';
import 'package:notepad/data/model/food.dart';
import 'package:notepad/data/repository/repository.dart';
import 'package:notepad/utils/extension.dart';

class FoodBloc extends Bloc<FoodBlocEvent, FoodBlocState> {
  FoodBloc({
    required this.repository,
  }) : super(FoodBlocState.initial(repository.getFoodList)) {
    on<IncreaseQuantityEvent>(_increaseQuantity);
    on<DecreaseQuantityEvent>(_decreaseQuantity);
    on<RemoveItemEvent>(_removeItem);
    on<FavoriteItemEvent>(_isFavorite);
    on<AddToCartEvent>(_addToCart);
  }

  Repository repository;

  void _increaseQuantity(
      IncreaseQuantityEvent event, Emitter<FoodBlocState> emit) {
    int index = state.foodList.getIndex(event.food);
    final List<Food> foodList = state.foodList.map((element) {
      if (element.id == event.food.id) {
        return state.foodList[index]
            .copyWith(quantity: state.foodList[index].quantity + 1);
      }
      return element;
    }).toList();

    emit(FoodBlocState(foodList: foodList));
  }

  void _decreaseQuantity(
      DecreaseQuantityEvent event, Emitter<FoodBlocState> emit) {
    int index = state.foodList.getIndex(event.food);

    final List<Food> foodList = state.foodList.map((element) {
      if (element.id == event.food.id && element.quantity > 1) {
        return state.foodList[index]
            .copyWith(quantity: state.foodList[index].quantity - 1);
      }
      //for Item quantity less than zero this statement will be called
      if (element.id == event.food.id) {
        //Remove item from cart
        return state.foodList[index].copyWith(cart: false);
      }
      return element;
    }).toList();
    emit(FoodBlocState(foodList: foodList));
  }

  void _removeItem(RemoveItemEvent event, Emitter<FoodBlocState> emit) {
    final List<Food> foodList = state.foodList.map((element) {
      if (element.id == event.food.id) {
        return event.food.copyWith(cart: false);
      }
      return element;
    }).toList();

    emit(FoodBlocState(foodList: foodList));
  }

  void _isFavorite(FavoriteItemEvent event, Emitter<FoodBlocState> emit) {
    int index = state.foodList.getIndex(event.food);
    final List<Food> foodList = state.foodList.map((element) {
      if (element.id == event.food.id) {
        return event.food
            .copyWith(isFavorite: !state.foodList[index].isFavorite);
      }
      return element;
    }).toList();
    emit(FoodBlocState(foodList: foodList));
  }

  void _addToCart(AddToCartEvent event, Emitter<FoodBlocState> emit) {
    int index = state.foodList.getIndex(event.food);

    final List<Food> cartFood = state.foodList.map((element) {
      if (element.id == event.food.id) {
        return state.foodList[index].copyWith(cart: true);
      }
      return element;
    }).toList();

    emit(FoodBlocState(foodList: cartFood));
  }

  String pricePerEachItem(Food food) {
    double price = 0;
    price = food.quantity * food.price;
    return price.toString();
  }

  double get getTotalPrice {
    double totalPrice = 5;
    for (var element in state.foodList) {
      if (element.cart) {
        totalPrice += element.quantity * element.price;
      }
    }
    return totalPrice;
  }

  get getCartList => state.foodList.where((element) => element.cart).toList();

  get getFavoriteList =>
      state.foodList.where((element) => element.isFavorite).toList();
}
