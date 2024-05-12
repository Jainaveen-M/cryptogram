import 'dart:async';
import 'dart:developer';

import 'package:cryptogram/feature/homescreen/home_repo.dart';
import 'package:cryptogram/feature/homescreen/home_bloc/home_event.dart';
import 'package:cryptogram/feature/homescreen/home_bloc/home_state.dart';
import 'package:cryptogram/feature/homescreen/models/market.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetInitDataEvent>(getInitData);
    on<HomeNavigasteToFavScreenEvent>(navigateToFavScreen);
  }

  FutureOr<void> getInitData(
      HomeGetInitDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<Market?> data = await HomeRepo.getCoindcxData();
    emit(HomeSuccessState(data));
  }

  FutureOr<void> navigateToFavScreen(
      HomeNavigasteToFavScreenEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavScreen());
  }
}
