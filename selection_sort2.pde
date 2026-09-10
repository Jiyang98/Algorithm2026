//int[] arr = {20, 12, 32, 9};



//void setup() {  
//  int i;
//  for(i=0; i<arr.length; i++) {
//    print(arr[i], " ");
//  }
//  for (i=0; i<arr.length; i++) {
//    max = index = -1;
//    for(j=0; j<arr.length-i; j++) {
//      if (max<arr[j]) {
//        index = j;
//        max = arr[j];
//    }
//  }
//  tmp = arr[arr.length - i - 1];
//  arr[arr.length - i - 1] = max;
//  arr[index] = tmp;
//  for(i=0; i<arr.length; i++) {
//    print(arr[i], " ");
//}
 
 

//int[] arr = {20, 12, 32, 9};

//void setup() {
  
//  for (int i = 0; i < arr.length; i++) {
//    print(arr[i] + " ");
//  }
//  println();

//  int max, index, tmp;
//  for (int i = 0; i < arr.length; i++) {
//    max = -1;
//    index = -1;
//    for (int j = 0; j < arr.length - i; j++) {
//      if (max < arr[j]) {
//        index = j;
//        max = arr[j];
//      }
//    }
//    // 최댓값을 정렬 안 된 구간의 마지막 자리와 교환
//    tmp = arr[arr.length - i - 1];
//    arr[arr.length - i - 1] = max;
//    arr[index] = tmp;
//  }

//  for (int i = 0; i < arr.length; i++) {
//    print(arr[i] + " ");
//  }
//}

int[] arr;

void setup() {
  int i, j, max, index, tmp;
  arr = new int[16];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
  for(i=0; i<arr.length; i++) {
    print(arr[i], " ");
  }
  println();
  for(i=0; i<arr.length; i++) {
    max = index = -1;
    for(j=0; j<arr.length-i; j++) {
      if(max<arr[j]) {
        index = j;
        max = arr[j];
      }
    }
    tmp = arr[arr.length-i-1];
    arr[arr.length-i-1] = max;
    arr[index] = tmp;
  } 
  for(i=0; i<arr.length; i++) {
    print(arr[i], " ");
  }  
}

void draw() {
}




// 한번만 출력
//void setup() {  
  //size(600, 400);
  //println("in setup");
//}
// 계속 출력(무한)
//void draw() {
//  //line(random(600),random(400),random(600), random(400));
//  //println("in draw");
//}
