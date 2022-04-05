import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatelessWidget {
  final String? imageLink;
  final Image? image;
  final CircleBorder? circleBorder;
  final EdgeInsetsGeometry padding;

  const DefaultCircleAvatar({
    Key? key,
    this.imageLink,
    this.circleBorder,
    this.padding = EdgeInsets.zero,
    this.image,
  })  : assert((imageLink == null) ^ (image == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      shape: CircleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Padding(
        padding: padding,
        child: Material(
          shape: circleBorder,
          child: (imageLink != null)
              ? CachedNetworkImage(
                  imageUrl: imageLink!,
                  fit: BoxFit.cover,
                )
              : (image != null)
                  ? image
                  : const Placeholder(),
        ),
      ),
    );
  }
}
