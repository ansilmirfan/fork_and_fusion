import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/onboard/bloc/page_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/onboard/onboard_data.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/onboard/widgets/custome_page.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PageBloc(),
        child: BlocConsumer<PageBloc, PageState>(
          listener: (context, state) {
            if (state is PageChangeState) {
              _animateToPage(state.currentPage);
            }
          },
          builder: (context, state) {
            return _buildPageView(context, state);
          },
        ),
      ),
    );
  }

  PageView _buildPageView(BuildContext context, PageState state) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        context.read<PageBloc>().add(PageChangeEvent(value));
      },
      controller: controller,
      children: List.generate(
        3,
        (index) => CustomePage(
          bgImage:OnboardData. images[index],
          title: OnboardData.title[index],
          description:OnboardData. description[index],
          currentPage: state is PageChangeState ? state.currentPage : 0,
          controller: controller,
        ),
      ),
    );
  }

  Future<void> _animateToPage(int index) {
    return controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }
}
