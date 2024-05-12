import 'package:bloc/bloc.dart';
import 'package:cryptogram/feature/homescreen/home_repo.dart';
import 'package:cryptogram/feature/homescreen/models/market.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  getDashboard() async {
    emit(DashboardLoading());
    List<Market> d = await HomeRepo.getCoindcxData();
    emit(DashboardSuccess(data: d));
  }
}
