// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/favourite_get_all/favourite_get_all_cubit.dart';

class BouncingHeartButton extends StatefulWidget {
  final String id;
  final FavouriteBloc bloc;
  final bool fromFavourite;

  const BouncingHeartButton(
      {super.key,
      required this.id,
      required this.bloc,
      required this.fromFavourite});

  @override
  _BouncingHeartButtonState createState() => _BouncingHeartButtonState();
}

class _BouncingHeartButtonState extends State<BouncingHeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool hasCalled = false;

  @override
  void initState() {
    super.initState();
    animation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<FavouriteBloc, FavouriteState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is FavouriteLoadingState) {
            return IconButton(
                onPressed: () {},
                icon: const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    )));
          } else if (state is FavouriteStatusState) {
            bool isLiked = state.isInFavourite;

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: IconButton(
                    onPressed: () => toggleLike(),
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                  ),
                );
              },
            );
          } else if (state is FavouriteErrorState) {
            return const Icon(Icons.error);
          } else {
            return Constants.none;
          }
        },
      ),
    );
  }

  void animation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    widget.bloc.add(CheckForFavouriteEvent(widget.id));

    _scaleAnimation = TweenSequence(
      [
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
      ],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void toggleLike() {
    if (_controller.isAnimating) return;

    final currentState = widget.bloc.state;

    if (currentState is FavouriteStatusState) {
      if (currentState.isInFavourite) {
        widget.bloc.add(RemoveFromFavouriteEvent(widget.id));
      } else {
        widget.bloc.add(AddToFavouriteEvent(widget.id));
      }

      _controller.forward().then((_) => _controller.reverse()).then((value) {
        if (widget.fromFavourite) {
          context.read<FavouriteGetAllCubit>().getAll();
        }
      });
    }
  }
}
