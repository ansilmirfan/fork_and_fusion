import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousal extends StatefulWidget {
  final List<String> images;
  const ImageCarousal({super.key, required this.images});

  @override
  State<ImageCarousal> createState() => _ImageCarousalState();
}

class _ImageCarousalState extends State<ImageCarousal> {
  final PageController pageController = PageController();
  int currentPage = 0;
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.dHeight * 2 / 5,
      width: double.infinity,
      child: Stack(
        children: [
          CarouselSlider(
            items: _images(),
            options: _carousalOptions(),
          ),
          _pageIndicator(context),
        ],
      ),
    );
  }

  List<Widget> _images() {
    return List.generate(
      widget.images.length,
      (index) => SizedBox(
        width: double.infinity,
        height: Constants.dHeight * 2 / 5,
        child: CacheImage(
          url: widget.images[index],
        ),
      ),
    );
  }

  CarouselOptions _carousalOptions() {
    return CarouselOptions(
      viewportFraction: 1.0,
      height: Constants.dHeight * 2 / 5,
      onPageChanged: (index, reason) {
        setState(() {
          currentPage = index;
        });
      },
      enableInfiniteScroll: false,
    );
  }

  Visibility _pageIndicator(BuildContext context) {
    return Visibility(
      visible: widget.images.length > 1,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: Constants.radius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              padding: Constants.padding10,
              child: AnimatedSmoothIndicator(
                activeIndex: currentPage,
                count: widget.images.length,
                effect: WormEffect(
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
