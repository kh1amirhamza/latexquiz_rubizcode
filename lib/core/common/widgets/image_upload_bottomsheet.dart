import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class ImageUploadBottomSheet extends StatelessWidget {
  final Function() onSelectCamera;
  final Function() onSelectGallery;
  final Function() onImageRemove;
  const ImageUploadBottomSheet(this.onSelectCamera, this.onSelectGallery, this.onImageRemove, 
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Column(children: [
              GestureDetector(
                onTap: () async {
                  onSelectCamera();
                  //Get.back();
                },
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: primaryColor.withOpacity(0.05), width: 2)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(width: 20),
                      DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(12)),
                            color: AppColors.primaryColor.withAlpha((0.07*255).toInt()),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.photo_camera_outlined,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          )),
                      const SizedBox(width: 20),
                      Text(
                        'Take image from camera',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ),

              //  SizedBox(height: 15),

              // Padding(
              //   padding: const EdgeInsets.only(left: 40,right: 40),
              //   child: Divider(color: Colors.grey.shade300, height: 2,),
              // ),

              const SizedBox(height: 15),

              GestureDetector(
                  onTap: () async {
                    onSelectGallery();
                    // Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(color: primaryColor.withOpacity(0.05), width: 2)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(width: 20),
                        DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12)),
                              color: AppColors.primaryColor.withAlpha((0.07*255).toInt()),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.image_outlined,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                            )),
                        const SizedBox(width: 20),
                        Text(
                          'Pick image from device',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ))
            ,
             const SizedBox(height: 15),

              GestureDetector(
                  onTap: () async {
                    onImageRemove();
                    // Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(color: primaryColor.withOpacity(0.05), width: 2)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(width: 20),
                        DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12)),
                              color: Colors.red.shade600.withAlpha((0.07*255).toInt()),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.red.shade600,
                                size: 20,
                              ),
                            )),
                        const SizedBox(width: 20),
                        Text(
                          'Remove image',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade600),
                        ),
                      ],
                    ),
                  ))
            
            
            ])));
  }
}