package gitops.jwscalculator.sdk;

public class Calculate{
    public double doCalculate(ICalculate cal,double a,double b){
        return cal.calculate(a,b);
    }
}