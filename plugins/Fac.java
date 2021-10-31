package gitops.jwscalculator.plugin;

import gitops.jwscalculator.sdk.ICalculate;

//factorial:5!=1*2*3*4*5=120
public class Fac implements ICalculate{
    private double result;
    public double calculate(double  m,double  n){
		result= 0.0;
        if(0>n || 0>m){
			System.out.println("ERROR: ! greater than 0!");
			return 0.0;
		}
		result= factorial((int)m);
		System.out.println(m+"!="+factorial((int)m));
		System.out.println(n+"!="+factorial((int)n));
		return result;
    }
    private int factorial(int a){
		if(0>a||a>=13){
			System.out.println("Intger Factorial Range is [0  12],13! =6227020800,13! !=1932053504");
			return 0;
		}
		if(0==a)
			return 1;
		int f=1;
		for(int i=1;i<=a;i++)
			f=f*i;
		return f;
    }
}
