import 'dart:developer';

import 'package:cryptogram/feature/dashboard/dashboard.dart';
import 'package:cryptogram/feature/fav/fav.dart';
import 'package:cryptogram/feature/homescreen/home_bloc/home_bloc.dart';
import 'package:cryptogram/feature/homescreen/home_bloc/home_event.dart';
import 'package:cryptogram/feature/homescreen/home_bloc/home_state.dart';
import 'package:cryptogram/feature/homescreen/models/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    homeBloc.add(HomeGetInitDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Cryptogram"),
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
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listener: (context, state) {
            // if (state is HomeNavigateToFavScreen) {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const FavScreen()));
            // }
            if (state is HomeNavigateToFavScreen) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashbaordScreen()));
            }
          },
          listenWhen: (previous, current) => current is HomeActionState,
          buildWhen: (previous, current) => current is! HomeActionState,
          builder: (context, state) {
            log(state.toString());
            if (state is HomeSuccessState) {
              List<Market?> market = state.data;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search Coin",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controller: searchController,
                      onChanged: (value) {},
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            homeBloc.add(HomeNavigasteToFavScreenEvent());
                          },
                          child: Text("Fav")),
                      TextButton(
                          onPressed: () {
                            homeBloc.add(HomeGetInitDataEvent());
                          },
                          child: Text("Changes")),
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
                                      color: Color.fromARGB(255, 166, 17, 17)),
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
      ),
    );
  }
}
