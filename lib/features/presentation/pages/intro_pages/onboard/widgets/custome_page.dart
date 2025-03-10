import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/onboard/bloc/page_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';

class CustomePage extends StatelessWidget {
  String bgImage;
  String title;
  String description;
  int currentPage;
  PageController controller;
  CustomePage({
    super.key,
    required this.bgImage,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    context.read<PageBloc>();
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                SizedBox.expand(
                    child: CacheImage(
                  url: bgImage,
                )),
                _skipButton(context),
                Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(constraints.maxWidth * .05),
                      width: constraints.maxWidth * .80,
                      height: constraints.maxHeight * .4,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          _title(context),
                          _description(context),
                          _pageIndicator(context),
                          _forwarOrBackwardButtons(context),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded _forwarOrBackwardButtons(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: currentPage == 2
            ? CustomTextButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signin');
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: currentPage == 1,
                    child: SquareIconButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () {
                        context.read<PageBloc>().add(PagePrevEvent());
                      },
                    ),
                  ),
                  Visibility(
                    visible: currentPage < 2,
                    child: SquareIconButton(
                      icon: Icons.arrow_forward_ios_rounded,
                      onTap: () {
                        context.read<PageBloc>().add(PageNextEvent());
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Expanded _pageIndicator(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Wrap(
          spacing: 10,
          runAlignment: WrapAlignment.center,
          children: List.generate(
            3,
            (index) => CircleAvatar(
              backgroundColor: currentPage == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.tertiary,
              radius: 8,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _description(BuildContext context) {
    return Expanded(
      flex: 2,
      child: SizedBox(
        child: Text(
          description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Expanded _title(BuildContext context) {
    return Expanded(
      flex: 2,
      child: SizedBox(
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Visibility _skipButton(BuildContext context) {
    return Visibility(
      visible: currentPage < 2,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              context.read<PageBloc>().add(PageSkipEvent());
            },
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _bgImage() {
    return BoxDecoration(
      image: DecorationImage(
        scale: 2.0,
        fit: BoxFit.cover,
        image: NetworkImage(
          bgImage,
        ),
      ),
    );
  }
}
