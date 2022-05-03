class Interpreter {
  final String code;
  final String input;
  String output = '';

  final Map<int, int> tape = <int, int>{0: 0};

  int cPtr = 0; // Code Pointer
  int tPtr = 0; // Tape Pointer
  int iPtr = 0; // Input Pointer

  final Map<int, int> bracketLUT = <int, int>{};

  Interpreter(this.code, this.input) {
    final List<int> stack = <int>[];

    for (int i = 0; i < code.length; i++) {
      switch (code[i]) {
        case '[':
          stack.add(i);
          break;
        case ']':
          // TODO: Check stacksize
          final int s = stack.removeLast();
          bracketLUT[s] = i;
          bracketLUT[i] = s;
      }
    }

    // TODO: Check if stack is empty
  }

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
          tPtr--;
          _alloc();
          break;
        case ',':
          if (iPtr < input.length) {
            tape[tPtr] = ascii2Byte(input[iPtr++]);
          }
          break;
        case '.':
          output += byte2Ascii(tape[tPtr]!);
          break;
        case '[':
          if (tape[tPtr] == 0) cPtr = bracketLUT[cPtr]!;
          break;
        case ']':
          if (tape[tPtr] != 0) cPtr = bracketLUT[cPtr]!;
          break;
        // Otherwise not instr
      }

      cPtr++;
    }
  }

  bool isDone() => cPtr >= code.length;

  void _alloc() {
    for (int i = tape.length; i <= tPtr; i++) {
      tape[i] = 0;
    }
  }

  int ascii2Byte(String ascii) {
    return ascii.codeUnitAt(0);
  }

  String byte2Ascii(int byte) {
    return String.fromCharCode(byte);
  }

  // TODO: Implement tape wrapping
  void validateTape() {}

  // TODO: Implement Runtime bracket matcher
  int _findBracketMatch(int pos) {
    int res = -1;
    return res;
  }
}
