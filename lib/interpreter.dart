class Interpreter {
  final int cellSize = 256;
  // Tape wrap?
  // Cell wrap?

  String code = '';
  String input = '';
  String output = '';

  final Map<int, int> tape = <int, int>{0: 0};

  int cPtr = 0; // Code Pointer
  int tPtr = 0; // Tape Pointer
  int iPtr = 0; // Input Pointer

  final List<String> instructions = <String>[
    '+',
    '-',
    '>',
    '<',
    '.',
    ',',
    '[',
    ']',
    '#',
  ];

  /// Resets all pointers, the tape and output
  void reset() {
    cPtr = 0;
    tPtr = 0;
    iPtr = 0;
    tape.clear();
    tape[0] = 0;
    output = '';
  }

  /// Executes [size] steps of the code at current [cPtr]
  /// Return if execution is done
  bool step([int size = 1]) {
    for (int i = 0; i < size; i++) {
      if (cPtr2Loc() >= code.length) return true;

      switch (code[cPtr2Loc()]) {
        case '+':
          tape[tPtr] = (tape[tPtr]! + 1) % cellSize;
          break;
        case '-':
          tape[tPtr] = (tape[tPtr]! - 1) % cellSize;
          break;
        case '>':
          tPtr++;
          _alloc();
          break;
        case '<':
          tPtr--;
          if (tPtr < 0) {
            tPtr = 0;
            // Warning
            return true;
          }
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
          if (tape[tPtr] == 0) {
            final int? val = _findBracketMatch(cPtr);
            if (val != null) {
              cPtr = val;
            } else {
              return true;
            }
          }
          break;
        case ']':
          if (tape[tPtr] != 0) {
            final int? val = _findBracketMatch(cPtr);
            if (val != null) {
              cPtr = val;
            } else {
              return true;
            }
          }
          break;

        case '#':
          cPtr++;
          return true;
        // Otherwise not instr
      }

      cPtr++;
    }

    return cPtr >= code.length;
  }

  /// Expands the [tape] if [tPtr] is pointing to a larger memory location
  void _alloc() {
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

  /// Maps the code pointer to the location in the source code
  int cPtr2Loc() {
    int counter = 0;
    for (int i = 0; i < code.length; i++) {
      if (instructions.any((String instr) => code[i] == instr)) {
        if (counter++ == cPtr) {
          return i;
        }
      }
    }

    return code.length;
  }

  /// Checks [tape] for valid values and wraps if necessary
  void validateTape() {
    for (int i = 0; i < tape.length; i++) {
      tape[i] = tape[i]! % cellSize;
    }
  }

  int? _findBracketMatch(int pos) {
    final List<int> stack = <int>[];

    if (code[pos] == '[') {
      for (int i = pos; i < code.length; i++) {
        switch (code[i]) {
          case '[':
            stack.add(i);
            break;
          case ']':
            if (stack.isEmpty) {
              return null;
            }
            stack.removeLast();
            if (stack.isEmpty) {
              return i;
            }
        }
      }
      return null;
    }

    if (code[pos] == ']') {
      for (int i = pos; i >= 0; i--) {
        switch (code[i]) {
          case '[':
            if (stack.isEmpty) {
              return null;
            }
            stack.removeLast();
            if (stack.isEmpty) {
              return i;
            }
            break;
          case ']':
            stack.add(i);
            break;
        }
      }
      return null;
    }

    return null;
  }
}
