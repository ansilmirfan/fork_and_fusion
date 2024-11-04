import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/carousal_index_bloc/carousal_index_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousal extends StatelessWidget {
  List<ProductEntity> data;
  Carousal({super.key, required this.data});
  var borderRadiusBottom = BorderRadius.only(
      bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));

  @override
  Widget build(BuildContext context) {
    data = data
        .where((element) => element.type.contains(ProductType.todays_special))
        .toList();

    return Visibility(
      visible: data.isNotEmpty,
      child: BlocProvider(
        create: (context) => CarousalIndexBloc(),
        child: BlocBuilder<CarousalIndexBloc, CarousalIndexState>(
          builder: (context, state) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800), // Maximum width
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _title(context),
                    Gap(gap: 5),
                    _carousalItems(context),
                    Gap(gap: 10),
                    _pageIndicator(state, context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _carousalItems(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double carouselHeight;
    if (screenWidth >= 1200) {
      carouselHeight = 400;
    } else if (screenWidth >= 600) {
      carouselHeight = 300;
    } else {
      carouselHeight = 200;
    }

    return CarouselSlider(
      items: List.generate(
        data.length,
        (index) => SingleChildScrollView(
          child: Stack(
            children: [
              _image(index, carouselHeight),
              _onTapNavigation(context, index),
              _transperentContainer(index, context),
            ],
          ),
        ),
      ),
      options: _carousalOptions(context, carouselHeight),
    );
  }

  Widget _image(int index, double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: Constants.radius,
        child: CacheImage(
          url: data[index].image.first,
        ),
      ),
    );
  }

  CarouselOptions _carousalOptions(BuildContext context, double height) {
    double viewportFraction =
        MediaQuery.of(context).size.width > 600 ? 0.6 : 0.8;
    return CarouselOptions(
      onPageChanged: (index, reason) {
        context.read<CarousalIndexBloc>().add(
              CarousalIndexChangedEvent(index),
            );
      },
      height: height,
      viewportFraction: viewportFraction,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.easeOutQuad,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
      scrollDirection: Axis.horizontal,
    );
  }

  AnimatedSmoothIndicator _pageIndicator(
      CarousalIndexState state, BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: state is CarousalIndexInitial ? state.index : 0,
      count: data.length,
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
    );
  }

  Positioned _onTapNavigation(BuildContext context, int index) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: Constants.radius,
          onTap: () {
            Navigator.of(context)
                .pushNamed('/productview', arguments: data[index]);
          },
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      "Today's special",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _transperentContainer(int index, BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        padding: Constants.padding10,
        decoration: BoxDecoration(
          borderRadius: borderRadiusBottom,
          color: Colors.black38,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Utils.capitalizeEachWord(data[index].name),
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            Text(
              '₹${Utils.calculateOffer(data[index])}',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ],
        ),
      ),
    );
  }
}
