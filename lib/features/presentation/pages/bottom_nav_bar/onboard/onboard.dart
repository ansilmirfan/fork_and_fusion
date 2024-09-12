import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/onboard/bloc/page_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/onboard/widgets/custome_page.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  List<String> images = [
    'asset/images/dosha.jpg',
    'asset/images/dishes.jpg',
    'asset/images/dishes1.jpg'
  ];
  List<String> title = [
    'Welcome to Fork and Fusion',
    'Your Perfect  foods Just a Tap Away',
    'Satisfy Your Cravings'
  ];
  List<String> description = [
    'Scan, order, and enjoy                      right from your table',
    'Savor a wide selection of delicious dishes and handcrafted drinks, from classic coffee to refreshing smoothies, all made to order',
    'Order right from your table and enjoy a seamless dining experience'
  ];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PageBloc(),
        child: BlocConsumer<PageBloc, PageState>(
          listener: (context, state) {
            if (state is PageChangeState) {
              controller.animateToPage(
                state.currentPage,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            }
          },
          builder: (context, state) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                context.read<PageBloc>().add(PageChangeEvent(value));
              },
              controller: controller,
              children: List.generate(
                3,
                (index) => CustomePage(
                  bgImage: images[index],
                  title: title[index],
                  description: description[index],
                  currentPage: state is PageChangeState ? state.currentPage : 0,
                  controller: controller,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
