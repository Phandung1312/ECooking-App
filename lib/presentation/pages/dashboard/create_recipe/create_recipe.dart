import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pair/pair.dart';
import 'package:uq_system_app/assets.gen.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe_selector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe_state.dart';
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/widgets/ingredient_item.dart';
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/widgets/instruction_item.dart';
import 'package:uq_system_app/presentation/widgets/alert_dialog.dart';
import 'package:video_player/video_player.dart';

import 'create_recipe_bloc.dart';

@RoutePage()
class CreateRecipePage extends StatefulWidget {
  final int? recipeId;

  const CreateRecipePage({required this.recipeId});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final CreateRecipeBloc _bloc = getIt.get<CreateRecipeBloc>();
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool isVideo = false;
  ValueNotifier<int> videoTimeNotifier = ValueNotifier(0);
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.recipeId != null) {
      _bloc.add(CreateRecipeEvent.load(widget.recipeId!));
    }
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  _pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      isVideo = true;
      _bloc.add(CreateRecipeEvent.uploadVideo(File(pickedFile.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: MultiBlocListener(
        listeners: [
          CreateRecipeStatusListener(
            statuses: const [
              CreateRecipeStatus.success,
              CreateRecipeStatus.failure
            ],
            listener: (context, state) {
              if (state.status == CreateRecipeStatus.success) {
                Fluttertoast.showToast(
                    msg: state.createdRecipe.status == RecipeStatus.draft
                        ? 'Lưu thành công'
                        : _bloc.state.recipeDetailsRequest.status ==
                                RecipeStatus.draft
                            ? 'Đăng tải thành công'
                            : 'Cập nhật thành công',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: context.colors.background,
                    textColor: context.colors.primary,
                    fontSize: 16.0);
                if (widget.recipeId != null) {
                  context.router.pop(true);
                } else {
                  context.router.pop(true);
                  context.router.push(RecipeDetailsRoute(
                    id: state.createdRecipe.id,
                  ));
                }
                return;
              }
              if (state.status == CreateRecipeStatus.failure) {
                Fluttertoast.showToast(
                    msg: 'Có lỗi xảy ra, vui lòng thử lại sau',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: context.colors.background,
                    textColor: context.colors.primary,
                    fontSize: 16.0);
              }
            },
          )
        ],
        child: Scaffold(
          body: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  shadowColor: context.colors.hint.withOpacity(0.6),
                  elevation: 2,
                  forceElevated: true,
                  snap: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: context.colors.primary,
                      size: 35,
                    ),
                    onPressed: () {
                      context.router.pop();
                    },
                  ),
                  actions: [
                    CreateRecipeSelector(
                      builder: (data) {
                        if (_bloc.state.recipeDetailsRequest.status !=
                            RecipeStatus.draft) {
                          return const SizedBox.shrink();
                        }
                        return ElevatedButton(
                          onPressed: data
                              ? () {
                                  _bloc.add(const CreateRecipeEvent.create(
                                      RecipeStatus.draft));
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            backgroundColor: data
                                ? context.colors.secondary
                                : context.colors.secondary.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // maximumSize: Size(100, 50),
                          ),
                          child: Text(
                            'Lưu',
                            style: context.typographies.caption1Bold
                                .withColor(Colors.white),
                          ),
                        );
                      },
                      selector: (state) => state.isDataValid,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CreateRecipeSelector(
                      builder: (data) => ElevatedButton(
                        onPressed: data
                            ? () {
                                _bloc.add(const CreateRecipeEvent.create(
                                    RecipeStatus.public));
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          backgroundColor: data
                              ? Colors.white
                              : context.colors.hint.withOpacity(0.2),
                          surfaceTintColor: data
                              ? Colors.white
                              : context.colors.hint.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: data
                                    ? context.colors.secondary
                                    : Colors.white,
                                width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _bloc.state.recipeDetailsRequest.status ==
                                  RecipeStatus.draft
                              ? 'Đăng tải'
                              : 'Cập nhật',
                          style: context.typographies.caption1Bold.withColor(
                              data ? context.colors.secondary : Colors.white),
                        ),
                      ),
                      selector: (state) => state.isDataValid,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: context.colors.primary,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: CreateRecipeSelector(
                    selector: (state) => state.recipeDetailsRequest,
                    builder: (data) {
                      return InkWell(
                        onTap: () async {
                          final returnedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (returnedImage == null) return;
                          _bloc.add(CreateRecipeEvent.uploadImage(
                              file: File(returnedImage.path),
                              imagePickType: ImagePickType.recipe));
                        },
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          color: context.colors.hint.withOpacity(0.2),
                          child: data.image != null
                              ? CachedNetworkImage(
                                  imageUrl: data.image ?? "",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 250,
                                    color: context.colors.hint,
                                  ),
                                  placeholder: (context, url) => Container(
                                    height: 250,
                                    color: context.colors.hint.withOpacity(0.5),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: context.colors.secondary,
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AssetGenImage(
                                            Assets.icons.png.icCooking.path)
                                        .image(width: 100, fit: BoxFit.contain),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: context.colors.primary
                                              .withOpacity(0.5),
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text("Thêm ảnh đại diện món ăn",
                                            style: context.typographies.body
                                                .withColor(context
                                                    .colors.primary
                                                    .withOpacity(0.5)))
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ),
                _buildDescriptions(),
                _buildIngredients(),
                CreateRecipeSelector(
                    selector: (state) => state.recipeDetailsRequest.video,
                    builder: (data) {
                      return _buildInstructions();
                    })
              ]),
        ),
      ),
    );
  }

  Widget _buildDescriptions() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          CreateRecipeSelector(
            selector: (state) => state.recipeDetailsRequest.video,
            builder: (data) {
              if (data == null) {
                return CreateRecipeStatusSelector(
                  builder: (status) {
                    if (status == CreateRecipeStatus.uploadingVideo) {
                      return Column(
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: context.colors.secondary,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Đang tải video lên, vui lòng chờ...",
                              style: context.typographies.body
                                  .copyWith(color: context.colors.secondary))
                        ],
                      );
                    }
                    return InkWell(
                      onTap: _pickVideo,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AssetGenImage(Assets.icons.png.icFilm.path).image(
                              width: 30,
                              fit: BoxFit.contain,
                              color: context.colors.secondary),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Thêm video cho món ăn",
                              style: context.typographies.bodyBold
                                  .copyWith(color: context.colors.secondary))
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Column(
                  children: [
                    Container(
                        color: Colors.black,
                        height: 300,
                        child: FutureBuilder(
                          future: () async {
                            _videoPlayerController =
                                VideoPlayerController.networkUrl(
                                    Uri.parse(data));
                            await _videoPlayerController.initialize();
                            videoTimeNotifier.value =
                                _videoPlayerController.value.duration.inSeconds;
                          }(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: context.colors.secondary,
                                ),
                              );
                            }
                            _chewieController = ChewieController(
                              videoPlayerController: _videoPlayerController,
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              autoPlay: true,
                              looping: false,
                            );
                            return Chewie(controller: _chewieController);
                          },
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: context.colors.secondary, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: _pickVideo,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.mode_edit_outline_outlined,
                                    color: context.colors.secondary,
                                    size: 20,
                                  ),
                                  Text("Chỉnh sửa",
                                      style: context.typographies.body
                                          .withColor(context.colors.secondary)),
                                ],
                              ),
                            ),
                            Text(" | ",
                                style: context.typographies.body
                                    .withColor(context.colors.secondary)),
                            InkWell(
                              onTap: () {
                                showAlertDialog(
                                    context: context,
                                    messages: [
                                      'Bạn có chắc chắn muốn xóa video này không?'
                                    ],
                                    onTap: () {
                                      _videoPlayerController.dispose();
                                      _chewieController.dispose();
                                      _bloc.add(CreateRecipeEvent.update(_bloc
                                          .state.recipeDetailsRequest
                                          .copyWith(video: null)));
                                    });
                              },
                              child:
                                  AssetGenImage(Assets.icons.png.icTrash.path)
                                      .image(
                                          width: 20,
                                          fit: BoxFit.contain,
                                          color: context.colors.secondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CreateRecipeSelector(
            builder: (data) {
              var controller = TextEditingController();
              controller.text = data ?? "";
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              return TextField(
                controller: controller,
                minLines: 2,
                maxLines: 2,
                maxLength: 50,
                onChanged: (value) {
                  _bloc.add(CreateRecipeEvent.update(
                      _bloc.state.recipeDetailsRequest.copyWith(title: value)));
                },
                style: context.typographies.title2
                    .copyWith(decorationThickness: 0),
                decoration: InputDecoration(
                  counter: const SizedBox.shrink(),
                  hintText: 'Tên món: Món gà xào sả ớt hao cơm',
                  hintStyle: context.typographies.title2
                      .copyWith(color: context.colors.hint),
                ),
              );
            },
            selector: (state) => state.recipeDetailsRequest.title,
          ),
          const SizedBox(
            height: 15,
          ),
          CreateRecipeSelector(
            builder: (data) {
              var controller = TextEditingController();
              controller.text = data ?? "";
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              return TextField(
                controller: controller,
                onChanged: (value) {
                  _bloc.add(CreateRecipeEvent.update(_bloc
                      .state.recipeDetailsRequest
                      .copyWith(content: value)));
                },
                minLines: 4,
                maxLines: 4,
                style:
                    context.typographies.body.copyWith(decorationThickness: 0),
                decoration: InputDecoration(
                  hintText:
                      'Mô tả: Món gà xào sả ớt hao cơm là một món ăn ngon, dễ chế biến, '
                      'thích hợp cho cả gia đình. Món ăn này có vị cay, thơm, ngon miệng, '
                      'được chế biến từ thịt gà, sả, ớt, gia vị và một số nguyên liệu khác.',
                  hintStyle: context.typographies.body
                      .copyWith(color: context.colors.hint),
                ),
              );
            },
            selector: (state) => state.recipeDetailsRequest.content,
          ),
          const SizedBox(
            height: 30,
          ),
          CreateRecipeSelector(
            builder: (data) {
              var controller = TextEditingController();
              controller.text = data ?? "";
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Khẩu phần", style: context.typographies.body),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        _bloc.add(CreateRecipeEvent.update(_bloc
                            .state.recipeDetailsRequest
                            .copyWith(servers: value)));
                      },
                      maxLength: 20,
                      style: context.typographies.body
                          .copyWith(decorationThickness: 0),
                      decoration: InputDecoration(
                        counter: const SizedBox.shrink(),
                        hintText: '1 người',
                        hintStyle: context.typographies.body
                            .copyWith(color: context.colors.hint),
                      ),
                    ),
                  )
                ],
              );
            },
            selector: (state) => state.recipeDetailsRequest.servers,
          ),
          const SizedBox(
            height: 15,
          ),
          CreateRecipeSelector(
            builder: (data) {
              var controller = TextEditingController();
              controller.text = data ?? "";
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Thời gian nấu", style: context.typographies.body),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        _bloc.add(CreateRecipeEvent.update(_bloc
                            .state.recipeDetailsRequest
                            .copyWith(cookTime: value)));
                      },
                      maxLength: 30,
                      style: context.typographies.body
                          .copyWith(decorationThickness: 0),
                      decoration: InputDecoration(
                        counter: const SizedBox.shrink(),
                        hintText: '30 phút',
                        hintStyle: context.typographies.body
                            .copyWith(color: context.colors.hint),
                      ),
                    ),
                  )
                ],
              );
            },
            selector: (state) => state.recipeDetailsRequest.cookTime,
          )
        ],
      ),
    ));
  }

  Widget _buildIngredients() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text("Nguyên liệu", style: context.typographies.title2Bold),
            const SizedBox(
              height: 15,
            ),
            CreateRecipeSelector(
              builder: (data) {
                return ListView.separated(
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => IngredientItem(
                    index: index,
                    value: data[index],
                    onTextChange: (value) {
                      _bloc.add(CreateRecipeEvent.updateIngredient(
                          content: value, index: index));
                    },
                    onDelete: () {
                      _bloc.add(
                          CreateRecipeEvent.removeIngredient(index: index));
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                );
              },
              selector: (state) => state.recipeDetailsRequest.ingredients,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  _bloc.add(const CreateRecipeEvent.addIngredient());
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  backgroundColor: context.colors.tertiary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // maximumSize: Size(100, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Thêm nguyên liệu',
                      style: context.typographies.body.withColor(Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text("Cách làm", style: context.typographies.title2Bold),
            const SizedBox(
              height: 15,
            ),
            CreateRecipeSelector(
              builder: (data) {
                return ListView.separated(
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var instruction = data[index];
                    return InstructionItem(
                      index: index,
                      previousEndTime:
                          index == 0 ? 0 : data[index - 1].endAt ?? 0,
                      videoTime: videoTimeNotifier.value,
                      data: instruction,
                      isVideo: isVideo,
                      onInstructionChange: (value) {
                        _bloc.add(CreateRecipeEvent.updateInstruction(
                            instruction: value, index: index));
                      },
                      onDelete: () {
                        _bloc.add(
                            CreateRecipeEvent.removeInstruction(index: index));
                      },
                      onPickImage: (File file, int position) {
                        _bloc.add(CreateRecipeEvent.uploadImage(
                            file: file,
                            positionPair: Pair(index, position),
                            imagePickType: ImagePickType.instruction));
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                );
              },
              selector: (state) => state.recipeDetailsRequest.instructions,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  _bloc.add(const CreateRecipeEvent.addInstruction());
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  backgroundColor: context.colors.tertiary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // maximumSize: Size(100, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Thêm hướng dẫn',
                      style: context.typographies.body.withColor(Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
