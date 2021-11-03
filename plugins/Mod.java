package gitops.jwscalculator.plugin;

import gitops.jwscalculator.sdk.ICalculate;

public class Mod implements ICalculate{
    private double result;
    public double calculate(double  m,double  n){
        if(0==n){
		System.out.println("ERROR: % by zero!");
		return 0.0;
	}
	result= (int)m%(int)n;
        System.out.println(m+"%"+n+"="+(int)result);
        return result;
    }
}
