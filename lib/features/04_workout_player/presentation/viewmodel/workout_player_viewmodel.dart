import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_detail_model.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_exercise_model.dart';

enum WorkoutStatus { initial, ready, playing, resting, paused, finished }

class WorkoutPlayerViewModel extends ChangeNotifier {
  final WorkoutDetail workout;
  Timer? _timer;

  // --- Trạng thái (State) ---
  WorkoutStatus _status = WorkoutStatus.initial;
  int _countdown = 0;
  int _currentExerciseIndex = 0;

  // --- Getters (Để View truy cập) ---
  WorkoutStatus get status => _status;
  int get countdown => _countdown;
  WorkoutExercise get currentExercise =>
      workout.exercises[_currentExerciseIndex];
  WorkoutExercise? get nextExercise {
    if (_currentExerciseIndex < workout.exercises.length - 1) {
      return workout.exercises[_currentExerciseIndex + 1];
    }
    return null;
  }

  double get progress => (_currentExerciseIndex + 1) / workout.exercises.length;

  WorkoutPlayerViewModel({required this.workout});

  // --- Lệnh (Commands) mà View sẽ gọi ---

  void startWorkout() {
    _status = WorkoutStatus.ready;
    _countdown = 3; // 3 giây chuẩn bị
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        _countdown--;
      } else {
        timer.cancel();
        _startExercise();
      }
      notifyListeners();
    });
  }

  void pauseWorkout() {
    _timer?.cancel();
    _status = WorkoutStatus.paused;
    notifyListeners();
  }

  void resumeWorkout() {
    if (status == WorkoutStatus.paused) {
      // Tiếp tục dựa trên trạng thái trước đó (đang tập hay đang nghỉ)
      // Ở đây ta đơn giản hóa là tiếp tục bài tập
      _startExercise(resume: true);
    }
  }

  void skipExercise() {
    _timer?.cancel();
    _startRest();
  }

  void skipRest() {
    if (status == WorkoutStatus.resting) {
      _timer?.cancel();
      _moveToNextExercise();
    }
  }

  void increaseRestTime() {
    if (status == WorkoutStatus.resting) {
      _countdown += 15;
      notifyListeners();
    }
  }

  // --- Logic nội bộ ---

  void _startExercise({bool resume = false}) {
    _status = WorkoutStatus.playing;
    if (!resume) {
      // Nếu không phải resume thì lấy thời gian từ đầu
      _countdown = currentExercise.value;
    }
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
      } else {
        timer.cancel();
        _startRest();
      }
      notifyListeners();
    });
  }

  void _startRest() {
    // Nếu là bài cuối cùng thì kết thúc
    if (_currentExerciseIndex >= workout.exercises.length - 1) {
      _finishWorkout();
      return;
    }

    _status = WorkoutStatus.resting;
    _countdown = 30; // 30 giây nghỉ
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
      } else {
        timer.cancel();
        _moveToNextExercise();
      }
      notifyListeners();
    });
  }

  void _moveToNextExercise() {
    _currentExerciseIndex++;
    _startExercise();
  }

  void _finishWorkout() {
    _status = WorkoutStatus.finished;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
