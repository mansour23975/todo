import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_flutter_app/catalog/domain/models/todo.dart';
import 'package:todo_flutter_app/catalog/enums/request_state.dart';
import 'package:todo_flutter_app/catalog/view/home/bloc/home_bloc.dart';
import 'package:todo_flutter_app/catalog/view/home/bloc/home_event.dart';
import 'package:todo_flutter_app/catalog/view/home/bloc/home_state.dart';
import 'package:todo_flutter_app/catalog/view/home/todo_bloc/todo_bloc.dart';
import 'package:todo_flutter_app/catalog/view/home/view/components/todo_item.dart';
import 'package:todo_flutter_app/common/common.dart';
import 'package:todo_flutter_app/common/helper/flutter_toast_helper.dart';
import 'package:todo_flutter_app/common/widgets/Image_waiting_shimmer.dart';
import 'package:todo_flutter_app/common/widgets/custom_cached_image.dart';
import 'package:todo_flutter_app/out-buildings/dependency_injector.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  late HomeBloc _homeBloc;
  late TODOBloc _tODOBloc;
  bool isPageStatusLoading = false;
  late ScrollController _scrollController;
  ToDo _toDoModel = ToDo(userID: SharedData.shared.user?.id);
  @override
  void initState() {
    _homeBloc = getIt<HomeBloc>();
    _tODOBloc = getIt<TODOBloc>();
    _homeBloc.add(GetTodosList());
    _scrollController = ScrollController();
    //get next page when user reach end of list
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        getTodos();
      }
    });
    /*if (mounted) {
      eventBus.on<UpdateProductFavoriteEB>().listen((event) {
        setState(() {
          getFavourites();

        });
      });
    }*/
    super.initState();
  }

  void getTodos([bool fromStart = false]) {
    if (fromStart) {
      _homeBloc.state.skip = 0;
      _homeBloc.state.limit = 10;
      _homeBloc.state.requestState = RequestState.initial;
    }
    _homeBloc.add(GetTodosList());
  }

  @override
  void dispose() {
    _homeBloc.close();
    _tODOBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _openAddItemDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new item'),
          content: Container(
            padding: EdgeInsets.only(top: 20),
            height: 100,
            child: Column(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: 5,
                    left: 5,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    autofocus: true,
                    controller: _todoController,
                    maxLines: 2,
                    decoration: InputDecoration(hintText: 'Add a new todo item', border: InputBorder.none),
                  ),
                ),
              ),
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_todoController.text.isNotEmpty) {
                  _toDoModel.todoText =  _todoController.text;
                  _toDoModel.completed = false;
                  _tODOBloc.add(AddTodo(_toDoModel));

                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tdBGColor,
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddItemDialog,
        child: Icon(Icons.add),
      ),
      body: BlocListener<TODOBloc, TODOState>(
        bloc: _tODOBloc,
        listener: (context, state) {
          if(state is DeleteTodoLoading || state is AddTodoLoading){
            EasyLoading.show();
          }
          if(state is DeleteTodoSuccessfully){
            EasyLoading.dismiss();
            FlutterToastHelper.showSuccessFlutterToast(context: context, message: "Deleted Successfully");
          }
          if(state is AddTodoSuccessfully){
            EasyLoading.dismiss();
            _todoController.clear();
            Navigator.of(context).pop();
            FlutterToastHelper.showSuccessFlutterToast(context: context, message: "Added Successfully");
          }
          if(state is DeleteTodoError ){
            EasyLoading.dismiss();
            FlutterToastHelper.showErrorFlutterToast(context: context, message: state.message ?? "");
          }
          if(state is AddTodoError ){
            EasyLoading.dismiss();
            FlutterToastHelper.showErrorFlutterToast(context: context, message: state.message ?? "");
          }
        },
        child: RefreshIndicator.adaptive(
          backgroundColor: Platform.isIOS ? AppColors.primaryColor : AppColors.white,
          onRefresh: () {
            getTodos(true);
            return Future.delayed(const Duration(milliseconds: 0));
          },
          color: AppColors.primaryColor,
          child: CustomScrollView(controller: _scrollController, physics: BouncingScrollPhysics(), slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                      bloc: _homeBloc,
                      buildWhen: (previous, current) {
                        if (current.requestState == RequestState.nextPageLoading || current.requestState == RequestState.nextPageFailed) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state.requestState == RequestState.loading || state.requestState == RequestState.initial) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Center(child: const CircularProgressIndicator()),
                          );
                        }
                        if (state.requestState == RequestState.isGuest) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: const Center(
                              child: Text("Guest User"),
                            ),
                          );
                        }
                        if (state.requestState == RequestState.failed) {
                          return Padding(padding: const EdgeInsets.only(top: 150), child: Text(state.errorMessage ?? "error"));
                        }
                        return (state.todos?.isEmpty ?? true)
                            ? Padding(padding: const EdgeInsets.only(top: 150), child: Text("Empty List"))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: state.todos?.length ?? 0,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsetsDirectional.only(bottom: 8),
                                      itemBuilder: (BuildContext context, int index) => ToDoItem(
                                        todo: state.todos![index],
                                        onToDoChanged: _handleToDoChange,
                                        onDeleteItem: _deleteToDoItem,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }),
                  BlocBuilder<HomeBloc, HomeState>(
                      bloc: _homeBloc,
                      buildWhen: (previous, current) {
                        if (current.requestState == RequestState.nextPageLoading ||
                            current.requestState == RequestState.nextPageFailed ||
                            current.requestState == RequestState.nextPageLoaded) {
                          return true;
                        }

                        return false;
                      },
                      builder: (context, state) {
                        return state.requestState == RequestState.nextPageLoading
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : state.requestState == RequestState.nextPageFailed
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      state.errorMessage ?? 'error',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                      }),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      //todo.completed = !todo.completed;
    });
  }

  void _deleteToDoItem(int id) {
    _tODOBloc.add(DeleteTodo(id));
  }

  /*void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }*/

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {});
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColors.tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 40,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomCachedImage(
                  imageUrl: SharedData.shared.user?.image ?? "",
                  height: 40,
                  width: 40,
                  boxFit: BoxFit.cover,
                  placeholderWidget: const ImageWaitingShimmer(height: 22),
                  errorWidget: Image.asset(AppImages.test1, fit: BoxFit.cover, width: 22, height: 22),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'hello, ',
                      style: TextStyle(
                        fontSize: 20,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: _getName(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.logout,
          color: AppColors.primaryColor,
          size: 24,
        ),
      ]),
    );
  }

  String _getName() {
    var name = SharedData.shared.user?.firstName ?? "";
    return name.isNotEmpty ? name : "";
  }
}
