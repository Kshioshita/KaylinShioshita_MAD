package kaylinshioshita.kaylinshioshitafinal;

/**
 * Created by kaylinshioshita on 12/17/17.
 */

public class BurritoPlace {
    private String burritoPlace;
    private String burritoUrl;

    public void setBurritoPlace(String location){
        if(location.equals("The Hill")){
            burritoPlace="Illegal Petes";
            burritoUrl="http://illegalpetes.com/";

        }else if(location.equals("29th Street")){
            burritoPlace="Chipotle";
            burritoUrl="https://www.chipotle.com/";
        }else{
            burritoPlace="Bartaco";
            burritoUrl="https://bartaco.com/";
        }
    }

    public String getBurritoPlace() {
        return burritoPlace;
    }

    public String getBurritoUrl() {
        return burritoUrl;
    }
}
