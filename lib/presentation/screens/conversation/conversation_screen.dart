import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/presentation/screens/conversation/conversation_bloc.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
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


enum ConversationType { diary, memory, createMemory }

@RoutePage()
class ConversationScreen extends HookWidget {
  final DiaryModel? item;
  final ConversationType? type;
  const ConversationScreen({
    super.key,
    this.item,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ConversationBloc>(context);

    final textController = useTextEditingController();
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

      // SystemChannels.textInput.invokeMethod('TextInput.hide');
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

    var title = "${item?.firstName} ${item?.lastName}'s diary";
    switch (type) {

      case ConversationType.diary:
        title = "${item?.firstName} ${item?.lastName}'s diary";

      case ConversationType.memory:
        title = "${item?.title}";

      case ConversationType.createMemory:
        title = "Capture ${item?.title}";

      case null:
        // TODO: Handle this case.
        break;


    }

    return LayoutWidget(
      title: title,
      floatingActionButton: AvatarGlow(
        animate: isListening.value,
        glowColor: Theme
            .of(context)
            .primaryColor,
        duration: const Duration(seconds: 2),
        repeat: true,
        child: BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            return state is ConversationLoadingState ?
            const FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.purple,
              shape: CircleBorder(),
              child: LoadingWidget(color: Colors.white,),
            ) :
            FloatingActionButton(
              backgroundColor: Colors.purple,
              shape: const CircleBorder(),
              child: const Icon(Icons.keyboard_voice_sharp),
              onPressed: () async {

                bloc.add(ConversationWriteTextEvent());

              },
            );
          },
        ),
      ),
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/paper_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          // child: LinedTextField()
          child: BlocListener<ConversationBloc, ConversationState>(
            listener: (context, state) async {
              switch (state) {
                case ConversationInitial():
                  print("init");
                  break;

                case ConversationListeningState():
                  isListening.value = true;


                case ConversationWriteTextState():

                  isListening.value = false;
                  canWrite.value = false;
                  typeText(state.text);
                  textNode.requestFocus();


                case ConversationLoadingState():
                  // canWrite.value = false;
                  print("loading");
                  break;

                case ConversationStartState():
                  print("start");
                  break;

                case ConversationSuccessState():

                  showText(state.text);
                  canWrite.value = true;
                  bloc.add(ConversationReadTextEvent(text: state.text));

                case ConversationErrorState():
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
                      color: Colors.black.withOpacity(
                          animationController.value),
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.send,
                    controller: textController,
                    maxLines: null,
                    onTap: () async {
                      if(canWrite.value == null) {
                        bloc.add(ConversationStartEvent(
                            diary: item,
                            type: type,
                        ));

                      }else if (canWrite.value == true) {
                        clearText();
                      }

                    },
                    onSubmitted: (text) async {

                      bloc.add(ConversationSendEvent(
                        diary: item,
                        text: textController.text,
                        type: type,
                      ));

                    },
                    onChanged: (text)=>bloc.add(ConversationUpdateTextEvent(text: text)),
                  );
                },

              ),
            ),

          )
      ),
    );
  }
}
