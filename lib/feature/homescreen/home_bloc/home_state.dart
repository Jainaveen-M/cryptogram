import 'package:cryptogram/feature/homescreen/models/market.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  List<Market?> data;
  HomeSuccessState(this.data);
}

class HomeNavigateToFavScreen extends HomeActionState {}
