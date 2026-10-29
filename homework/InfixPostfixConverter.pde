import java.util.Stack;

String inputText = "3 + 4 * ( 2 - 1 )"; // 기본 입력값
String infixText = "";
String postfixText = "";
String resultText = "";

void setup() {
  size(720, 520);
  textFont(createFont("SansSerif", 18));
  calculate(); // 초기값으로 1회 계산 실행
}

void draw() {
  background(245);
  
  // Header
  fill(30);
  textSize(22);
  text("Infix & Postfix Calculator", 40, 45);
  
  // 1. 수식 입력창 UI
  stroke(180);
  fill(255);
  rect(40, 70, 640, 45, 8);
  
  fill(50);
  textSize(18);
  text("입력: " + inputText + (frameCount % 60 < 30 ? "|" : ""), 55, 100);
  
  // 가이드 메시지
  fill(120);
  textSize(12);
  text("* 토큰 구분을 위해 숫자, 연산자(+, -, *, /, ^), 괄호 사이에 공백을 넣어주세요.", 40, 132);
  text("* [Backspace]: 지우기 | [ENTER]: 계산 실행", 40, 150);
  
  // 2. 결과 출력 카드 UI
  stroke(220);
  fill(255);
  rect(40, 170, 640, 310, 10);
  
  // [1] 중위 표기법 (Infix Notation)
  fill(80);
  textSize(15);
  text("1. 중위 표기법 (Infix Expression)", 65, 210);
  fill(40, 120, 50); // 녹색 계열
  textSize(18);
  text(infixText, 65, 240);
  
  stroke(235);
  line(65, 260, 655, 260); // 구분선
  
  // [2] 후위 표기법 (Postfix Notation)
  fill(80);
  textSize(15);
  text("2. 후위 표기법 (Postfix Expression)", 65, 290);
  fill(0, 102, 204); // 파란색 계열
  textSize(18);
  text(postfixText, 65, 320);
  
  stroke(235);
  line(65, 340, 655, 340); // 구분선
  
  // [3] 최종 계산 결과
  fill(80);
  textSize(15);
  text("3. 최종 계산 결과 (Evaluated Value)", 65, 370);
  fill(204, 0, 0); // 빨간색 계열
  textSize(24);
  text(resultText, 65, 410);
}

// -------------------------------------------------------------
// 키보드 입력 처리
// -------------------------------------------------------------
void keyPressed() {
  if (key == ENTER || key == RETURN) {
    calculate();
  } 
  else if (key == BACKSPACE) {
    if (inputText.length() > 0) {
      inputText = inputText.substring(0, inputText.length() - 1);
    }
  } 
  else if (key != CODED) {
    if (Character.isDigit(key) || "+-*/^() .".indexOf(key) != -1) {
      inputText += key;
    }
  }
}

// -------------------------------------------------------------
// 계산 실행 로직
// -------------------------------------------------------------
void calculate() {
  if (inputText.trim().isEmpty()) {
    infixText = "";
    postfixText = "";
    resultText = "";
    return;
  }
  
  try {
    // 1. 공백 정돈된 중위 표기법(Infix) 텍스트 생성
    infixText = formatInfix(inputText);
    
    // 2. Infix -> Postfix 변환
    postfixText = infixToPostfix(inputText);
    
    // 3. Postfix 수식 연산 결과 계산
    double res = evaluatePostfix(postfixText);
    resultText = String.valueOf(res);
  } catch (Exception e) {
    infixText = inputText.trim();
    postfixText = "수식 오류 (괄호 짝 및 연산자 배치를 확인하세요)";
    resultText = "Error";
  }
}

// -------------------------------------------------------------
// 입력된 중위 표기법 공백 및 포맷 정리 함수
// -------------------------------------------------------------
String formatInfix(String exp) {
  String[] tokens = exp.trim().split("\\s+");
  StringBuilder sb = new StringBuilder();
  for (String token : tokens) {
    if (!token.isEmpty()) {
      sb.append(token).append(" ");
    }
  }
  return sb.toString().trim();
}

// -------------------------------------------------------------
// 1. 연산자 우선순위
// -------------------------------------------------------------
int precedence(char op) {
  if (op == '+' || op == '-') return 1;
  if (op == '*' || op == '/') return 2;
  if (op == '^') return 3;
  return -1;
}

// -------------------------------------------------------------
// 2. Infix -> Postfix 변환
// -------------------------------------------------------------
String infixToPostfix(String exp) {
  StringBuilder result = new StringBuilder();
  Stack<Character> stack = new Stack<>();
  String[] tokens = exp.trim().split("\\s+");
  
  for (String token : tokens) {
    if (token.isEmpty()) continue;
    
    char c = token.charAt(0);
    
    // 피연산자 (숫자)
    if (Character.isDigit(c) || (token.length() > 1 && Character.isDigit(token.charAt(1)))) {
      result.append(token).append(" ");
    } 
    else if (c == '(') {
      stack.push(c);
    } 
    else if (c == ')') {
      while (!stack.isEmpty() && stack.peek() != '(') {
        result.append(stack.pop()).append(" ");
      }
      if (!stack.isEmpty() && stack.peek() == '(') {
        stack.pop();
      }
    } 
    else {
      while (!stack.isEmpty() && precedence(c) <= precedence(stack.peek())) {
        result.append(stack.pop()).append(" ");
      }
      stack.push(c);
    }
  }
  
  while (!stack.isEmpty()) {
    result.append(stack.pop()).append(" ");
  }
  
  return result.toString().trim();
}

// -------------------------------------------------------------
// 3. Postfix 수식 계산
// -------------------------------------------------------------
double evaluatePostfix(String exp) {
  Stack<Double> stack = new Stack<>();
  String[] tokens = exp.trim().split("\\s+");
  
  for (String token : tokens) {
    if (token.isEmpty()) continue;
    
    if (Character.isDigit(token.charAt(0)) || (token.length() > 1 && Character.isDigit(token.charAt(1)))) {
      stack.push(Double.parseDouble(token));
    } 
    else {
      double val2 = stack.pop();
      double val1 = stack.pop();
      
      switch (token.charAt(0)) {
        case '+': stack.push(val1 + val2); break;
        case '-': stack.push(val1 - val2); break;
        case '*': stack.push(val1 * val2); break;
        case '/': stack.push(val1 / val2); break;
        case '^': stack.push(Math.pow(val1, val2)); break;
      }
    }
  }
  
  return stack.pop();
}
