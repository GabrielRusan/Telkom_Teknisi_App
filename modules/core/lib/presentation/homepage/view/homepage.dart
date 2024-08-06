import 'package:core/presentation/homepage/bloc/homepage_bloc.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return IndexedStack(
          index: state.index,
          children: const [
            Scaffold(
              body: Center(
                child: Text('this is homepage'),
              ),
              bottomNavigationBar: BottomNavigationBarWidget(),
            ),
            Scaffold(
              body: Center(
                child: Text('this is other page'),
              ),
              bottomNavigationBar: BottomNavigationBarWidget(),
            ),
            Scaffold(
              body: Center(
                child: Text('this is other 2 page'),
              ),
              bottomNavigationBar: BottomNavigationBarWidget(),
            ),
          ],
        );
      },
    );
  }
}
