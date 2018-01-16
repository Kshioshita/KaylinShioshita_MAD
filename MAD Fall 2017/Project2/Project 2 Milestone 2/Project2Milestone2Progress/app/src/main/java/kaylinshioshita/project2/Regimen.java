package kaylinshioshita.project2;

import java.util.ArrayList;

/**
 * Created by kaylinshioshita on 11/30/17.
 */

public class Regimen {
    private String title;
    private ArrayList<String> steps;

    public void setTitle(String newTitle){
        title=newTitle;
    }

    public void setSteps(ArrayList<String> newSteps){
        steps=newSteps;
    }

    public void addStep(ArrayList<String> title, String newStep){
        title.add(newStep);
    }

    public void removeStep(ArrayList<String> title, String removeStep){
        title.remove(removeStep);
    }

}
