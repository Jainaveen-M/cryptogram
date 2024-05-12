import 'package:cryptogram/feature/homescreen/models/market.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  List<Market> data;
  HomeSuccessState(this.data);
}
