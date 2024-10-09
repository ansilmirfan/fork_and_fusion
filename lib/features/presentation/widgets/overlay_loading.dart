import 'package:flutter/material.dart';

OverlayEntry? loadingOverlay;
void showLoadingOverlay(BuildContext context) {
  if (loadingOverlay != null) return;

  loadingOverlay = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Container(
          color: Colors.white12,
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    ),
  );

  Overlay.of(context).insert(loadingOverlay!);
}

void hideLoadingOverlay() {
  loadingOverlay?.remove();
  loadingOverlay = null;
}
