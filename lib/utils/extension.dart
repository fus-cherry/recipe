import 'package:bloc/bloc.dart';
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
