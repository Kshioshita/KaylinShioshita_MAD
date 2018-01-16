package kaylinshioshita.project2;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Set;

public class addRegimen extends AppCompatActivity {

    Spinner stepSpinner;
    ListView routineListView;
    ArrayList<String> routine=new ArrayList<String>();
    ArrayAdapter<String> arrayAdapter;
    ArrayList<String> rawSteps=new ArrayList<String>();
    int stepNumber=1;
    int routineNumber=1;
    int keynumber;
    SharedPreferences.Editor editor;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_regimen);

        SharedPreferences pref=getApplicationContext().getSharedPreferences("MyData",0);
        editor=pref.edit();
        String keyname=String.format("key%d",0);
        Set<String> readList=pref.getStringSet(keyname,null);
        stepSpinner=(Spinner)findViewById(R.id.stepSpinner);
        routineListView=(ListView)findViewById(R.id.listView);
        arrayAdapter=new ArrayAdapter<String>(this,R.layout.activity_main2, R.id.stepTextView, routine);
        routineListView.setAdapter(arrayAdapter);
        routineListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
              removeStep(position);
                System.out.println(position);
            }
        });

//        Intent intent=getIntent();
        keynumber=pref.getInt("keycount", 0);
        System.out.println("key count in addRegimen "+keynumber);



    }

    public void removeStep(int index){
        routine.remove(index);
        rawSteps.remove(index);
        stepNumber--;
        routine.clear();
        for(int i=0;i<rawSteps.size();i++){
            String newStepFormat=String.format("Step: %d %s", i+1, rawSteps.get(i));
            routine.add(newStepFormat);
        }
        updateListView();
    }
    public void saveRoutine(View view){
        EditText routineName=(EditText)findViewById(R.id.editText);
        String routineNameString=routineName.getText().toString();
        if(routineNameString.equals("")){
            Toast toast=Toast.makeText(getApplicationContext(), "Please Name Your Routine",Toast.LENGTH_LONG);
            toast.show();
        } else if(stepNumber==1){
            Toast toast=Toast.makeText(getApplicationContext(), "Add at Least 1 Step",Toast.LENGTH_LONG);
            toast.show();
        }
        else{
            keynumber++;
            String keytitle=String.format("keytitle%d", keynumber);
            String keysteps=String.format("keystep%d", keynumber);
            System.out.println("keytitle in addregimen: "+keytitle);
            LinkedHashSet<String> set=new LinkedHashSet<>(rawSteps);
            System.out.println("Values in Linked HashSet String object in addRegimen are:"  +set);
//            set.addAll(rawSteps);
            for(int i=0;i<set.size();i++){
                String keystepFormat=String.format("key%dstep%d",keynumber,i);
                System.out.println("keyStepFormat in onCreate: "+keystepFormat);
                editor.putString(keystepFormat, rawSteps.get(i));
            }
            int keystepsnum=rawSteps.size();
            String keystepsnumFormat=String.format("keynumbersteps%d", keynumber);
            editor.putInt(keystepsnumFormat,keystepsnum);
            System.out.println("Step length in addRegimen"+set.size());
            editor.putStringSet(keysteps,set);
            editor.putString(keytitle, routineNameString);
            System.out.println(keynumber);
            editor.putInt("keycount", keynumber);
            editor.commit();
        }

    }

    public void addStep(View view){
        String stepType=String.valueOf(stepSpinner.getSelectedItem());
        if(stepType.equals("Select Step Type")){
            Toast toast=Toast.makeText(getApplicationContext(), "Select Step Type",Toast.LENGTH_LONG);
            toast.show();
        } else{
            String stepFormat=String.format("Step: %d %s    ", stepNumber, stepType);
            System.out.println(stepType);
            rawSteps.add(stepType);
            routine.add(stepFormat);
            updateListView();
            stepNumber++;
        }


    }

    public void updateListView(){
        routineListView.setAdapter(arrayAdapter);
    }
}
