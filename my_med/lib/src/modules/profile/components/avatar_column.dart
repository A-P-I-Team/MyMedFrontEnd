import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarColumn extends StatelessWidget {
  final String fullName;
  final String identification;
  final String? profileImage;

  const AvatarColumn({
    Key? key,
    required this.fullName,
    required this.identification,
    this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight,
            ),
            child: (profileImage != null)
                ? CachedNetworkImage(
                    imageUrl: profileImage!,
                    placeholder: (_, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (_, url, __) => const Icon(
                      Icons.person,
                      size: 45,
                    ),
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.person,
                    size: 45,
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            fullName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF474747),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            identification,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF474747),
            ),
          ),
        ],
      ),
    );
  }
}
