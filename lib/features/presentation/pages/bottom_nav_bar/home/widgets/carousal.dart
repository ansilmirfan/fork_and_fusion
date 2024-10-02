import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';

import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/carousal_index_bloc/carousal_index_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousal extends StatelessWidget {
  List<ProductEntity> data;
  Carousal({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    //------filtering data from the list---------------
    //------data=product type==today's special------------
    data = data
        .where((element) => element.type.contains(ProductType.todays_special))
        .toList();
    return Visibility(
      visible: data.isNotEmpty,
      child: BlocProvider(
        create: (context) => CarousalIndexBloc(),
        child: BlocBuilder<CarousalIndexBloc, CarousalIndexState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _title(context),
                const SizedBox(height: 5),
                _carousalItems(context),
                _pageIndicator(state, context)
              ],
            );
          },
        ),
      ),
    );
  }

//---------------carousal items-------------------
  CarouselSlider _carousalItems(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
        data.length,
        (index) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  _image(index),
                  _onTapNavigation(context,index),
                ],
              ),
              const SizedBox(height: 8.0),
              _nameAndPrice(index),
            ],
          ),
        ),
      ),
      options: _carousalOptions(context),
    );
  }

//---------------page indicator-----------------
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

//------carousal options---------------
  CarouselOptions _carousalOptions(BuildContext context) {
    return CarouselOptions(
      onPageChanged: (index, reason) {
        context.read<CarousalIndexBloc>().add(
              CarousalIndexChangedEvent(index),
            );
      },
      height: Constants.dHeight * .25,
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
    );
  }

//------name and price-------------
//-------utils.capitalize function for capitalizing starting letter----------
//-------extractprice for extracting price from the variants----either price or minimum value from variants

  Row _nameAndPrice(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(Utils.capitalizeEachWord(data[index].name)),
        Text("₹ ${Utils.extractPrice(data[index])}")
      ],
    );
  }

//--------------------navigation-----------------
  Positioned _onTapNavigation(BuildContext context,int index) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: Constants.radius,
          onTap: () {
            Navigator.of(context).pushNamed('/productview', arguments: data[index]);
          },
        ),
      ),
    );
  }

//------------image only one from the list----------------
  SizedBox _image(int index) {
    return SizedBox(
      height: Constants.dHeight * 0.20,
      width: Constants.dWidth,
      child: ClipRRect(
        borderRadius: Constants.radius,
        child: CacheImage(
          url: data[index].image.first,
        ),
      ),
    );
  }

//-----------title-----------------
  Text _title(BuildContext context) {
    return Text(
      "Today's special",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
