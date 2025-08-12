import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_routes.dart';
import 'package:recipe_app/utils/app_typography.dart';
import 'package:recipe_app/utils/size_helper.dart';
import 'package:recipe_app/widgets/app_button.dart';
import 'package:recipe_app/widgets/otp_input_field.dart';

class VerificationCodeFragment extends StatefulWidget {
  const VerificationCodeFragment({super.key});

  @override
  State<VerificationCodeFragment> createState() =>
      _VerificationCodeFragmentState();
}

class _VerificationCodeFragmentState extends State<VerificationCodeFragment> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late final ValueNotifier<int> _focusedIndex;
  Timer? _timer;
  int _remainingSeconds = 192; // 03:12
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());

    _focusedIndex = ValueNotifier<int>(0);

    // Menambahkan listener untuk update state ketika fokus berubah
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) _focusedIndex.value = i;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
      _startTimer();
    });
  }

  void _startTimer() {
    _timer?.cancel(); // Pastikan timer sebelumnya sudah berhenti
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        _timer?.cancel();
      }
    });
  }

  void _resendCode() {
    // Logika untuk mengirim ulang kode akan ada di sini.
    // Untuk sekarang, kita hanya mereset timer.
    setState(() {
      _remainingSeconds = 192; // Reset ke 03:12
      _isResendEnabled = false;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _focusedIndex.dispose();
    super.dispose();
  }

  void _submitCode() {
    _focusNodes.last.unfocus();
    final otpCode = _controllers.map((c) => c.text).join();
    print("verifikasi OTP $otpCode");
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: _focusedIndex,
          builder: (context, focusedIndex, _) {
            return ListView(
              padding: EdgeInsets.only(
                top:
                    SizeHelper.safePadding(context).top +
                    SizeHelper.fromFigmaWidth(43, context),
                left: SizeHelper.fromFigmaWidth(24, context),
                right: SizeHelper.fromFigmaWidth(24, context),
              ),
              children: [
                _buildHeading(),
                Gap(SizeHelper.fromFigmaHeight(32, context)),
                _buildOTPField(focusedIndex),
                Gap(SizeHelper.fromFigmaHeight(48, context)),
                _buildTimeExpires(),
                Gap(SizeHelper.fromFigmaHeight(24, context)),
                _buildButtonVerification(),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget _buildTimeExpires() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTypography.p2(context),
        children: [
          const TextSpan(text: "Code expires in: "),
          TextSpan(
            text: _formatDuration(_remainingSeconds),
            style: AppTypography.h3(
              context,
            ).copyWith(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonVerification() {
    return Column(
      children: [
        AppButton(label: "Verify", onPressed: () {}, type: ButtonType.primary),
        const Gap(16),
        AppButton(
          label: "Send again",
          onPressed: _isResendEnabled ? _resendCode : null,
          type: ButtonType.outlineSecondary,
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Column(
      children: [
        Text('Check your email', style: AppTypography.h1(context)),
        Gap(SizeHelper.fromFigmaHeight(8, context)),
        Text(
          'We.ve sent the code to your email',
          style: AppTypography.p1(
            context,
          ).copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }

  Widget _buildOTPField(int focusedIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 13,
      children: List.generate(4, (index) {
        return OtpInputField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          isFocused: focusedIndex == index,
          textInputAction: index < 3
              ? TextInputAction.next
              : TextInputAction.done,
          onChanged: (value) {
            // Pindah ke kanan jika ada input
            if (value.isNotEmpty) {
              if (index < 3) {
                _focusNodes[index + 1].requestFocus();
              } else {
                // Jika ini input terakhir, langsung submit
                _submitCode();
              }
            }
            // Pindah ke kiri jika menghapus (backspace)
            else if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          },
          onEditingComplete: () {
            // Aksi ketika tombol next/done di keyboard ditekan
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _submitCode();
            }
          },
        );
      }),
    );
  }
}
