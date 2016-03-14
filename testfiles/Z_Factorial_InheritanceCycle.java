class Factorial{
    public static void main(String[] a){
	System.out.println(new Fac().ComputeFac(10));
    }
}

class Fac extends Fac4 {

    public int ComputeFac(int num) {
	int num_aux ;
	if (num < 1)
	    num_aux = 1 ;
	else 
	    num_aux = num * (this.ComputeFac(num-1)) ;
	return num_aux ;
    }

}

class Fac2 extends Fac {
    public int ComputeFac(int num) {
        return 0;
    }
}

class Fac3 extends Fac2 {
    
}

class Fac4 extends Fac3 {
    
}