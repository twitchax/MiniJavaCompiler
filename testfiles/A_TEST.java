class Factorial{
    public static void main(String[] a) 
    {
	    new Start().Go();
    }
}

class Start3
{
    public void Go()
    {
        System.out.println("Enter a number: ");
        int num = System.compiler.atol(System.in.readln());
        System.out.println(num + " squared is " + (num*num));
        System.in.readln();
    }
}

class Start2
{
    public void Go()
    {
        System.out.println("Waiting...");
        
        System.in.readln();
        Awesome a = (new Awesome()).AwesomeConstructor(5, 6);
        a.AddRef();
        System.in.readln();
        a.Release();
        System.in.readln();
    } 
}

class Start 
{
    int[] array;
    
    public int Go()
    {
        int dummy;
        int k;
        
        System.out.println(false);
        
        Fac f;
        f = new Fac();
        dummy = f.SetA(3);
        dummy = f.SetB(4);
        System.out.println(f.AddAllAnd1(5, 6)); // 19
        f.WriteArgs(1, 2, 3, 4, 5, 6);
        
        Fac2 f2;
        f2 = new Fac2();
        dummy = f2.SetA(3);
        dummy = f2.SetB(4);
        System.out.println((f2).AddAllAnd1(5, 6)); // 19
        System.out.println((f2).AddAllAnd2(5, 6)); // 17
        
        System.out.println(11111111);
        
        //array = new int[134217728]; // 1 GB should fail.
        array = new int[10];
        
        k = 0;
        while(k < array.length)
        {
            array[k] = k + 10;
            k = k + 1;
        }
        
        k = 0;
        while(k < array.length)
        {
            System.out.println(array[k]);
            k += 1 + 1;
        }
        
        k = 0;
        System.out.println("Prefix: " + (++k));
        k = 0;
        System.out.println("Postfix: " + (k++));
        
        System.out.println("Cool!");
        System.out.println("Bro!");
        System.out.println(6 < 4);
        System.out.println("Awesome: " + (5 + 1) + ".");
        
        Fac facz;
        int awesome;
        if(5 == awesome = 6) 
        {
            System.out.println("YAY");
        }
        else
        {
            System.out.println("Fail!");
        }
        
        k = 10;
        System.out.println("15: " + (k += 5));
        System.out.println("10: " + (k -= 5));
        System.out.println("2: " + (k /= 5));
        System.out.println("16: " + (k *= 8));
        System.out.println("1: " + (k %= 5));
        
        String b = "";
        for(int lollerskates = 2; lollerskates < 1000000; lollerskates *= 0xa)
        {
            b = b + lollerskates + ", ";
        }
        System.out.println(b);
        
        b = "";
        for(int lollerskates = 2; lollerskates < 1000000; lollerskates *= 2)
        {
            b = b + lollerskates + ", ";
        }
        System.out.println(b);
        
        Fac blah;
        if(f2 instanceof Fac)
        {
            int dummy = 5;
            System.out.println();
            System.out.println("Win! " + dummy);
        }
        else
        {
            int dummy = 3;
            int dummy2;
            System.out.println("Fail!");
        }
        //dummy2 = 7;
        
        System.out.println(this.GetString(500));
        
        //return 0;
    }
    
    public String GetString(int x)
    {
        if(x > 100)
            return "Big!";
        else
            return "Small!";
    }
}

class Fac {
    int a;
    int b;
    
    public int GetA() { return a; }
    public int SetA(int i) { a = i; return i; }
    
    public int GetB() { return b; }
    public int SetB(int i) { b = i; return i; }
    
    public int AddAllAnd1(int x, int y)
    {
        int v;
        v = 1;
        return a + b + x + y + v;
    }
    
    public void WriteArgs(int t, int u, int v, int x, int y, int z)
    {
        System.out.println(t + ", " + u + ", " + v + ", " + x + ", " + y + ", " + z);
    }
}

class Fac2 extends Fac 
{
    int a;
    
    public int GetThisA() { return a; }
    public int SetThisA(int i) { a = i; return i; }
    
    public int AddAllAnd2(int x, int y)
    {
        int v;
        v = 2;
        return a + b + x + y + v;
    }
}

class SmartPointer
{
    int _refCount;
    
    public int AddRef()
    {
        return ++_refCount;
    }
    
    public int Release()
    {
        int count =  --_refCount;
        
        if(count <= 0)
        {
            this.Destroy();
        }
        else
        {}
        
        return count;
    }
    
    public void Destroy()
    {
        System.compiler.destroy(this);
    }
}

class Awesome extends SmartPointer
{
    int[] array;
    int a;
    int b;
    
    public Awesome AwesomeConstructor(int x, int y)
    {
        a = x;
        b = y;
        array = new int[134217727];
        
        return this;
    }
    
    public void Destroy()
    {
        System.compiler.destroy(array);
        System.compiler.destroy(this);
    }
}