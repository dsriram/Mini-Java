class one {
  public static void main(String[] args) {
  }
}
class two {
  int x;
  int y;
  int[] z;

  public int[] fun() {
    {
      y = z;
      z = this.fun();
      if (1<2+2)
        System.out.println(1);
      else 
        System.out.println(2);
    }
    return z;
  }
}