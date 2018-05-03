package kaylinshioshita.skincaremanager;

import io.realm.RealmList;
import io.realm.RealmObject;
import io.realm.annotations.PrimaryKey;

/**
 * Created by kaylinshioshita on 4/23/18.
 */

public class Data extends RealmObject {
    @PrimaryKey
    private String code;
//    private long id;
    private RealmList<Day> data;
    private int offset;


    public void setCode(String code) {
        this.code = code;
    }

    public void setData(RealmList<Day> data) {
        this.data = data;
    }

    public String getCode() {
        return code;
    }

    public RealmList<Day> getData() {
        return data;
    }


}
