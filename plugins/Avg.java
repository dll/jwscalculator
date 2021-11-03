package gitops.jwscalculator.plugin;

import gitops.jwscalculator.sdk.ICalculate;

public class Avg implements ICalculate{

    private double result;
    public double calculate(double m,double n){
        result=(m+n)/2;
        System.out.println(m+"A"+n+"="+result);
        return result;
    }
}