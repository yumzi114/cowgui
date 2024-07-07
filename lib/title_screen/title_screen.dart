// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../assets.dart';
import '../orb_shader/orb_shader_config.dart';
import '../orb_shader/orb_shader_widget.dart';
import '../styles.dart';
import 'particle_overlay.dart';
import 'title_screen_ui.dart';

enum Page {
  Device,
  LiveView,
  Defalut,
}

class AppState {
  Page page;
  String bt_description_over;
  AppState(this.page, this.bt_description_over);
  // Page get page {
  //   return this._page;
  // }

  // set page(Page page) {
  //   this._page = page;
  // }

  void chageBT(String desc) {
    this.bt_description_over = desc;
  }
}

class TitleScreen extends StatefulWidget {
  const TitleScreen({
    super.key,
  });

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen>
    with SingleTickerProviderStateMixin {
  //테스트 코드
  int _counter = 0;
  AppState app_state = AppState(Page.Defalut, "");
  var bt_description_over = '';
  var user_state = Page.LiveView;
  final _orbKey = GlobalKey<OrbShaderWidgetState>();

  /// Editable Settings
  /// 0-1, receive lighting strength
  final _minReceiveLightAmt = .35;
  final _maxReceiveLightAmt = .7;

  /// 0-1, emit lighting strength
  final _minEmitLightAmt = .5;
  final _maxEmitLightAmt = 1;

  /// Internal
  var _mousePos = Offset.zero;

  Color get _emitColor =>
      AppColors.emitColors[_difficultyOverride ?? _difficulty];
  Color get _orbColor =>
      AppColors.orbColors[_difficultyOverride ?? _difficulty];

  /// bt_descriptionly selected difficulty
  int _difficulty = 0;

  /// bt_descriptionly focused difficulty (if any)
  int? _difficultyOverride;
  double _orbEnergy = 0;
  double _minOrbEnergy = 0;

  double get _finalReceiveLightAmt {
    final light =
        lerpDouble(_minReceiveLightAmt, _maxReceiveLightAmt, _orbEnergy) ?? 0;
    return light + _pulseEffect.value * .05 * _orbEnergy;
  }

  double get _finalEmitLightAmt {
    return lerpDouble(_minEmitLightAmt, _maxEmitLightAmt, _orbEnergy) ?? 0;
  }

  late final _pulseEffect = AnimationController(
    vsync: this,
    duration: _getRndPulseDuration(),
    lowerBound: -1,
    upperBound: 1,
  );

  Duration _getRndPulseDuration() => 100.ms + 200.ms * Random().nextDouble();

  double _getMinEnergyForDifficulty(int difficulty) => switch (difficulty) {
        1 => 0.3,
        2 => 0.6,
        _ => 0,
      };

  @override
  void initState() {
    super.initState();
    _pulseEffect.forward();
    _pulseEffect.addListener(_handlePulseEffectUpdate);
  }

  void _handlePulseEffectUpdate() {
    if (_pulseEffect.status == AnimationStatus.completed) {
      _pulseEffect.reverse();
      _pulseEffect.duration = _getRndPulseDuration();
    } else if (_pulseEffect.status == AnimationStatus.dismissed) {
      _pulseEffect.duration = _getRndPulseDuration();
      _pulseEffect.forward();
    }
  }

  void _handleDifficultyPressed(int value) {
    setState(() {
      _counter++;
      switch (value) {
        case 0:
          this.app_state.page = Page.Device;
          break;
        case 1:
          this.app_state.page = Page.LiveView;
          break;
        case 2:
          this.app_state.page = Page.Defalut;
          break;
        default:
          // this.app_state.page = Page.Defalut;
          break;
      }
      _difficulty = value;
    });
    _bumpMinEnergy();
  }

  Future<void> _bumpMinEnergy([double amount = 0.1]) async {
    setState(() {
      _minOrbEnergy = _getMinEnergyForDifficulty(_difficulty) + amount;
    });
    await Future<void>.delayed(.2.seconds);
    setState(() {
      _minOrbEnergy = _getMinEnergyForDifficulty(_difficulty);
    });
  }

  void _handleStartPressed() => _bumpMinEnergy(0.3);

  void _handleDifficultyFocused(int? value) {
    setState(() {
      _difficultyOverride = value;
      switch (_difficultyOverride) {
        case 0:
          app_state.chageBT("장치 어저고 저쩌고");
          break;
        // print("0");
        case 1:
          app_state.chageBT("머 라이브 어쩌고 저쩌고");
          break;
        // print("1");
        case 2:
          app_state.chageBT("삼번째 버튼 어쩌고저쩌고");
          break;
        // print("2");
        default:
          app_state.chageBT("default");
          break;
        // print("default");
      }
      if (value == null) {
        _minOrbEnergy = _getMinEnergyForDifficulty(_difficulty);
      } else {
        _minOrbEnergy = _getMinEnergyForDifficulty(value);
      }
    });
  }

  /// Update mouse position so the orbWidget can use it, doing it here prevents
  /// btns from blocking the mouse-move events in the widget itself.
  void _handleMouseMove(PointerHoverEvent e) {
    setState(() {
      _mousePos = e.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: MouseRegion(
          onHover: _handleMouseMove,
          child: _AnimatedColors(
            orbColor: _orbColor,
            emitColor: _emitColor,
            builder: (_, orbColor, emitColor) {
              return Stack(
                children: [
                  /// Bg-Base
                  Image.asset(AssetPaths.titleBgBase),

                  /// Bg-Receive
                  _LitImage(
                    color: orbColor,
                    imgSrc: AssetPaths.titleBgReceive,
                    pulseEffect: _pulseEffect,
                    lightAmt: _finalReceiveLightAmt,
                  ),
                  Positioned.fill(
                    child: TitleScreenUi(
                      difficulty: _difficulty,
                      appstate: app_state,
                      bt_description: bt_description_over,
                      onDifficultyFocused: _handleDifficultyFocused,
                      onDifficultyPressed: _handleDifficultyPressed,
                      onStartPressed: _handleStartPressed,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 1.seconds, delay: .3.seconds);
            },
          ),
        ),
      ),
    );
  }
}

class _LitImage extends StatelessWidget {
  const _LitImage({
    required this.color,
    required this.imgSrc,
    required this.pulseEffect,
    required this.lightAmt,
  });
  final Color color;
  final String imgSrc;
  final AnimationController pulseEffect;
  final double lightAmt;

  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(color);
    return ListenableBuilder(
      listenable: pulseEffect,
      builder: (context, child) {
        return Image.asset(
          imgSrc,
          color: hsl.withLightness(hsl.lightness * lightAmt).toColor(),
          colorBlendMode: BlendMode.modulate,
        );
      },
    );
  }
}

class _AnimatedColors extends StatelessWidget {
  const _AnimatedColors({
    required this.emitColor,
    required this.orbColor,
    required this.builder,
  });

  final Color emitColor;
  final Color orbColor;

  final Widget Function(BuildContext context, Color orbColor, Color emitColor)
      builder;

  @override
  Widget build(BuildContext context) {
    final duration = .5.seconds;
    return TweenAnimationBuilder(
      tween: ColorTween(begin: emitColor, end: emitColor),
      duration: duration,
      builder: (_, emitColor, __) {
        return TweenAnimationBuilder(
          tween: ColorTween(begin: orbColor, end: orbColor),
          duration: duration,
          builder: (context, orbColor, __) {
            return builder(context, orbColor!, emitColor!);
          },
        );
      },
    );
  }
}
