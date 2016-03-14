class Factorial{
    public static void main(String[] a){
	System.out.println(new Fac().ComputeFac(10));
    }
}

class Fac {

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
    public boolean DoStuff(Fac fac) {
        return false;
    }
}

class HasErrors {
    public boolean IsAwesome(int num, boolean bool, Fac fac) {
        
        int num1;
        int[] intArray;
        boolean bool1;
        Fac fac1;
        Fac2 fac2;
        
        fac1 = new Fac2();
        fac2 = fac1; // error
        
        intArray = new int[40];
        intArray[bool] = 5; // error
        intArray[num] = num1;
        intArray[num] = fac; // error
        
        if(bool && num) { // error
            fac1 = num; // error
        } else {
            bool1 = fac1; // error
        }
        
        while(num) { // error
            System.out.println(new Fac()); // error
        }
        
        while(!(num > 3) && !(num1 <= 6) || (fac1 == fac) || (fac1 != fac)) {
            bool = (num + 6) < 4;
        }
        
        num1 = bool1 + bool; // 2 errors
        
        num = (new Fac().ComputeFac(!bool)); // error
        num1 = (new Fac().ComputeFac(num + num1 * (num % num1)));
        
        while(fac2.DoStuff(fac1)) {
            bool = fac2.DoStuff(); // error
            bool = fac2.DoStuff(fac2);
            bool = fac2.DoStuff(intArray); // error
        }
        
        bool1 = !fac; // error
        
        return num + num1; // error
    }
}

// Total errors: 15