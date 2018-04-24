package kaylinshioshita.skincaremanager;

import io.realm.RealmList;
import io.realm.RealmObject;
import io.realm.annotations.PrimaryKey;
import io.realm.annotations.Required;

/**
 * Created by kaylinshioshita on 4/23/18.
 */

public class Day extends RealmObject {
    @Required
    @PrimaryKey
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
}
