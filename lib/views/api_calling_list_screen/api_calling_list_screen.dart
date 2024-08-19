import 'package:dot_pitch_poc/controllers/list_bloc/list_bloc.dart';
import 'package:dot_pitch_poc/controllers/list_bloc/list_event.dart';
import 'package:dot_pitch_poc/controllers/list_bloc/list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiCallingScreen extends StatefulWidget {
  const ApiCallingScreen({super.key});

  @override
  State<ApiCallingScreen> createState() => _ApiCallingScreenState();
}

class _ApiCallingScreenState extends State<ApiCallingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ListBloc>(context).add(
      FetchListEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('API Data'),
        backgroundColor: const Color.fromRGBO(91, 193, 239, 1),
      ),
      body: BlocBuilder<ListBloc, ListState>(builder: (context, state) {
        if (state is ListLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ListError) {
          return Center(child: Text(state.message));
        }
        if (state is ListLoaded) {
          final data = state.responseSchema.list;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return ListTile(contentPadding: const EdgeInsets.only(bottom: 9,top: 9,right:19,left: 10),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(item.link),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                trailing: Container(
                  width: 67.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xFF51B3DF), // Blue color for all borders
                      width: 2, // Border width for all sides
                    ),
                  ),
                  child: Center(
                    child: Text(
                      item.amount.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFF51B3DF) ),
                    ),
                  ),
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
