package gitops.jwscalculator.plugin;

import gitops.jwscalculator.sdk.ICalculate;

public class Pow implements ICalculate{

	private double result;
	public double calculate(double a, double b){
		result = Math.pow(a,b);
		System.out.println(a + " ^ "+b+" = "+result);
		return result;
	
	}

}
