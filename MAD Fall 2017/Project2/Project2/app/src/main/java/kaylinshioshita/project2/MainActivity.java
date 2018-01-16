package kaylinshioshita.project2;

/* Resources
Shared Preferences
https://www.journaldev.com/9412/android-shared-preferences-example-tutorial
List View
http://abhiandroid.com/ui/listview
Drawing on Canvas
http://android-coding.blogspot.com/2012/04/draw-arc-on-canvas-canvasdrawarc.html
 */

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Set;

public class MainActivity extends AppCompatActivity {

    Button startButton;
    Button pauseButton;
    Button resetButton;
    TimePicker myTimePicker;
    TextView timeUpText;
    boolean isTimerRunning=false;
    boolean isTimerPaused=false;
    CountDownTimer myTimer;
    long seconds;
    float originalSecs;

    TextView stepText;
    Button prevButton;
    Button nextButton;
    Button startOverButton;

    ArrayList<Regimen> regimens=new ArrayList<Regimen>();
    ArrayList<String> regimenTitles=new ArrayList<String>();
    MyView drawingCanvas;
    Spinner regimenSpinner;
    int stepCounter;
    Regimen activeRegimen=new Regimen();
    SharedPreferences.Editor editor;
    String keyname;
    int keycount;
    SharedPreferences pref;
    ImageView backgroundimg;

//    @RequiresApi(api = Build.VERSION_CODES.M)
    @SuppressLint("NewApi")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getWindow().getDecorView().setBackgroundColor(Color.WHITE);

        //Spinner
        regimenSpinner=(Spinner)findViewById(R.id.spinner2);
        pref=getApplicationContext().getSharedPreferences("MyData",0);
        editor=pref.edit();

        timeUpText=(TextView)findViewById(R.id.textView);
        backgroundimg=(ImageView)findViewById(R.id.imageView);
        backgroundimg.setImageResource(R.drawable.background0);
        //Step text
        stepText=(TextView)findViewById(R.id.stepTextView);
        prevButton=(Button)findViewById(R.id.prevButton);
        nextButton=(Button)findViewById(R.id.nextButton);
        startOverButton=(Button)findViewById(R.id.startoverButton);

        //Timer
        myTimePicker = (TimePicker)findViewById(R.id.myTimePicker);
        myTimePicker.setIs24HourView(true);
        //Circle drawing
        drawingCanvas=(MyView)findViewById(R.id.myView);

        //Timer buttons
        pauseButton=(Button)findViewById(R.id.pauseButton);
        pauseButton.setEnabled(false);

        resetButton=(Button)findViewById(R.id.resetButton);
        resetButton.setEnabled(false);

        startButton=(Button)findViewById(R.id.startButton);


        //Default regimen
        Regimen defaultRegimen=new Regimen(); //Initialize new Regimen
        String[] def={"Oil Cleanser", "Water Based Cleanser", "Exfoliator", "Toner", "Essence", "Treatments", "Sheet Mask","Eye Cream", "Moisturizer","Sun Screen"};
        //Add Step objects to default regimen
        defaultRegimen.setTitle("Basic Routine");
        defaultRegimen.setActiveRegimen(true);
        activeRegimen=defaultRegimen;
        //add default regimen to arraylist of regimens
        regimens.add(defaultRegimen);
        int keystepsnum=def.length;
        keyname="keystep1";
        editor.putString("keytitle1", "Basic Routine");
        editor.putInt("keynumbersteps1",keystepsnum);
        for(int i=0;i<keystepsnum;i++){
            String keystepFormat=String.format("key1step%d",i);
//            System.out.println("keyStepFormat in onCreate: "+keystepFormat);
//            System.out.println("def[i]: "+def[i]);
            editor.putString(keystepFormat,def[i]);
        }

//        editor.putInt("keycount",1);
        editor.commit();

        if(!pref.contains("keycount")){
            editor.putInt("keycount", 1);
            editor.commit();
        }
        keycount=pref.getInt("keycount", 1);

        Set<String> readList=pref.getStringSet(keyname,null);
//        System.out.println("readList is "+readList.size());
        updateRegimens();
        updateSpinner();


        setActiveRegimen();
        displayStep();
        if (savedInstanceState !=null){
            stepCounter=savedInstanceState.getInt("savedStep");
            System.out.println("Savedstep: "+stepCounter);
            seconds=savedInstanceState.getInt("savedSeconds");
            isTimerRunning=savedInstanceState.getBoolean("isTimerRunning");
            isTimerPaused=savedInstanceState.getBoolean("isTimerPaused");
            int regimenSpinnerSavedPosition=savedInstanceState.getInt("activeRoutine");
            System.out.println(regimenSpinnerSavedPosition);

        }
        System.out.println("Keycounter on open is: "+keycount);



    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        outState.putInt("savedStep", stepCounter);
        outState.putInt("savedSeconds", (int) seconds);
        outState.putBoolean("isTimerRunning", isTimerRunning);
        outState.putBoolean("isTimerPaused", isTimerPaused);
        outState.putInt("activeRoutine", regimenSpinner.getSelectedItemPosition());
        System.out.println("saving: "+stepCounter);
        editor.putInt("keycount", keycount);
        editor.commit();
        super.onSaveInstanceState(outState);
    }

    @Override
    protected void onResume() {
        super.onResume();
        System.out.println("Resumed");
        keycount=pref.getInt("keycount", 3);
        System.out.println("on Resume Keycount is: "+keycount);
        updateRegimens();
    }

    public void updateRegimens(){
        regimens.clear();
//        System.out.println("Key count in updateRegimens "+keycount);
        for(int i=0;i<keycount; i++){
            Regimen newRegimen=new Regimen();
            String keystepFormat=String.format("keystep%d",i+1);
//            System.out.println("keystepFormat in updateregimens is "+ keystepFormat);
            String keytitleFormat=String.format("keytitle%d", i+1);
            String keystepnumFormat=String.format("keynumbersteps%d", i+1);
            int numbersteps=pref.getInt(keystepnumFormat, 1);
            String tempStepArray[]=new String[numbersteps];
            for(int j=0;j<numbersteps;j++){
                String keyFormat=String.format("key%dstep%d", i+1, j);
//                System.out.println("keyFormat"+keyFormat);
                tempStepArray[j]=pref.getString(keyFormat, null);
            }

            String tempTitle=pref.getString(keytitleFormat, null);
//            System.out.println("tempTitle in updateRegimen: "+tempTitle);

//            System.out.println("After convert to array");
            newRegimen.setSteps(tempStepArray);
            newRegimen.setTitle(tempTitle);
//            System.out.println("Values in Linked HashSet String object are:"  +tempSteps);
//            System.out.println("newRegimen index 0: "+newRegimen.getSteps().get(0));
            regimens.add(newRegimen);

        }
//        System.out.println("regimens size is "+regimens.size());
        updateSpinner();
    }


    public void updateSpinner(){

        //Check and set activeRegimen(Regimen)


        //Add regimen titles to Arraylist of strings
        regimenTitles.clear();
//        System.out.println("here");
        for (int i=0; i<regimens.size(); i++){
            regimenTitles.add(regimens.get(i).getTitle());
        }


        //Set spinner items from arraylist of titles
        ArrayAdapter<String> adapter=new ArrayAdapter<String>(
                this, android.R.layout.simple_dropdown_item_1line, regimenTitles);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        regimenSpinner.setAdapter(adapter);

        regimenSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

//                stepCounter=0;
                setActiveRegimen();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
    };

    @SuppressLint("NewApi")
    public void startTimer(View view){
        myTimePicker.setVisibility(View.INVISIBLE);
        if (isTimerRunning==false){
            if(isTimerPaused==true){

                myTimer=new CountDownTimer(seconds, 1000){
                    public void onTick(long millisUntilFinished){
                        seconds=seconds-1000;
                        timeUpText.setText(timeString(seconds/1000));
                        Log.d("seconds", String.format("%d", seconds/1000));
                        drawingCanvas.setSeconds(seconds, originalSecs);
                        drawingCanvas.invalidate();


                    }
                    public void onFinish(){
                        seconds=seconds-1000;
                        drawingCanvas.setSeconds(seconds, originalSecs);
                        drawingCanvas.invalidate();
//                        timeUpText.setText("Time's Up!");
                        Toast.makeText(getApplicationContext(), "Time's Up",Toast.LENGTH_LONG).show();
                        next();
                        startButton.setEnabled(true);
                        pauseButton.setEnabled(false);
                        resetButton.setEnabled(false);
                        pauseButton.setText("Pause");

                        isTimerPaused=false;
                        isTimerRunning=false;

                    }

                }.start();
                isTimerRunning=true;
                isTimerPaused=false;
            } else{

                long startTime=(long)myTimePicker.getHour()*60000+myTimePicker.getMinute()*1000;
                seconds=startTime;
                originalSecs=startTime;
                startButton.setEnabled(false);
                resetButton.setEnabled(true);
                pauseButton.setEnabled(true);
                myTimer=new CountDownTimer(seconds, 1000){
                    public void onTick(long millisUntilFinished){
                        seconds=seconds-1000;
                        timeUpText.setText(timeString(seconds/1000));
                        drawingCanvas.setSeconds(seconds, originalSecs);
                        drawingCanvas.invalidate();

                    }
                    public void onFinish(){
                        seconds=seconds-1000;
                        drawingCanvas.setSeconds(seconds, originalSecs);
                        drawingCanvas.invalidate();
                        Toast.makeText(getApplicationContext(), "Time's Up",Toast.LENGTH_LONG).show();
                        next();
                        isTimerPaused=false;
                        isTimerRunning=false;
                        startButton.setEnabled(true);
                        pauseButton.setEnabled(false);
                        resetButton.setEnabled(false);
                        pauseButton.setText("Pause");


                    }

                }.start();
                isTimerRunning=true;
                isTimerPaused=false;
            }

        }

    }

    public void stopTimer(View view){
        myTimer.cancel();
        if(isTimerPaused==false){
            isTimerRunning=false;
            isTimerPaused=true;
            pauseButton.setText("Resume");
        } else{
            isTimerRunning=false;
            isTimerPaused=true;
            startTimer(view);
            pauseButton.setText("Pause");

        }

        startButton.setEnabled(false);
        resetButton.setEnabled(true);

        pauseButton.setEnabled(true);

    }

    public void resetTimer(View view){
        resetT();
    }

    public void resetT(){
        if (isTimerRunning==true){
            myTimer.cancel();
        }
        drawingCanvas.setSeconds(0, 0);
        drawingCanvas.invalidate();
        isTimerRunning=false;
        isTimerPaused=false;
        pauseButton.setText("Pause");
        startButton.setEnabled(true);
        pauseButton.setEnabled(false);
        resetButton.setEnabled(false);
        myTimePicker.setVisibility(View.VISIBLE);
        timeUpText.setText("");
    }

    public void addNewRoutine(View view){
        Intent intent =new Intent(this, addRegimen.class);
        intent.putExtra("keycount", keycount);
        startActivity(intent);
//        editor.putString("firstsave","I'm here");
//        editor.commit();
        //Lazy routine
//        Step[] lazysteps={new Step("Oil Cleanser", "Oil Cleanser"), new Step("Water Based Cleanser", "Water Based Cleanser"), new Step("Toner", "Toner"), new Step("Essence", "Essence"), new Step("Treatments", "Treatments"),new Step("Moisturizer","Moisturizer"), new Step("Sun Screen", "Sun Screen")};
//        Regimen lazyRegimen=new Regimen();
//        lazyRegimen.setTitle("Lazy Routine");
//        lazyRegimen.setSteps(lazysteps);
//        lazyRegimen.setActiveRegimen(false);
//        //add lazy regimen to arrayList of regimens
//        regimens.add(lazyRegimen);
//        updateSpinner();
    }

    public void prevPushed(View view){
        prev();

    }

    public void prev(){
        resetT();
        if(stepCounter>0){
            stepCounter--;
        }
        Log.i("prevPushed", "prevPushed: hi");
        displayStep();
    }

    public void nextPushed(View view){
        next();
    }

    public void next(){
        resetT();
        int maxSteps=activeRegimen.getSteps().size();
        if(stepCounter<maxSteps-1){
            stepCounter+=1;
        }
        displayStep();
    }

    public void startover(){
        resetT();
        stepCounter=0;
        displayStep();
    }
    public void startOverPushed(View view){
        startover();
    }

    @SuppressLint("NewApi")
    public void displayStep(){
        int totalSteps=activeRegimen.getSteps().size()-1;
        System.out.println("Stepcounter in displayStep: "+stepCounter);
        System.out.println("active regimen's length: "+activeRegimen.getSteps().size());
        String step=activeRegimen.getSteps().get(stepCounter);
//        System.out.println("I'm here");
        switch (step){
            case "Oil Cleanser":
                backgroundimg.setImageResource(R.drawable.background0);
                myTimePicker.setHour(0);
                myTimePicker.setMinute(30);
                break;
            case "Water Based Cleanser":
                backgroundimg.setImageResource(R.drawable.background1);
                myTimePicker.setHour(1);
                myTimePicker.setMinute(0);
                break;
            case "Exfoliator":
                backgroundimg.setImageResource(R.drawable.background2);
                myTimePicker.setHour(1);
                myTimePicker.setMinute(0);
                break;
            case "Toner":
                backgroundimg.setImageResource(R.drawable.background3);
                myTimePicker.setHour(0);
                myTimePicker.setMinute(30);
                break;
            case "Essence":
                backgroundimg.setImageResource(R.drawable.background4);
                myTimePicker.setHour(0);
                myTimePicker.setMinute(30);
                break;
            case "Treatments":
                backgroundimg.setImageResource(R.drawable.background5);
                myTimePicker.setHour(0);
                myTimePicker.setMinute(30);
                break;
            case "Sheet Mask":
                backgroundimg.setImageResource(R.drawable.background6);
                myTimePicker.setHour(15);
                myTimePicker.setMinute(0);
                break;
            case "Eye Cream":
                backgroundimg.setImageResource(R.drawable.background7);
                myTimePicker.setHour(0);
                myTimePicker.setMinute(30);
                break;
            case "Moisturizer":
                backgroundimg.setImageResource(R.drawable.background8);
                myTimePicker.setHour(1);
                myTimePicker.setMinute(0);
                break;
            case "Sun Screen":
                backgroundimg.setImageResource(R.drawable.background9);
                myTimePicker.setHour(0);
                myTimePicker.setMinute(30);
        }
        if (stepCounter==totalSteps){
//            System.out.println("here");
            stepText.setText(String.format("Step: %d \n %s", stepCounter+1, activeRegimen.getSteps().get(stepCounter)));
            nextButton.setVisibility(View.INVISIBLE);
            prevButton.setVisibility(View.VISIBLE);
            prevButton.setText(String.format("Step: %d \n %s", stepCounter, activeRegimen.getSteps().get(stepCounter-1)));
        } else if(stepCounter==0){
            stepText.setText(String.format("Step: %d \n %s", stepCounter+1, activeRegimen.getSteps().get(stepCounter)));
            prevButton.setVisibility(View.INVISIBLE);
            nextButton.setVisibility(View.VISIBLE);
            nextButton.setText(String.format("Step: %d \n %s", stepCounter+2, activeRegimen.getSteps().get(stepCounter+1)));

        } else {
            stepText.setText(String.format("Step: %d \n %s", stepCounter+1, activeRegimen.getSteps().get(stepCounter)));
            prevButton.setVisibility(View.VISIBLE);
            prevButton.setText(String.format("Step: %d \n %s", stepCounter, activeRegimen.getSteps().get(stepCounter-1)));
            nextButton.setText(String.format("Step: %d \n %s", stepCounter+2, activeRegimen.getSteps().get(stepCounter+1)));
        }
    }

    public void setActiveRegimen(){
        String selectedtitle=String.valueOf(regimenSpinner.getSelectedItem());

        for(int i=0; i<regimens.size(); i++){
            if(regimens.get(i).getTitle().equals(selectedtitle)){
                activeRegimen=regimens.get(i);
                regimens.get(i).setActiveRegimen(true);
//                System.out.println("inside setActiveRegimen "+activeRegimen.getSteps().get(3).getName());

            } else {
                regimens.get(i).setActiveRegimen(false);
            }
//            stepCounter=0;
            displayStep();
        }

//        Log.i("activeRegimen", activeRegimen.getTitle());


    }



    public String timeString(long secs){
        long min=secs/60%60;
        long scnds=secs%60;
        return String.format("%d:%02d", min, scnds);
    }




}
