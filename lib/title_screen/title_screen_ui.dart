// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../assets.dart';
import '../common/shader_effect.dart';
import '../common/ticking_builder.dart';
import '../common/ui_scaler.dart';
import '../styles.dart';
import 'title_screen.dart';

import 'package:cowtest/src/rust/api/test.dart';

class TitleScreenUi extends StatelessWidget {
  const TitleScreenUi({
    super.key,
    required this.difficulty,
    required this.appstate,
    required this.bt_description,
    required this.onDifficultyPressed,
    required this.onDifficultyFocused,
    required this.onStartPressed,
  });

  final int difficulty;
  final AppState appstate;
  final String bt_description;
  final void Function(int difficulty) onDifficultyPressed;
  final void Function(int? difficulty) onDifficultyFocused;
  final VoidCallback onStartPressed;

  // final _dylib = /* load library */;
  // final Native native = NativeImpl(_dylib);
  @override
  Widget build(BuildContext context) {
    // Page asdads =Page.Devic
    // String contens = switch (appstate.page.name) {
    //   // case Page.Device:
    //   "Device " => "Device",
    //   "LiveView" => "LiveView",
    //   _ => "Unknow",
    // };
    // print(appstate.page.name);
    // String test;
    //
    switch (this.appstate.page.name) {
      case "Device":
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
            child: Stack(
              children: [
                /// Title Text
                TopLeft(
                  child: UiScaler(
                    alignment: Alignment.topLeft,
                    child: _TitleText(
                        bt_description: appstate.bt_description_over),
                  ),
                ),

                /// Difficulty Btns
                BottomLeft(
                  child: UiScaler(
                    alignment: Alignment.bottomLeft,
                    child: _DifficultyBtns(
                      difficulty: difficulty,
                      onDifficultyPressed: onDifficultyPressed,
                      onDifficultyFocused: onDifficultyFocused,
                    ),
                  ),
                ),
                //Contents
                CenterRight(
                  child: UiScaler(
                    alignment: Alignment.centerRight,
                    child: _ContentView(
                      label: "Device contents Views......",
                      selected: difficulty == 3,
                      onPressed: () => onDifficultyPressed(3),
                      onHover: (over) => onDifficultyFocused(over ? 3 : null),
                    )
                        .animate()
                        .fadeIn(delay: 1.3.seconds, duration: .35.seconds)
                        .slide(begin: const Offset(0, .2)),
                  ),
                ),

                /// StartBtn
                // BottomRight(
                //   child: UiScaler(
                //     alignment: Alignment.bottomRight,
                //     child: Padding(
                //       padding: const EdgeInsets.only(bottom: 20, right: 40),
                //       child: _StartBtn(onPressed: onStartPressed),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        }
      case "LiveView":
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
            child: Stack(
              children: [
                /// Title Text
                TopLeft(
                  child: UiScaler(
                    alignment: Alignment.topLeft,
                    child: _TitleText(
                        bt_description: appstate.bt_description_over),
                  ),
                ),

                /// Difficulty Btns
                BottomLeft(
                  child: UiScaler(
                    alignment: Alignment.bottomLeft,
                    child: _DifficultyBtns(
                      difficulty: difficulty,
                      onDifficultyPressed: onDifficultyPressed,
                      onDifficultyFocused: onDifficultyFocused,
                    ),
                  ),
                ),
                //Contents
                CenterRight(
                  child: UiScaler(
                    alignment: Alignment.centerRight,
                    child: _ContentView(
                      label: "Live contents Views......",
                      selected: difficulty == 3,
                      onPressed: () => onDifficultyPressed(3),
                      onHover: (over) => onDifficultyFocused(over ? 3 : null),
                    )
                        .animate()
                        .fadeIn(delay: 1.3.seconds, duration: .35.seconds)
                        .slide(begin: const Offset(0, .2)),
                  ),
                ),

                /// StartBtn
                // BottomRight(
                //   child: UiScaler(
                //     alignment: Alignment.bottomRight,
                //     child: Padding(
                //       padding: const EdgeInsets.only(bottom: 20, right: 40),
                //       child: _StartBtn(onPressed: onStartPressed),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        }
      default:
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
            child: Stack(
              children: [
                /// Title Text
                TopLeft(
                  child: UiScaler(
                    alignment: Alignment.topLeft,
                    child: _TitleText(
                        bt_description: appstate.bt_description_over),
                  ),
                ),

                /// Difficulty Btns
                BottomLeft(
                  child: UiScaler(
                    alignment: Alignment.bottomLeft,
                    child: _DifficultyBtns(
                      difficulty: difficulty,
                      onDifficultyPressed: onDifficultyPressed,
                      onDifficultyFocused: onDifficultyFocused,
                    ),
                  ),
                ),
                //Contents
                CenterRight(
                  child: UiScaler(
                    alignment: Alignment.centerRight,
                    child: _ContentView(
                      label: "Defalut Views......",
                      selected: difficulty == 3,
                      onPressed: () => onDifficultyPressed(3),
                      onHover: (over) => onDifficultyFocused(over ? 3 : null),
                    )
                        .animate()
                        .fadeIn(delay: 1.3.seconds, duration: .35.seconds)
                        .slide(begin: const Offset(0, .2)),
                  ),
                ),

                /// StartBtn
                // BottomRight(
                //   child: UiScaler(
                //     alignment: Alignment.bottomRight,
                //     child: Padding(
                //       padding: const EdgeInsets.only(bottom: 20, right: 40),
                //       child: _StartBtn(onPressed: onStartPressed),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        }
    }
  }
}

class _TitleText extends StatelessWidget {
  // const _TitleText(
  //   int appstate,
  // );
  const _TitleText({
    // required this.appstate,
    required this.bt_description,
  });
  // final int appstate;
  final String bt_description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(-(TextStyles.h1.letterSpacing! * .5), 0),
              child: Text('증강과제', style: TextStyles.h1),
            ),
            Image.asset(AssetPaths.titleSelectedLeft, height: 65),
            Text('0', style: TextStyles.h2),
            Image.asset(AssetPaths.titleSelectedRight, height: 65),
          ], // Edit from here...
        ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
        Text('$bt_description', style: TextStyles.h3)
            .animate()
            .fadeIn(delay: 1.seconds, duration: .7.seconds),
      ], // to here.
    );
    //액션 추가시 코드
    // Widget content = Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const Gap(20),
    //     Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Transform.translate(
    //           offset: Offset(-(TextStyles.h1.letterSpacing! * .5), 0),
    //           child: Text('증강과제', style: TextStyles.h1),
    //         ),
    //         Image.asset(AssetPaths.titleSelectedLeft, height: 65),
    //         Text('$appstate', style: TextStyles.h2),
    //         Image.asset(AssetPaths.titleSelectedRight, height: 65),
    //       ],
    //     ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
    //     Text('$bt_description', style: TextStyles.h2)
    //         .animate()
    //         .fadeIn(delay: 1.seconds, duration: .7.seconds),
    //   ],
    // );
    // return Consumer<FragmentPrograms?>(
    //   builder: (context, fragmentPrograms, _) {
    //     if (fragmentPrograms == null) return content;
    //     return TickingBuilder(
    //       builder: (context, time) {
    //         return AnimatedSampler(
    //           (image, size, canvas) {
    //             const double overdrawPx = 30;
    //             final shader = fragmentPrograms.ui.fragmentShader();
    //             shader
    //               ..setFloat(0, size.width)
    //               ..setFloat(1, size.height)
    //               ..setFloat(2, time)
    //               ..setImageSampler(0, image);

    //             Rect rect = Rect.fromLTWH(-overdrawPx, -overdrawPx,
    //                 size.width + overdrawPx, size.height + overdrawPx);
    //             canvas.drawRect(rect, Paint()..shader = shader);
    //           },
    //           child: content,
    //         );
    //       },
    //     );
    //   },
    // );
  }
}

class _DifficultyBtns extends StatelessWidget {
  const _DifficultyBtns({
    required this.difficulty,
    required this.onDifficultyPressed,
    required this.onDifficultyFocused,
  });

  final int difficulty;
  final void Function(int difficulty) onDifficultyPressed;
  final void Function(int? difficulty) onDifficultyFocused;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _DifficultyBtn(
          label: 'DEVICES',
          selected: difficulty == 0,
          onPressed: () => onDifficultyPressed(0),
          onHover: (over) => onDifficultyFocused(over ? 0 : null),
        )
            .animate()
            .fadeIn(delay: 1.3.seconds, duration: .35.seconds)
            .slide(begin: const Offset(0, .2)),
        _DifficultyBtn(
          label: 'DEVICES',
          selected: difficulty == 1,
          onPressed: () => onDifficultyPressed(1),
          onHover: (over) => onDifficultyFocused(over ? 1 : null),
        )
            .animate()
            .fadeIn(delay: 1.5.seconds, duration: .35.seconds)
            .slide(begin: const Offset(0, .2)),
        _DifficultyBtn(
          label: 'SERVERDATA',
          selected: difficulty == 2,
          onPressed: () => onDifficultyPressed(2),
          onHover: (over) => onDifficultyFocused(over ? 2 : null),
        )
            .animate()
            .fadeIn(delay: 1.7.seconds, duration: .35.seconds)
            .slide(begin: const Offset(0, .2)),
        // _ViewContent(
        //   label: 'VIEW CONTENT',
        //   selected: difficulty == 3,
        //   onPressed: () => onDifficultyPressed(3),
        //   onHover: (over) => onDifficultyFocused(over ? 3 : null),
        // ),
        const Gap(20),
      ],
    );
  }
}

class _DifficultyBtn extends StatelessWidget {
  const _DifficultyBtn({
    required this.selected,
    required this.onPressed,
    required this.onHover,
    required this.label,
  });
  final String label;
  final bool selected;
  final VoidCallback onPressed;
  final void Function(bool hasFocus) onHover;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
      onPressed: onPressed,
      onHoverChanged: (_, state) => onHover.call(state.isHovered),
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 250,
            height: 60,
            child: Stack(
              children: [
                /// Bg with fill and outline
                AnimatedOpacity(
                  opacity: (!selected && (state.isHovered || state.isFocused))
                      ? 1
                      : 0,
                  duration: .3.seconds,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.1),
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                  ),
                ),

                if (state.isHovered || state.isFocused) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.1),
                    ),
                  ),
                ],

                /// cross-hairs (selected state)
                if (selected) ...[
                  CenterLeft(
                    child: Image.asset(AssetPaths.titleSelectedLeft),
                  ),
                  CenterRight(
                    child: Image.asset(AssetPaths.titleSelectedRight),
                  ),
                ],

                /// Label
                Center(
                  child: Text(label.toUpperCase(), style: TextStyles.btn),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    required this.selected,
    required this.onPressed,
    required this.onHover,
    required this.label,
  });
  final String label;
  final bool selected;
  final VoidCallback onPressed;
  final void Function(bool hasFocus) onHover;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
      onPressed: onPressed,
      onHoverChanged: (_, state) => onHover.call(state.isHovered),
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: 950,
            height: 850,
            child: Stack(
              children: [
                /// Bg with fill and outline
                AnimatedOpacity(
                  opacity: (!selected && (state.isHovered || state.isFocused))
                      ? 1
                      : 0,
                  duration: .3.seconds,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.1),
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                  ),
                ),

                if (state.isHovered || state.isFocused) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.5),
                    ),
                  ),
                ],

                /// cross-hairs (selected state)
                // if (selected) ...[
                //   CenterLeft(
                //     child: Image.asset(AssetPaths.titleSelectedLeft),
                //   ),
                //   CenterRight(
                //     child: Image.asset(AssetPaths.titleSelectedRight),
                //   ),
                // ],

                /// Label
                Center(
                  child: Text(label.toUpperCase(), style: TextStyles.btn),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class _ViewContent extends StatelessWidget {
//   const _ViewContent({
//     required this.selected,
//     required this.onPressed,
//     required this.onHover,
//     required this.label,
//   });
//   final String label;
//   final bool selected;
//   final VoidCallback onPressed;
//   final void Function(bool hasFocus) onHover;

//   @override
//   Widget build(BuildContext context) {
//     return FocusableControlBuilder(
//       onPressed: onPressed,
//       onHoverChanged: (_, state) => onHover.call(state.isHovered),
//       builder: (_, state) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             width: 250,
//             height: 60,
//             child: Stack(
//               children: [
//                 /// Bg with fill and outline
//                 AnimatedOpacity(
//                   opacity: (!selected && (state.isHovered || state.isFocused))
//                       ? 1
//                       : 0,
//                   duration: .3.seconds,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF00D1FF).withOpacity(.1),
//                       border: Border.all(color: Colors.white, width: 5),
//                     ),
//                   ),
//                 ),

//                 if (state.isHovered || state.isFocused) ...[
//                   Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF00D1FF).withOpacity(.1),
//                     ),
//                   ),
//                 ],

//                 /// cross-hairs (selected state)
//                 if (selected) ...[
//                   CenterLeft(
//                     child: Image.asset(AssetPaths.titleSelectedLeft),
//                   ),
//                   CenterRight(
//                     child: Image.asset(AssetPaths.titleSelectedRight),
//                   ),
//                 ],

//                 /// Label
//                 Center(
//                   child: Text(label.toUpperCase(), style: TextStyles.btn),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class _StartBtn extends StatefulWidget {
  const _StartBtn({required this.onPressed});
  final VoidCallback onPressed;

  @override
  State<_StartBtn> createState() => _StartBtnState();
}

class _StartBtnState extends State<_StartBtn> {
  AnimationController? _btnAnim;
  bool _wasHovered = false;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
      cursor: SystemMouseCursors.click,
      onPressed: widget.onPressed,
      builder: (_, state) {
        if ((state.isHovered || state.isFocused) &&
            !_wasHovered &&
            _btnAnim?.status != AnimationStatus.forward) {
          _btnAnim?.forward(from: 0);
        }
        _wasHovered = (state.isHovered || state.isFocused);
        return SizedBox(
          width: 520,
          height: 100,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset(AssetPaths.titleStartBtn)),
              if (state.isHovered || state.isFocused) ...[
                Positioned.fill(
                    child: Image.asset(AssetPaths.titleStartBtnHover)),
              ],
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('VIEW 어쩌고저쩌고',
                        style: TextStyles.btn
                            .copyWith(fontSize: 24, letterSpacing: 18)),
                  ],
                ),
              ),
            ],
          )
              .animate(autoPlay: false, onInit: (c) => _btnAnim = c)
              .shimmer(duration: .7.seconds, color: Colors.black),
        )
            .animate()
            .fadeIn(delay: 2.3.seconds)
            .slide(begin: const Offset(0, .2));
      },
    );
  }
}
