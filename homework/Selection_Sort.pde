int[] list = new int[1000];
println(list.length);

int i, j, max, index, tmp;

for(i=0; i<list.length; i++) {
  list[i] = (int)random(10000);
}

line(0,0, 100,100);

for(i=0; i<list.length; i++) {
  max = -1;
  index = -1;
  for(j=0; j<list.length-i-1; j++) {
    if(max < list[j]) {
      max = list[j];
      index = j;
    }
  }
  if(index != -1) {
    tmp = list[j];
    list[j] = max;
    list[index] = tmp;
  }
}


for(i=0; i<list.length; i++) {
  println(list[i]);
}
