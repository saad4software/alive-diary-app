
import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/presentation/screens/conversation/conversation_screen.dart';
import 'package:alive_diary/presentation/screens/home/home_bloc.dart';
import 'package:alive_diary/presentation/widgets/loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

@RoutePage()
class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);

    final textController = useTextEditingController();
    final memoryNameController = useTextEditingController();
    var textNode = FocusNode();

    final isListening = useState(false);
    final canWrite = useState<bool?>(null);

    // Create an AnimationController to manage the animation
    final AnimationController animationController = useAnimationController(
      duration: const Duration(seconds: 3),
    );

    void showText(String? text) async {
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      animationController.animateBack(0, duration: const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      textController.text = text ?? "";
      animationController.forward();
    }

    void typeText(String? text) async {
      // animationController.animateBack(0, duration: const Duration(seconds: 1));
      // await Future.delayed(const Duration(seconds: 2));
      textController.text = text ?? "";
      animationController.forward();

    }

    void clearText() async {
      animationController.animateBack(0, duration: const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
      textController.text = "";
      animationController.forward();
    }

    useEffect(() {
      return null;
    }, [locator<FlutterLocalization>().currentLocale.localeIdentifier]);

    void buildCreateMemoryDialog() {

      final dialog = AlertDialog(
        title: const Text('Name your memory'),
        content: Form(
          child: TextFormField(
            controller: memoryNameController,
            decoration: InputDecoration(
              hintText: "Graduation day",
              hintStyle: const TextStyle(color: Colors.black38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(width: 2),
              ),
              filled: true,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              bloc.add(HomeCreateMemoryEvent(
                memoryName: memoryNameController.text,
              ));
              memoryNameController.clear();
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      );

      // showDialog(context: context, builder: (context)=>dialog);


      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;      return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                opacity: a1.value,
                child: dialog,
                // AlertDialog(
                //   shape: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(16.0)),
                //   title: Text('Hello!!'),
                //   content: Text('How are you?'),
                // ),

              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          });


    }

    Widget buildFloatingButton() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(Icons.auto_fix_high_outlined),
            onPressed: () async {
              buildCreateMemoryDialog();
            },
          ),

          AvatarGlow(
            animate: isListening.value,
            glowColor: Theme.of(context).primaryColor,
            duration: const Duration(seconds: 2),
            repeat: true,
            child: FloatingActionButton(
              backgroundColor: Colors.purple,
              shape: const CircleBorder(),
              child: const Icon(Icons.keyboard_voice_sharp),
              onPressed: () async {
                bloc.add(HomeWriteTextEvent());
              },
            ),
          ),
        ],
      );
    }


    return Scaffold(
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state is HomeLoadingState
              ? const FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.purple,
                  shape: CircleBorder(),
                  child: LoadingWidget(
                    color: Colors.white,
                  ),
                )
              : buildFloatingButton();
        },
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/paper_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          // child: LinedTextField()
          child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) async {
              switch (state) {
                case HomeInitialState():
                  print("init");

                case HomeListeningState():
                  isListening.value = true;

                case HomeWriteTextState():
                  isListening.value = false;
                  canWrite.value = false;
                  typeText(state.text);
                  textNode.requestFocus();

                case HomeLoadingState():
                  // canWrite.value = false;
                  print("loading");

                case HomeStartState():
                  print("start");

                case HomeSuccessState():
                  showText(state.text);
                  canWrite.value = true;
                  bloc.add(HomeReadTextEvent(text: state.text));

                case HomeCreatedMemoryState():
                  appRouter.push(ConversationRoute(
                      item: state.memory,
                      type: ConversationType.createMemory,
                  ));

                case HomeErrorState():
                  showToast(state.errorMessage ?? "unexpected error");
              }
            },
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, widget) {
                  return TextField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    focusNode: textNode,
                    cursorHeight: 35,
                    style: GoogleFonts.caveat(
                      fontSize: 30,
                      color:
                          Colors.black.withOpacity(animationController.value),
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.send,
                    controller: textController,
                    maxLines: null,
                    onTap: () async {
                      if (canWrite.value == null) {
                        bloc.add(HomeStartEvent());
                      } else if (canWrite.value == true) {
                        clearText();
                      }
                    },
                    onSubmitted: (text) async {
                      bloc.add(HomeSendEvent(
                        text: textController.text,
                      ));
                    },
                  );
                },
              ),
            ),
          )),
    );
  }
}
