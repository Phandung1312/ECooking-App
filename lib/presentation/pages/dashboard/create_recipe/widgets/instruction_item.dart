import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uq_system_app/core/extensions/number.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/data/models/instruction/instruction.request.dart';

import '../../../../../assets.gen.dart';

class InstructionItem extends StatelessWidget {
  final int index;
  final InstructionRequest data;
  final bool isVideo;
  final int previousEndTime;
  final int videoTime;
  final void Function(InstructionRequest instruction) onInstructionChange;
  final void Function(File file, int position) onPickImage;
  final void Function()? onDelete;

  const InstructionItem(
      {Key? key,
      required this.index,
      this.onDelete,
      this.previousEndTime = 0,
      this.videoTime = 0,
      required this.data,
      this.isVideo = false,
      required this.onInstructionChange,
      required this.onPickImage})
      : super(key: key);

  Future<void> _selectTime(BuildContext context, bool isStart,
      int minTimeInSeconds, int maxTimeInSeconds, int selectedTime) async {
    int selectedMinutes = selectedTime ~/ 60;
    int selectedSeconds = selectedTime % 60;
    FixedExtentScrollController minuteController = FixedExtentScrollController(
        initialItem: selectedMinutes - (minTimeInSeconds ~/ 60));
    FixedExtentScrollController secondController =
        FixedExtentScrollController(initialItem: selectedSeconds);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Chọn thời gian',
            style: context.typographies.title3Bold,
          ),
          content: SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Phút",
                          style: context.typographies.body
                              .copyWith(decorationThickness: 0)),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: minuteController,
                          itemExtent: 30,
                          backgroundColor: Colors.blue.withOpacity(0.8),
                          onSelectedItemChanged: (value) {
                            selectedMinutes = value + (minTimeInSeconds ~/ 60);
                          },
                          children: List<Widget>.generate(
                              (maxTimeInSeconds ~/ 60) -
                                  (minTimeInSeconds ~/ 60) +
                                  1,
                              (index) =>
                                  Text('${index + (minTimeInSeconds ~/ 60)}')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Giây",
                          style: context.typographies.body
                              .copyWith(decorationThickness: 0)),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: secondController,
                          backgroundColor: Colors.blue.withOpacity(0.8),
                          itemExtent: 30,
                          onSelectedItemChanged: (value) {
                            selectedSeconds = value;
                          },
                          children: List<Widget>.generate(
                              60, (index) => Text('$index')),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: context.typographies.bodyBold.withColor(Colors.blue),
              ),
              onPressed: () {
                int selectedTimeInSeconds =
                    selectedMinutes * 60 + selectedSeconds;
                if (selectedTimeInSeconds <= maxTimeInSeconds) {
                  if (isStart) {
                    onInstructionChange(
                        data.copyWith(startAt: selectedTimeInSeconds));
                  } else {
                    if (selectedTimeInSeconds < (data.startAt ?? 0)) {
                      selectedTimeInSeconds = (data.startAt ?? 0) + 1;
                    }
                    onInstructionChange(
                        data.copyWith(endAt: selectedTimeInSeconds));
                  }
                  Navigator.of(context).pop();
                } else {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isStart
                          ? 'Thời gian bắt đầu không thể lớn hơn thời gian kết thúc'
                          : 'Thời gian kết thúc không thể lớn hơn thời gian của video'),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isVideoSegment = false;
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    int startTimeInSeconds = 0;
    int endTimeInSeconds = 0;
    titleController.text = data.title ?? "";
    titleController.selection = TextSelection.fromPosition(
        TextPosition(offset: titleController.text.length));
    contentController.text = data.content ?? "";
    contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: contentController.text.length));
    startTimeInSeconds = data.startAt ?? previousEndTime + 1;
    endTimeInSeconds = data.endAt ?? videoTime;
    isVideoSegment = data.title != null || data.startAt != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_outlined,
                color: context.colors.hint.withOpacity(0.5)),
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: context.colors.tertiary,
              radius: 15,
              child: Text(
                (index + 1).toString(),
                style: context.typographies.caption1
                    .withColor(context.colors.secondary),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                onChanged: (value) {
                  var newInstruction = data.copyWith(content: value);
                  onInstructionChange(newInstruction);
                },
                minLines: 2,
                maxLines: 10,
                style:
                    context.typographies.body.copyWith(decorationThickness: 0),
                decoration: const InputDecoration(
                  hintText:
                      'Gà mua về rửa sạch qua muối và chanh, để ráo nước.',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: InkWell(
                        onTap: () {
                          onDelete?.call();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Xóa bước này?')),
                      ),
                    );
                  },
                );
              },
              child: AssetGenImage(Assets.icons.png.icTrash.path).image(
                  width: 20,
                  fit: BoxFit.contain,
                  color: context.colors.secondary),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 80),
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: ((data.images?.length ?? 0) + 1),
                itemBuilder: (context, index) => index ==
                        (data.images?.length ?? 0)
                    ? (data.images?.length ?? 0) < 3
                        ? InkWell(
                            onTap: () async {
                              final returnedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (returnedImage == null) return;
                              onPickImage(File(returnedImage.path),
                                  (data.images?.length ?? 0));
                            },
                            child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F1EC),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: context.colors.hint.withOpacity(0.5),
                                    size: 40,
                                  ),
                                )),
                          )
                        : const SizedBox()
                    : InkWell(
                        onTap: () async {
                          final returnedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (returnedImage == null) return;
                          onPickImage(File(returnedImage.path), index);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F1EC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data.images![index],
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              height: 100,
                              color: context.colors.hint,
                            ),
                            placeholder: (context, url) => Container(
                                height: 100,
                                color: context.colors.hint.withOpacity(0.5),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: context.colors.secondary,
                                  ),
                                )),
                          ),
                        ),
                      ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 10);
                },
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (!isVideoSegment && isVideo)
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                onInstructionChange(data.copyWith(
                    title: "", startAt: previousEndTime + 1, endAt: videoTime));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,
                      color: context.colors.primary.withOpacity(0.8)),
                  Text("Thêm phân đoạn cho video",
                      style: context.typographies.body
                          .withColor(context.colors.primary.withOpacity(0.8))
                          .withSize(16)),
                ],
              ),
            ),
          ),
        if (isVideoSegment || data.title != null || data.startAt != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 75, bottom: 10, right: 30),
            child: TextField(
              controller: titleController,
              onChanged: (value) {
                var newInstruction = data.copyWith(title: value);
                onInstructionChange(newInstruction);
              },
              style: context.typographies.body.copyWith(decorationThickness: 0),
              decoration: const InputDecoration(
                hintText: 'Phân đoạn: Sơ chế',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(width: 80),
              Text("Bắt đầu:",
                  style: context.typographies.body
                      .withColor(context.colors.primary)
                      .withSize(14)),
              const SizedBox(width: 15),
              InkWell(
                  onTap: () {
                    _selectTime(context, true, previousEndTime,
                        endTimeInSeconds, startTimeInSeconds);
                  },
                  child: Text(
                    startTimeInSeconds.formatTime(),
                    style: context.typographies.bodyBold.withColor(Colors.blue),
                  )),
              const Expanded(child: SizedBox()),
              Text("Kết thúc:",
                  style: context.typographies.body
                      .withColor(context.colors.primary)
                      .withSize(14)),
              const SizedBox(width: 15),
              InkWell(
                onTap: () {
                  _selectTime(
                      context,
                      false,
                      startTimeInSeconds == 0
                          ? previousEndTime
                          : startTimeInSeconds + 1,
                      videoTime,
                      endTimeInSeconds);
                },
                child: Text(
                  endTimeInSeconds.formatTime(),
                  style: context.typographies.bodyBold.withColor(Colors.blue),
                ),
              ),
              const SizedBox(width: 30),
            ],
          )
        ]
      ],
    );
  }
}
