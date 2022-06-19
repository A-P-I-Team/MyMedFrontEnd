import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatelessWidget {
  final String? imageURL;
  const BackgroundImageContainer({Key? key, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 230,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        color: Color(0xFFEDF5FD),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: (imageURL == null)
          ? Image.asset("assets/doctor_image_sample.png")
          : CachedNetworkImage(
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              imageUrl: imageURL!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/doctor_image_sample.png"),
            ),
    );
  }
}
