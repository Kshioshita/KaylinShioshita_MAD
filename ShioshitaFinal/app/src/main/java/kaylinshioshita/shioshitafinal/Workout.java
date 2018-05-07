package kaylinshioshita.shioshitafinal;

import java.util.ArrayList;

/**
 * Created by kaylinshioshita on 5/6/18.
 */

public class Workout {
    private String name;
    private String url;
    private int typeId;

    public Workout(String name, String url, int id){
        this.name=name;
        this.url=url;
        this.typeId=id;
    }
    public static ArrayList<Workout> cardios= new ArrayList<Workout>(){{
        add(new Workout("Running", "https://www.google.com/", 0));
    }};

    public static ArrayList<Workout> strengths= new ArrayList<Workout>(){{
        add(new Workout("Weightlifting", "https://www.google.com/", 1));
    }};

    public static ArrayList<Workout> flexibility= new ArrayList<Workout>(){{
        add(new Workout("Yoga", "https://www.google.com/", 2));
    }};





    public void setName(String name) {
        this.name = name;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getTypeId() {
        return typeId;
    }

    public String getName() {
        return name;
    }

    public String getUrl() {
        return url;
    }

    public String toString(){
        return this.name;
    }



}
