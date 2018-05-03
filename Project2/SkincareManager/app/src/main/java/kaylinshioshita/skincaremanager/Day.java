package kaylinshioshita.skincaremanager;

import io.realm.RealmList;
import io.realm.RealmObject;
import io.realm.annotations.Required;

/**
 * Created by kaylinshioshita on 4/23/18.
 */

public class Day extends RealmObject{
    @Required
    private String notes;
    private RealmList<String> steps;
    private int condition;
    private String daycode;
    private int timeOfDay;

    public Day() {
        timeOfDay = -1;
        daycode = "";
        condition = 0;
        notes = "";
    }

    public int getCondition() {
        return condition;
    }

    public int getTimeOfDay() {
        return timeOfDay;
    }

    public RealmList<String> getSteps() {
        return steps;
    }

    public String getNotes() {
        return notes;
    }

    public String getDaycode() {
        return daycode;
    }

    public void setCondition(int condition){
        this.condition=condition;

    }

    public void setDaycode(String daycode) {
        this.daycode = daycode;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public void setSteps(RealmList<String> steps) {
        this.steps = steps;
    }

    public void setTimeOfDay(int timeOfDay) {
        this.timeOfDay = timeOfDay;
    }
}
