import 'package:flutter/material.dart';

class ZoomableImage extends StatelessWidget {
  final String imageUrl;

  const ZoomableImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  InteractiveViewer(
                    child: Image.network(imageUrl),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Image.network(
        imageUrl,
        width: 100,
        height: 100,
      ),
    );
  }
}
