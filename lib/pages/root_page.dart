
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmoneky/cubits/root_cubit.dart';
import 'package:mealmoneky/widgets/custom_navBar.dart';


class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // items == icons  >> pages == all pages (5) >>  currentIndex = the Index Your Are in.
    List<Widget> items = context.read<RootCubit>().getNavIcons();
    List<Widget> pages = context.read<RootCubit>().pages;
    int currentIndex = context.read<RootCubit>().currentIndex;
    // Change State depends On Page
    return BlocBuilder<RootCubit, RootState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: CustomNavBar(
            activeIndex: currentIndex, onTap: (int newIndex) {
            currentIndex = newIndex;
            context.read<RootCubit>().emit(RootInitial());
          }, items: items,
          ),
          body: pages[currentIndex],
        );
      },
    );
  }
}
