import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/carousal_index_bloc/carousal_index_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousal extends StatelessWidget {
  double height;
  Carousal({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarousalIndexBloc(),
      child: BlocBuilder<CarousalIndexBloc, CarousalIndexState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //----------title-----------------
              Text(
                "Today's special",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              CarouselSlider(
                //----------------image-----------------
                items: List.generate(
                  15,
                  (index) => SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: Constants.radius,
                              child: Image.network(
                                Constants.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: height * .20,
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: Constants.radius,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/productview'
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        //-----------name and price------------------
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Dish Name $index',
                            ),
                            const Text('₹150')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    context.read<CarousalIndexBloc>().add(
                          CarousalIndexChangedEvent(index),
                        );
                  },
                  height: height * .25,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeOutQuad,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              //-------------indicator------------------
              AnimatedSmoothIndicator(
                activeIndex: state is CarousalIndexInitial ? state.index : 0,
                count: 15,
                effect: ScrollingDotsEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                  dotHeight: 10,
                  dotWidth: 15,
                  spacing: 8.0,
                  maxVisibleDots: 7,
                  activeStrokeWidth: 2.0,
                  activeDotScale: 1.5,
                  dotColor: Colors.grey,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
