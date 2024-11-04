// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/favourite_get_all/favourite_get_all_cubit.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';

class BouncingHeartButton extends StatefulWidget {
  final String id;
  final FavouriteBloc bloc;
  final bool fromFavourite;

  const BouncingHeartButton({
    super.key,
    required this.id,
    required this.bloc,
    required this.fromFavourite,
  });

  @override
  _BouncingHeartButtonState createState() => _BouncingHeartButtonState();
}

class _BouncingHeartButtonState extends State<BouncingHeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    animation();

    // Initially check if the item is in favourites
    widget.bloc.add(CheckForFavouriteEvent(widget.id));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<FavouriteBloc, FavouriteState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is FavouriteStatusState) {
            // Set initial state based on whether the item is in favourites
            setState(() => isLiked = state.isInFavourite);
          } else if (state is FavouriteErrorState) {
            // -----------Revert 'isLiked' if an error occurs
            setState(() => isLiked = !isLiked);
            showCustomSnackbar(
              context: context,
              message: 'Failed to update favorites ${state.message}',
              isSuccess: false,
            );
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: IconButton(
                onPressed: toggleLike,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void animation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = TweenSequence(
      [
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
      ],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void toggleLike() {
    if (_controller.isAnimating) return;

    // Optimistically toggle the isLiked state
    setState(() {
      isLiked = !isLiked;
    });

    // Trigger the relevant event based on the updated 'isLiked' state
    widget.bloc.add(isLiked
        ? AddToFavouriteEvent(widget.id)
        : RemoveFromFavouriteEvent(widget.id));

    // Run the animation without waiting for backend response
    _controller.forward().then((_) => _controller.reverse()).then((_) {
      if (widget.fromFavourite) {
        // Refresh favourite items if necessary
        context.read<FavouriteGetAllCubit>().getAll();
      }
    });
  }
}
