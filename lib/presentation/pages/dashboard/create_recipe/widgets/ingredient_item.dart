import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';

import '../../../../../assets.gen.dart';

class IngredientItem extends StatelessWidget {
  final int index;
  final String value;
  final void Function(String value)? onTextChange;
  final void Function()? onDelete;
  const IngredientItem({Key? key, required this.index, this.onTextChange, this.onDelete, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    return Row(
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
            controller: controller,
            onChanged: onTextChange,
            minLines: 1,
            maxLines: 2,
            style:
                context.typographies.body.copyWith(decorationThickness: 0),
            decoration: const InputDecoration(
              hintText: '500g gà ta',
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
                    onTap: (){
                      onDelete?.call();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text('Xóa nguyên liệu này?'),
                    ),
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
    );
  }
}
