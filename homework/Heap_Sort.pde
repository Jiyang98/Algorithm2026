// Heap Sort
int[] arr;

void setup() {
  intArr(16);
  printArr();
  heapSort();
  printArr();
}

void intArr(int n) {
  int i;
  arr = new int[n];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
}

void printArr() {
  int i;
  for(i=0; i<arr.length; i++) {
    print(arr[i], " ");
  }
  println();
}

void heapSort() {
  int n = arr.length;
  buildHeap(n);              // 힙 만들기
  for(int i=n-1; i>=1; i--) {
    swap(0, i);               // A[1] <-> A[i] (0-based라 0과 i)
    heapify(0, i);            // 힙 복구
  }
}

void buildHeap(int n) {
  for(int i=n/2-1; i>=0; i--) {
    heapify(i, n);
  }
}

void heapify(int i, int size) {
  int smallest = i;
  int left = 2*i+1;
  int right = 2*i+2;

  if(left<size && arr[left]<arr[smallest]) smallest = left;
  if(right<size && arr[right]<arr[smallest]) smallest = right;

  if(smallest != i) {
    swap(i, smallest);
    heapify(smallest, size);   // 재귀적으로 아래쪽 힙 복구
  }
}

void swap(int a, int b) {
  int tmp = arr[a];
  arr[a] = arr[b];
  arr[b] = tmp;
}

void draw() {
}
