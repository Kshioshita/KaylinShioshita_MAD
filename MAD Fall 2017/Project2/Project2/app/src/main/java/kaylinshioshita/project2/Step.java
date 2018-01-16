package kaylinshioshita.project2;

/**
 * Created by kaylinshioshita on 12/7/17.
 */

public class Step {
    private String name;
    private String type;

    public Step(String initname,String inittype){
        name=initname;
        type=inittype;
    }

    public void setName(String newName){
        this.name=newName;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName(){
        return this.name;
    }

    public String getType(){
        return this.type;
    }
}
