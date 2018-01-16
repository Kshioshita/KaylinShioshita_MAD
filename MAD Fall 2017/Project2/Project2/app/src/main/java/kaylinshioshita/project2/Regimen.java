package kaylinshioshita.project2;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * Created by kaylinshioshita on 11/30/17.
 */

public class Regimen {
    private String title;
//    private String[] steps;
//    private ArrayList<String> steps=new ArrayList<String>();
//    private ArrayList<Step> steps=new ArrayList<Step>();
    private ArrayList<String> steps=new ArrayList<String>();
    private int stepCount=0;
    private boolean activeRegimen=false;

    public void setTitle(String newTitle){
        title=newTitle;
    }

    public void setSteps(String[] newSteps){
        steps.addAll(Arrays.asList(newSteps));
    }

    public void addStep(ArrayList<String> title, String newStep){
        title.add(newStep);
    }

    public void removeStep(ArrayList<String> title, String removeStep){
        title.remove(removeStep);
    }

    public void setActiveRegimen(boolean isActive){
        activeRegimen=isActive;
    }

    public ArrayList<String> getSteps(){
        return steps;
    }

    public String getTitle(){
        return title;
    }

    public boolean getActiveRegimen(){
        return activeRegimen;
    }

}
