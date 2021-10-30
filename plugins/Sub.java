package gitops.jwscalculator.plugin;

import gitops.jwscalculator.sdk.ICalculate;

public class Sub implements ICalculate{
    private double result;
    public double calculate(double  m,double  n){
        result=m-n;
        System.out.println(m+"-"+n+"="+result);
        return result;
    }
}