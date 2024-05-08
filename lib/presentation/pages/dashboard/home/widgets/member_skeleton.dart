
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';

class MemberSkeleton extends StatelessWidget {
  const MemberSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SkeletonAvatar(
                style: SkeletonAvatarStyle(width: 60, height: 60, shape: BoxShape.circle)),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                      borderRadius: BorderRadius.circular(10),
                      height: 17,
                      minLength: MediaQuery.of(context).size.width * 0.3,
                      maxLength: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                const SizedBox(height: 10,),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    borderRadius: BorderRadius.circular(10),
                    height: 14,
                    minLength: MediaQuery.of(context).size.width * 0.3,
                    maxLength: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
