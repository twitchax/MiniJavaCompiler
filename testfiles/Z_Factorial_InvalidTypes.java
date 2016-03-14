class Factorial{
    public static void main(String[] a){
	System.out.println(new Turtle().ComputeFac(10));
    }
}

class Fac {
    Snake a;
    public int ComputeFac(AwesomeSauce num) {
	bool num_aux ;
	if (num < 1)
	    num_aux = 1 ;
	else 
	    num_aux = num * (this.ComputeFac(num-1)) ;
	return num_aux ;
    }
    
    public Funky DoesNothing() {
        return new Funky();
    }

}
