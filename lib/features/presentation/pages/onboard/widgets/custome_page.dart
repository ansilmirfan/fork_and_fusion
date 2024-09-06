import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/onboard/bloc/page_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

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
          builder: (context, constraints) => Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 2.0,
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  bgImage,
                ),
              ),
            ),
            child: Stack(
              children: [
                //-------------skip button----------------
                Visibility(
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
                ),
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
                          //--------------title---------------
                          Expanded(
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
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Text(
                                description,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          //-------------------indicator--------------------
                          Expanded(
                            child: SizedBox(
                              child: Wrap(
                                spacing: 10,
                                runAlignment: WrapAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => CircleAvatar(
                                    backgroundColor: currentPage == index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                    radius: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //-----------------------------------------------------
                          Expanded(
                            child: SizedBox(
                              child: currentPage == 2
                                  ? CustomeTextButton(
                                      text: 'Get Started',
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/signin');
                                      },
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Visibility(
                                          visible: currentPage == 1,
                                          child: SquareIconButton(
                                            icon: 
                                                Icons.arrow_back_ios_new,
                                            onTap: () {
                                              context
                                                  .read<PageBloc>()
                                                  .add(PagePrevEvent());
                                            },
                                          ),
                                        ),
                                        Visibility(
                                          visible: currentPage < 2,
                                          child: SquareIconButton(
                                            icon: Icons
                                                .arrow_forward_ios_rounded,
                                            onTap: () {
                                              context
                                                  .read<PageBloc>()
                                                  .add(PageNextEvent());
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
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
}
