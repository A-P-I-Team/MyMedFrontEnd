import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/components/loading_circles.dart';
import 'package:my_med/src/components/default_circle_avatar.dart';
import 'package:my_med/src/modules/intro/providers/signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPage extends StatelessWidget {
  final Color activeColor;
  final bool isButtonEnable;
  final void Function() onConfirmPressed;

  const PhotoPage({
    Key? key,
    required this.activeColor,
    required this.isButtonEnable,
    required this.onConfirmPressed,
  }) : super(key: key);

  Widget _photoBuilder(final BuildContext context) {
    final photo = context.watch<SignupProvider>().registerController.photo;
    return Center(
      child: SizedBox(
        width: 160,
        height: 160,
        child: photo == null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100,
                    ),
                  ),
                  const LoadingCircles(),
                  Center(
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            : DefaultCircleAvatar(
                circleBorder: const CircleBorder(
                  side: BorderSide(color: Colors.white),
                ),
                image: Image.memory(
                  photo,
                  fit: BoxFit.cover,
                ),
                padding: const EdgeInsets.all(1.0),
              ),
      ),
    );
  }

  Future<void> pickImage(
    final BuildContext context,
    final ImageSource source,
  ) async {
    final provider = context.read<SignupProvider>();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final bytes = await image.readAsBytes();
    final path = image.path;
    provider.setupPhoto(bytes, path);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: activeColor);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          _photoBuilder(context),
          const SizedBox(height: 48),
          DefaultButton(
            isExpanded: true,
            buttonType: ButtonType.primary,
            textStyle: textStyle,
            elevation: 0,
            onPressed: () => pickImage(context, ImageSource.gallery),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.photo_rounded,
                  color: Theme.of(context).primaryColorLight,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Upload a photo from gallery",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DefaultButton(
            buttonType: ButtonType.secondary,
            color: Colors.transparent,
            textStyle: textStyle,
            elevation: 0,
            onPressed: () => pickImage(context, ImageSource.camera),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.camera_alt_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                const Text("Take another photo"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                    onPressed: (isButtonEnable) ? onConfirmPressed : null,
                    child: const Text("Confirm"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
