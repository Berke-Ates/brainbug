class Interpreter {
  String code = '';
  String input = '';
  String output = '';

  final Map<int, int> tape = <int, int>{0: 0};

  int cPtr = 0; // Code Pointer
  int tPtr = 0; // Tape Pointer
  int iPtr = 0; // Input Pointer

  final Map<int, int> bracketLUT = <int, int>{};
  bool isValid = true;

  /// Resets all pointers, the tape, LUT and output
  void reset() {
    cPtr = 0;
    tPtr = 0;
    iPtr = 0;
    tape.clear();
    tape[0] = 0;
    bracketLUT.clear();
    output = '';
  }

  /// Analyzes code for matching brackets and creates LUT
  void analyze() {
    bracketLUT.clear();
    final List<int> stack = <int>[];

    for (int i = 0; i < code.length; i++) {
      switch (code[i]) {
        case '[':
          stack.add(i);
          break;
        case ']':
          if (stack.isEmpty) {
            isValid = false;
            return;
          }
          final int s = stack.removeLast();
          bracketLUT[s] = i;
          bracketLUT[i] = s;
      }
    }

    if (stack.isNotEmpty) {
      isValid = false;
      return;
    }
    isValid = true;
  }

  /// Executes [size] steps of the code at current [cPtr]
  void step([int size = 1]) {
    if (isDone()) return;

    for (int i = 0; i < size; i++) {
      switch (code[cPtr]) {
        case '+':
          tape[tPtr] = (tape[tPtr]! + 1) % 256;
          break;
        case '-':
          tape[tPtr] = (tape[tPtr]! - 1) % 256;
          break;
        case '>':
          tPtr++;
          _alloc();
          break;
        case '<':
          // TODO: Check bounds
          tPtr--;
          _alloc();
          break;
        case ',':
          if (iPtr < input.length) {
            tape[tPtr] = ascii2Byte(input[iPtr++]);
          } else {
            tape[tPtr] = 0;
          }
          break;
        case '.':
          output += byte2Ascii(tape[tPtr]!);
          break;
        case '[':
          if (tape[tPtr] == 0) cPtr = _findBracketMatch(cPtr);
          break;
        case ']':
          if (tape[tPtr] != 0) cPtr = _findBracketMatch(cPtr);
          break;
        // Otherwise not instr
      }

      cPtr++;
    }
  }

  bool isDone() => cPtr >= code.length;

  /// Expands the [tape] if [tPtr] is pointing to a larger memory location
  void _alloc() {
    // TODO: Wrap or warning
    for (int i = tape.length; i <= tPtr; i++) {
      tape[i] = 0;
    }
  }

  static int ascii2Byte(String ascii) {
    return ascii.codeUnitAt(0);
  }

  static String byte2Ascii(int byte) {
    return String.fromCharCode(byte);
  }

  // TODO: Implement tape wrapping
  /// Checks [tape] for valid values and wraps if necessary
  void validateTape() {}

  // TODO: Implement Runtime bracket matcher
  int _findBracketMatch(int pos) {
    final int res = bracketLUT[pos] ?? 0;
    return res;
  }
}
