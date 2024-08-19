import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/home_bloc/home_bloc.dart';
import '../../controllers/home_bloc/home_event.dart';
import '../../controllers/home_bloc/home_state.dart';
import '../../models/user_data_schema.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(
      LoadDataEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(91, 193, 239, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed("/api-calling-screen");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    'Apps',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Home',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add, size: 30),
              onPressed: () {
                context.pushNamed("/add-data").then((value) {
                  context.read<HomeBloc>().add(LoadDataEvent());
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(
                  LogoutEvent(),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LogoutState) {
            context.pushReplacementNamed("/login");
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              final items = state.items;
              if (items.isEmpty) {
                return const Center(child: Text("No Data Available"));
              }
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Dismissible(
                      key: Key(item.email ?? ''),
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        context.read<HomeBloc>().add(RemoveItemEvent(index));
                      },
                      child: ListCard(
                        userData: item,
                        imageUrl:
                            "https://img.freepik.com/free-vector/people-analyzing-growth-charts-illustrated_23-2148865274.jpg",
                      ));
                },
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("No Data Available"));
            }
          },
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final UserData userData;
  final String imageUrl;

  const ListCard({
    Key? key,
    required this.userData,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(margin: const EdgeInsets.only(bottom: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: imageUrl.isEmpty
                  ? const Center(
                      child: Text("Load here\nrandom\nImage from url",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12)))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${userData.firstName} ${userData.lastName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Color(0xFF51B3DF)),
                      const SizedBox(width: 8),
                      Text(userData.phoneNumber,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Color(0xFF51B3DF)),
                      const SizedBox(width: 8),
                      Text(userData.email,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF51B3DF)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          userData.address,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
