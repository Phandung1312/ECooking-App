import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uq_system_app/assets.gen.dart';
import 'package:uq_system_app/core/extensions/number.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';
import 'package:uq_system_app/helpers/user_info.helper.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_bloc.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_event.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_selector.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_state.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/widgets/SliverAppBarDelegate.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/widgets/instruction_item.dart';
import 'package:uq_system_app/presentation/widgets/divider_line.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/entities/enum/enum.dart';
import '../../../domain/entities/instruction.dart';
import '../../widgets/recipe_skeleton.dart';
import '../dashboard/home/widgets/recipe_item.dart';

@RoutePage()
class RecipeDetailsPage extends StatefulWidget {
  final int id;
  final int? instructionOrder;

  const RecipeDetailsPage({required this.id, this.instructionOrder});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  final RecipeDetailsBloc _bloc = getIt.get<RecipeDetailsBloc>();
  final ScrollController _scrollController = ScrollController();
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  var isVideoInitialized = false;
  Account? userAccount;
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      userAccount = await getIt.get<UserInfoHelper>().getAccountUser();
      _bloc.add(RecipeDetailsLoad(widget.id));
    });
  }

  @override
  void dispose() {
    _bloc.close();
    _scrollController.dispose();
    if (isVideoInitialized) {
      _videoPlayerController.dispose();
      _chewieController.dispose();
    }
    super.dispose();
  }
  void showReportDialog(BuildContext context){
    String? selectedReportContent;
    List<String> reportContents = ReportContent.values.map((e) => e.content).toList();
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              title: Text("Báo cáo công thức", style: context.typographies.title2),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    icon:  Icon(Icons.arrow_drop_down, color: context.colors.primary,),
                    hint: const Text("Vui lòng chọn nội dung báo cáo"),
                    isExpanded: true,
                    value: selectedReportContent,
                    items: reportContents.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: context.typographies.body,),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setStateSB(() {
                        selectedReportContent = newValue;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            backgroundColor: context.colors.hint,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("Hủy", style: context.typographies.bodyBold.withColor(Colors.white)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if(selectedReportContent != null){
                              _bloc.add(RecipeDetailsReport(selectedReportContent!));
                              Navigator.of(context).pop();
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: 'Vui lòng chọn nội dung báo cáo',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: context.colors.background,
                                  textColor: context.colors.primary,
                                  fontSize: 16.0);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            backgroundColor: context.colors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("Gửi", style: context.typographies.bodyBold.withColor(Colors.white)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<RecipeDetailsBloc, RecipeDetailsState>(
              listener: (context, state) {
                if (state.status == RecipeDetailsStatus.failure) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Lỗi',
                        style: context.typographies.title3,
                      ),
                      content: Text(
                        'Đã có lỗi không mong muốn xảy ra',
                        style: context.typographies.body,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child:
                              Text('OK', style: context.typographies.bodyBold),
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.router.pop();
                          },
                        ),
                      ],
                    ),
                  );
                  return;
                }
                if(state.status == RecipeDetailsStatus.deleted){
                  Fluttertoast.showToast(
                      msg: 'Đã xóa công thức này',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: context.colors.background,
                      textColor: context.colors.primary,
                      fontSize: 16.0);
                  context.router.pop();
                  return;
                }
                if (state.status == RecipeDetailsStatus.reported) {
                  Fluttertoast.showToast(
                      msg: 'Đã báo cáo công thức này, admin sẽ xem xét và xử lý sớm nhất có thể',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: context.colors.background,
                      textColor: context.colors.primary,
                      fontSize: 16.0);

                  return;
                }
              },
            ),
          ],
          child: RecipeDetailsBuilder(
            statuses: const [
              RecipeDetailsStatus.loading,
              RecipeDetailsStatus.success
            ],
            builder: (BuildContext context, RecipeDetailsState state) {
              if (state.status == RecipeDetailsStatus.loading) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(context.colors.secondary),
                ));
              }

              if (state.status == RecipeDetailsStatus.success) {
                final recipe = state.recipeDetails;

                return CustomScrollView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    if (recipe.videoUrl.isNotEmpty)
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          minHeight: kToolbarHeight + 300,
                          maxHeight: kToolbarHeight + 300,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                AppBar(
                                  leading: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    color: Colors.white,
                                    onPressed: () {
                                      context.router.pop();
                                    },
                                  ),
                                  actions: [
                                    if (userAccount?.id != recipe.author.id)
                                      IconButton(
                                        icon: const Icon(
                                            Icons.bookmark_border_outlined),
                                        color: Colors.white,
                                        onPressed: () {},
                                      )
                                    else
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: Colors.white,
                                        onPressed: () async {
                                          var result = await context.router
                                              .push(CreateRecipeRoute(
                                                  recipeId: recipe.id));
                                          if (result != null) {
                                            _bloc.add(
                                                RecipeDetailsLoad(widget.id));
                                          }
                                        },
                                      ),
                                    PopupMenuButton<int>(
                                      icon: const Icon(Icons.more_vert),
                                      surfaceTintColor: Colors.white,
                                      color: Colors.white,
                                      itemBuilder: (context) => [
                                        userAccount?.id == recipe.author.id ?
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text("Xóa", style : context.typographies.caption1),
                                        ) :
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text("Báo cáo", style : context.typographies.caption1),
                                        ),
                                      ],
                                      onSelected: (value) {
                                        switch (value) {
                                          case 1:
                                            _bloc.add(const RecipeDetailsDelete());
                                            break;
                                          case 2:
                                            showReportDialog(context);
                                            break;
                                        }
                                      },
                                    ),
                                  ],
                                  backgroundColor: Colors.red,
                                  surfaceTintColor: Colors.red,
                                ),
                                _buildBackground(recipe),
                              ],
                            ),
                          ),
                        ),
                      )
                    else ...[
                      SliverAppBar(
                          pinned: true,
                          forceElevated: true,
                          elevation: 2,
                          shadowColor: context.colors.hint.withOpacity(0.6),
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          expandedHeight: 350,
                          leading: AnimatedBuilder(
                            animation: _scrollController,
                            builder: (context, child) {
                              return IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: _scrollController.hasClients &&
                                        _scrollController.offset > 200
                                    ? Colors.black
                                    : Colors.white,
                                onPressed: () {
                                  context.router.pop();
                                },
                              );
                            },
                          ),
                          actions: [
                            AnimatedBuilder(
                              animation: _scrollController,
                              builder: (context, child) {
                                return RecipeDetailsSelector(
                                  selector: (state) =>
                                      state.recipeDetails.isFavorite,
                                  builder: (data) => IconButton(
                                    icon: Icon(data
                                        ? Icons.favorite
                                        : Icons.favorite_border),
                                    color: _scrollController.hasClients &&
                                            _scrollController.offset > 200
                                        ? data
                                            ? Colors.red
                                            : Colors.black
                                        : data
                                            ? Colors.red
                                            : Colors.white,
                                    onPressed: () {
                                      _bloc.add(
                                          const RecipeDetailsChangeFavorite());
                                    },
                                  ),
                                );
                              },
                            ),
                            if (userAccount?.id != recipe.author.id)
                              AnimatedBuilder(
                                animation: _scrollController,
                                builder: (context, child) {
                                  return RecipeDetailsSelector(
                                    selector: (state) =>
                                        state.recipeDetails.isSaved,
                                    builder: (data) => IconButton(
                                      icon: Icon(data
                                          ? Icons.bookmark
                                          : Icons.bookmark_border_outlined),
                                      color: _scrollController.hasClients &&
                                              _scrollController.offset > 200
                                          ? data
                                              ? Colors.red
                                              : Colors.black
                                          : data
                                              ? Colors.red
                                              : Colors.white,
                                      onPressed: () {
                                        _bloc.add(
                                          const RecipeDetailsChangeSaved(),
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                            else
                              AnimatedBuilder(
                                animation: _scrollController,
                                builder: (context, child) {
                                  return IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: _scrollController.hasClients &&
                                            _scrollController.offset > 200
                                        ? Colors.black
                                        : Colors.white,
                                    onPressed: () async {
                                      var result = await context.router.push(
                                          CreateRecipeRoute(
                                              recipeId: recipe.id));
                                      if (result != null) {
                                        _bloc.add(RecipeDetailsLoad(widget.id));
                                      }
                                    },
                                  );
                                },
                              ),
                            AnimatedBuilder(
                              animation: _scrollController,
                              builder: (context, child) {


                                return PopupMenuButton<int>(
                                  icon: const Icon(Icons.more_vert),
                                  surfaceTintColor: Colors.white,
                                  color: Colors.white,
                                  iconColor: _scrollController.hasClients &&
                                _scrollController.offset > 200
                                ? Colors.black
                                    : Colors.white,
                                  itemBuilder: (context) => [
                                    userAccount?.id == recipe.author.id ?
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text("Xóa", style : context.typographies.caption1),
                                    ) :
                                    PopupMenuItem(
                                      value: 2,
                                      child: Text("Báo cáo", style : context.typographies.caption1),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    switch (value) {
                                      case 1:
                                        _bloc.add(const RecipeDetailsDelete());
                                        break;
                                      case 2:
                                        showReportDialog(context);
                                        break;
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                              background: _buildBackground(recipe))),
                    ],
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              recipe.title,
                              style: context.typographies.title2
                                  .withColor(context.colors.text),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RecipeDetailsSelector(
                                selector: (state) =>
                                    state.recipeDetails.isFavorite,
                                builder: (data) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _bloc.add(
                                              const RecipeDetailsChangeFavorite());
                                        },
                                        child: AssetGenImage(data
                                                ? Assets.icons.png
                                                    .icFavoriteFill.path
                                                : Assets
                                                    .icons.png.icFavorite.path)
                                            .image(
                                                width: 24,
                                                height: 24,
                                                fit: BoxFit.cover),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          _bloc.state.recipeDetails.likeCount
                                              .formatNumber(),
                                          style: context.typographies.body
                                              .copyWith(
                                                  color: context.colors.text,
                                                  fontSize: 24)),
                                      const SizedBox(width: 50),
                                      AssetGenImage(
                                              Assets.icons.png.icView.path)
                                          .image(
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.cover,
                                              color: context.colors.text),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(recipe.views.formatNumber(),
                                          style: context.typographies.body
                                              .copyWith(
                                                  color: context.colors.text,
                                                  fontSize: 24)),
                                    ],
                                  );
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildAuthor(recipe),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildDescription(recipe),
                            _buildIngredients(recipe),
                            const SizedBox(
                              height: 20,
                            ),
                            _buildInstructions(recipe),
                            const SizedBox(
                              height: 20,
                            ),
                            _buildComments(),
                            const SizedBox(
                              height: 20,
                            ),
                            _buildSuggests(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(RecipeDetails recipe) {
    return recipe.videoUrl.isNotEmpty
        ? SizedBox(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: FutureBuilder(future: () async {
                    _videoPlayerController = VideoPlayerController.networkUrl(
                        Uri.parse(recipe.videoUrl));
                    await _videoPlayerController.initialize();
                    isVideoInitialized = true;
                  }(), builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: recipe.imageUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Container(
                                  height: 300,
                                  color: context.colors.hint,
                                ),
                                placeholder: (context, url) => Container(
                                  height: 300,
                                  color: context.colors.hint,
                                ),
                              ),
                            ),
                          ),
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                context.colors.secondary),
                          ),
                        ],
                      );
                    }
                    _chewieController = ChewieController(
                      showControlsOnInitialize: true,
                      allowMuting: true,
                      allowFullScreen: true,
                      videoPlayerController: _videoPlayerController,
                      autoPlay: true,
                      looping: false,
                      subtitle:
                          Subtitles(_convertToSubtitle(recipe.instructions)),
                      subtitleBuilder: (context, subtitle) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            subtitle,
                            style: context.typographies.bodyBold
                                .copyWith(color: Colors.white, fontSize: 14),
                          ),
                        );
                      },
                    );
                    if (widget.instructionOrder != null) {
                      _videoPlayerController.seekTo(Duration(
                          seconds: recipe
                              .instructions[(widget.instructionOrder! > 0
                                      ? widget.instructionOrder!
                                      : 1) -
                                  1]
                              .startAt));
                    }
                    return Container(
                        color: Colors.black,
                        child: Chewie(controller: _chewieController));
                  }),
                ),
              ],
            ),
          )
        : ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
            child: CachedNetworkImage(
              imageUrl: recipe.imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 300,
                color: context.colors.hint,
              ),
              placeholder: (context, url) => Container(
                height: 300,
                color: context.colors.hint,
              ),
            ),
          );
  }

  List<Subtitle> _convertToSubtitle(List<Instruction> instructions) {
    List<Subtitle> subtitles = [];
    for (Instruction instruction in instructions) {
      if (instruction.title.isNotEmpty) {
        subtitles.add(Subtitle(
            index: instruction.order - 1,
            start: Duration(seconds: instruction.startAt),
            end: Duration(seconds: instruction.endAt),
            text: instruction.title));
      }
    }
    return subtitles;
  }

  Widget _buildAuthor(RecipeDetails recipe) {
    return Column(
      children: [
        const DividerLine(),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: (){
            if(userAccount?.id == recipe.author.id) {
              context.router.push( ProfileRoute( isFromDashboard: false));
            }
            else{
              context.router.push(UserProfileRoute(userId: recipe.author.id));
            }
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(recipe.author.avatarUrl),
                backgroundColor: context.colors.hint,
                radius: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.author.displayName,
                        style: context.typographies.bodyBold),
                    Text("@${recipe.author.username}",
                        style: context.typographies.body
                            .withColor(context.colors.text.withOpacity(0.5))),
                  ],
                ),
              ),
              if (userAccount?.id != recipe.author.id)
                RecipeDetailsSelector(
                  selector: (state) => state.recipeDetails.author.isFollowing,
                  builder: (data) {
                    return InkWell(
                      onTap: () {
                        if (userAccount != null) {
                          _bloc.add(RecipeDetailsChangeFollow(FollowParams(
                              followedId: recipe.author.id,
                              status: data
                                  ? FeatureStatus.disable
                                  : FeatureStatus.enable)));
                        } else {
                          context.router.push(const LoginRoute());
                        }
                      },
                      child: !data
                          ? Container(
                              decoration: BoxDecoration(
                                color: context.colors.secondary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text("Theo dõi",
                                  style: context.typographies.body
                                      .copyWith(color: Colors.white)),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: context.colors.hint.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text("Đang theo dõi",
                                  style: context.typographies.bodyBold),
                            ),
                    );
                  }
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const DividerLine(),
      ],
    );
  }

  Widget _buildDescription(RecipeDetails recipe) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          if (recipe.content.isNotEmpty) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                recipe.content,
                style: context.typographies.body,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const DividerLine(),
            const SizedBox(
              height: 10,
            ),
          ],
          if (recipe.cookTime.isNotEmpty) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AssetGenImage(Assets.icons.png.icClock.path)
                    .image(width: 18, height: 18, fit: BoxFit.cover),
                const SizedBox(
                  width: 10,
                ),
                Text(recipe.cookTime,
                    style: context.typographies.body
                        .copyWith(color: context.colors.text, fontSize: 16)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildIngredients(RecipeDetails recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nguyên liệu", style: context.typographies.title2),
        if (recipe.servers.isNotEmpty) ...[
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AssetGenImage(Assets.icons.png.icProfile.path).image(
                  width: 18,
                  height: 18,
                  fit: BoxFit.cover,
                  color: context.colors.text),
              const SizedBox(
                width: 10,
              ),
              Text(recipe.servers,
                  style: context.typographies.body
                      .copyWith(color: context.colors.text, fontSize: 16)),
            ],
          )
        ],
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipe.ingredients.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.ingredients[index].content,
                  style: context.typographies.body,
                ),
                if (index < recipe.ingredients.length - 1) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  const DividerLine(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildInstructions(RecipeDetails recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cách làm", style: context.typographies.title2),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipe.instructions.length,
          itemBuilder: (context, index) => InstructionItem(
            instruction: recipe.instructions[index],
            onTitleTap: (startAt) {
              _videoPlayerController.seekTo(Duration(seconds: startAt));
            },
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
        ),
      ],
    );
  }

  Widget _buildComments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Bình luận", style: context.typographies.title2),
            const SizedBox(width: 10),
            Text("(${_bloc.state.totalComments})",
                style: context.typographies.title2)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (_bloc.state.totalComments > 1) ...[
          InkWell(
            onTap: () {
              context.router.push(
                  CommentRoute(recipeId: widget.id, isWriteComment: false));
            },
            child: Text(
              "Xem tất cả bình luận",
              style: context.typographies.bodyBold
                  .withColor(context.colors.hint.withOpacity(0.8)),
            ),
          )
        ],
        const SizedBox(
          height: 15,
        ),
        if (_bloc.state.totalComments > 0) ...[
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(_bloc.state.comments[0].author.avatarUrl),
                backgroundColor: context.colors.hint,
                radius: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_bloc.state.comments[0].author.displayName,
                        style: context.typographies.bodyBold),
                    Text(_bloc.state.comments[0].content,
                        style: context.typographies.body),
                  ],
                ),
              ),
            ],
          )
        ],
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: userAccount?.avatarUrl.isNotEmpty == true
                  ? NetworkImage(userAccount!.avatarUrl)
                  : null,
              backgroundColor: context.colors.hint,
              radius: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  context.router.push(
                      CommentRoute(recipeId: widget.id, isWriteComment: true));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: context.colors.hint.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: context.colors.hint.withOpacity(0.5))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Viết bình luận...",
                    style: context.typographies.body
                        .withColor(context.colors.hint),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildSuggests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Có thể bạn quan tâm", style: context.typographies.title2),
        const SizedBox(
          height: 20,
        ),
        RecipeDetailsBuilder(
          builder: (context, state) {
            if (state.status == RecipeDetailsStatus.loadingSuggests) {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      const RecipeSkeleton(type: RecipeSearchType.NEWEST),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2));
            }
            if (state.status == RecipeDetailsStatus.loadedSuggests) {
              return GridView.builder(
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.suggests.length,
                  itemBuilder: (context, index) => RecipeItem(
                      recipe: state.suggests[index],
                      type: RecipeSearchType.NEWEST),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.75,
                      crossAxisCount: 2));
            }
            return Container();
          },
          statuses: const [
            RecipeDetailsStatus.loadedSuggests,
            RecipeDetailsStatus.loadingSuggests,
            RecipeDetailsStatus.failure
          ],
        ),
      ],
    );
  }
}
