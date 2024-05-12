import 'dart:developer';

import 'package:cryptogram/feature/dashboard/cubit/dashboard_cubit.dart';
import 'package:cryptogram/feature/homescreen/models/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashbaordScreen extends StatefulWidget {
  const DashbaordScreen({super.key});

  @override
  State<DashbaordScreen> createState() => _DashbaordScreenState();
}

class _DashbaordScreenState extends State<DashbaordScreen> {
  DashboardCubit dashboardCubit = DashboardCubit();
  @override
  void initState() {
    dashboardCubit.getDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("dashboard"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black,
                  Color.fromARGB(255, 113, 11, 11)
                ]),
          ),
        ),
      ),
      body: BlocConsumer<DashboardCubit, DashboardState>(
        bloc: dashboardCubit,
        listener: (context, state) {
          // if (state is HomeNavigateToFavScreen) {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => const FavScreen()));
          // }
        },
        // listenWhen: (previous, current) => current is HomeActionState,
        // buildWhen: (previous, current) => current is! HomeActionState,
        builder: (context, state) {
          log(state.toString());
          if (state is DashboardSuccess) {
            List<Market?> market = state.data;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          // homeBloc.add(HomeNavigasteToFavScreenEvent());
                        },
                        child: Text("Fav")),
                    TextButton(onPressed: () {}, child: Text("Changes")),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: <Market>(context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 166, 17, 17)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 40,
                              width: 40,
                              child: SvgPicture.network(
                                market[index]?.coinImg ?? '',
                              ),
                            ),
                            title: Text(
                              market[index]?.coinpair ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              market[index]?.price ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: Text(
                              (market[index]?.changes ?? "0.0") + "%",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
