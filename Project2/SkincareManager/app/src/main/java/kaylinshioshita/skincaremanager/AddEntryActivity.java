package kaylinshioshita.skincaremanager;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ToggleButton;

import io.realm.Realm;
import io.realm.RealmList;
import io.realm.RealmResults;


//Resources
//Toggle Image Button
//https://robusttechhouse.com/tutorial-how-to-make-a-toggle-button-with-two-images/
public class AddEntryActivity extends AppCompatActivity {

    String year;
    String month;
    String dayofmonth;

    String updatecode;
    boolean update;
    int updatePosition;

    ImageButton oilBtn;
    ImageButton waterBtn;
    ImageButton exfoliatorBtn;
    ImageButton tonerBtn;
    ImageButton essenceBtn;
    ImageButton treatmentBtn;
    ImageButton maskBtn;
    ImageButton eyeBtn;
    ImageButton moisturizerBtn ;
    ImageButton sunBtn;
    ImageButton otherBtn;

    ImageButton terribleBtn ;
    ImageButton badBtn;
    ImageButton fineBtn;
    ImageButton goodBtn ;
    ImageButton greatBtn;

    ToggleButton toggleButton;

    EditText editText;

//    String code;
    int condition= -1;

    private Realm realm;
    RealmResults<Data> data;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d("addentry", "ok");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_entry);
        Intent i = getIntent();
        year=i.getStringExtra("year");
        dayofmonth=i.getStringExtra("day");
        month=i.getStringExtra("month");
        update=i.getBooleanExtra("update", false);
        updatePosition=i.getIntExtra("index", -1);
        updatecode=i.getStringExtra("code");




        Log.d("addentry", "hi");
        realm=Realm.getDefaultInstance();
        Log.d("addentry", "here");


        final String code = dayofmonth+month+year;
        data = realm.where(Data.class).contains("code", code).findAll();
        Data oneday=realm.where(Data.class).contains("code", updatecode).findFirst();
        RealmResults<Data> alldata=realm.where(Data.class).findAll();
        Log.d("addentry alldatasize", String.valueOf(alldata.size()));
//        Log.d("add entry code is", updatecode);
//        for (int x = 0; x<alldata.size();x++){
//            alldata.get(x).getCode();
//        }
//        Log.d("addentry data size", String.valueOf(data.size()));
        oilBtn = (ImageButton)findViewById(R.id.imageButtonOil);
        waterBtn = (ImageButton)findViewById(R.id.imageButtonWater);
        exfoliatorBtn = (ImageButton)findViewById(R.id.imageButtonExfoliator);
        tonerBtn = (ImageButton)findViewById(R.id.imageButtonToner);
        essenceBtn = (ImageButton)findViewById(R.id.imageButtonEssence);
        treatmentBtn = (ImageButton)findViewById(R.id.imageButtonTreatments);
        maskBtn = (ImageButton)findViewById(R.id.imageButtonMask);
        eyeBtn = (ImageButton)findViewById(R.id.imageButtonEye);
        moisturizerBtn = (ImageButton)findViewById(R.id.imageButtonMoisturizer);
        sunBtn = (ImageButton)findViewById(R.id.imageButtonSun);
        otherBtn = (ImageButton)findViewById(R.id.imageButtonOther);
//        Log.d("oncreate datalength", String.valueOf(data.size()));

        terribleBtn = (ImageButton)findViewById(R.id.imageButtonTerrible);
        badBtn = (ImageButton)findViewById(R.id.imageButtonBad);
        fineBtn = (ImageButton)findViewById(R.id.imageButtonFine);
        goodBtn = (ImageButton)findViewById(R.id.imageButtonGood);
        greatBtn = (ImageButton)findViewById(R.id.imageButtonGreat);

        toggleButton = (ToggleButton)findViewById(R.id.toggleButton);

        editText = (EditText)findViewById(R.id.editText3);

        if (update==true){
            Log.d("addentry", String.valueOf(updatePosition));
            Day updateentry=oneday.getData().get(updatePosition);
            Log.d("addentry", String.valueOf(updateentry.getCondition()));
            Log.d("addentry", String.valueOf(updateentry.getSteps()));
            for (int y=0; y<updateentry.getSteps().size(); y++){
                if (updateentry.getSteps().get(y).equals( "Oil")){
                    Log.d("addentry", "inside oil");
                    oilBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Water")){
                    waterBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Exfoliator")){
                    exfoliatorBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Toner")){
                    tonerBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Essence")){
                    essenceBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Treatment")){
                    treatmentBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Mask")){
                    maskBtn.setActivated(true);
                }else if(updateentry.getSteps().get(y).equals( "Eye")){
                    eyeBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Moisturizer")){
                    moisturizerBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals("Sun")){
                    sunBtn.setActivated(true);
                }else if (updateentry.getSteps().get(y).equals( "Other")){
                    otherBtn.setActivated(true);
                }
            }
            if (updateentry.getTimeOfDay()==0){
                toggleButton.setChecked(true);
            }else{
                toggleButton.setChecked(false);
            }

            if (updateentry.getNotes()!=null){
                editText.setText(updateentry.getNotes());
            }

            if (updateentry.getCondition()==0){
                terribleBtn.setImageResource(R.drawable.terribles);
            }else if (updateentry.getCondition()==1){
                badBtn.setImageResource(R.drawable.bads);
            }else if(updateentry.getCondition()==2){
                fineBtn.setImageResource(R.drawable.fines);
            }else if(updateentry.getCondition()==3){
                goodBtn.setImageResource(R.drawable.goods);
            }else{
                greatBtn.setImageResource(R.drawable.greats);
            }

        }
    }

    public void changeCondition(View view){
        Log.d("view", String.valueOf(view));
        int button = view.getId();
        Log.d("view id", String.valueOf(button));

        int terribleId = terribleBtn.getId();
        Log.d("terrible id", String.valueOf(terribleBtn.getId()));
        if (button==terribleId){
            condition=0;
            terribleBtn.setImageResource(R.drawable.terribles);
            badBtn.setImageResource(R.drawable.bad);
            fineBtn.setImageResource(R.drawable.fine);
            goodBtn.setImageResource(R.drawable.good);
            greatBtn.setImageResource(R.drawable.great);
        } else if (button == badBtn.getId()){
            condition=1;
            terribleBtn.setImageResource(R.drawable.terrible);
            badBtn.setImageResource(R.drawable.bads);
            fineBtn.setImageResource(R.drawable.fine);
            goodBtn.setImageResource(R.drawable.good);
            greatBtn.setImageResource(R.drawable.great);
        } else if (button == fineBtn.getId()){
            condition=2;
            terribleBtn.setImageResource(R.drawable.terrible);
            badBtn.setImageResource(R.drawable.bad);
            fineBtn.setImageResource(R.drawable.fines);
            goodBtn.setImageResource(R.drawable.good);
            greatBtn.setImageResource(R.drawable.great);
        } else if (button == goodBtn.getId()){
            condition=3;
            terribleBtn.setImageResource(R.drawable.terrible);
            badBtn.setImageResource(R.drawable.bad);
            fineBtn.setImageResource(R.drawable.fine);
            goodBtn.setImageResource(R.drawable.goods);
            greatBtn.setImageResource(R.drawable.great);
        } else {
            condition=4;
            terribleBtn.setImageResource(R.drawable.terrible);
            badBtn.setImageResource(R.drawable.bad);
            fineBtn.setImageResource(R.drawable.fine);
            goodBtn.setImageResource(R.drawable.good);
            greatBtn.setImageResource(R.drawable.greats);
        }
    }

    public void toggleStepButton(View view){

        int button = view.getId();

        if (button==oilBtn.getId()){
            oilBtn.setActivated(!oilBtn.isActivated());
        } else if (button==waterBtn.getId()){
            waterBtn.setActivated(!waterBtn.isActivated());
        } else if (button==exfoliatorBtn.getId()){
            exfoliatorBtn.setActivated(!exfoliatorBtn.isActivated());
        } else if (button==tonerBtn.getId()){
            tonerBtn.setActivated(!tonerBtn.isActivated());
        } else if (button==essenceBtn.getId()){
            essenceBtn.setActivated(!essenceBtn.isActivated());
        } else if (button==treatmentBtn.getId()){
            treatmentBtn.setActivated(!treatmentBtn.isActivated());
        } else if (button==maskBtn.getId()){
            maskBtn.setActivated(!maskBtn.isActivated());
        } else if (button==eyeBtn.getId()){
            eyeBtn.setActivated(!eyeBtn.isActivated());
        } else if (button==moisturizerBtn.getId()){
            moisturizerBtn.setActivated(!moisturizerBtn.isActivated());
        } else if (button==sunBtn.getId()){
            sunBtn.setActivated(!sunBtn.isActivated());
        } else {
            otherBtn.setActivated(!otherBtn.isActivated());
        }


    }
    boolean datefound=false;
    public void saveEntry(View view){
        final String code = dayofmonth+month+year;
        Log.d("saveEntry", code);
        Data oldData = new Data();
//        for (int x=0; x<data.size();x++){
//            if (code.equals(data.get(x).getCode())){
//                datefound=true;
//                oldData=data.get(x);
//            }
//        }
//        final boolean finalDatefound = datefound;
//        final Data finalOldData = oldData;
        if(data.size()==0){
            Log.d("data is size 0", "zero");
            datefound=false;
        }else{
            Log.d("datasize", "datanotzero");
            datefound=true;

        }
        realm.executeTransactionAsync(new Realm.Transaction() {
            @Override
            public void execute(Realm realm) {
                RealmList<String> steps=new RealmList<String>();
                if (oilBtn.isActivated()){
                    steps.add("Oil");
                }
                if (waterBtn.isActivated()){
                    steps.add("Water");
                }
                if (exfoliatorBtn.isActivated()){
                    steps.add("Exfoliator");
                }
                if (tonerBtn.isActivated()){
                    steps.add("Toner");
                }
                if (essenceBtn.isActivated()){
                    steps.add("Essence");
                }
                if (treatmentBtn.isActivated()){
                    steps.add("Treatment");
                }
                if (eyeBtn.isActivated()){
                    steps.add("Eye");
                }
                if (maskBtn.isActivated()){
                    steps.add("Mask");
                }
                if (moisturizerBtn.isActivated()){
                    steps.add("Moisturizer");
                }
                if (sunBtn.isActivated()){
                    steps.add("Sun");
                }
                if (otherBtn.isActivated()){
                    steps.add("Other");
                }

                int toggetime;

                if (toggleButton.isChecked()){
                    toggetime=0;
                }else{
                    toggetime=1;
                }
                Log.d("addentry", "stepbtn");
                if (update){
                    Data oneday=realm.where(Data.class).contains("code", updatecode).findFirst();
                    Day updateentry=oneday.getData().get(updatePosition);
                    if (!editText.getText().toString().isEmpty()){
                        updateentry.setNotes(editText.getText().toString());
                    }
                    updateentry.setSteps(steps);
                    updateentry.setTimeOfDay(toggetime);
                    updateentry.setCondition(condition);

                }else {
                    Day newdayentry = realm.createObject(Day.class);
                    newdayentry.setCondition(condition);

                    Log.d("addentry", "toggletime");

                    if (!editText.getText().toString().isEmpty()){
                        newdayentry.setNotes(editText.getText().toString());
                    }
                    Log.d("addentry", "notes");
                    newdayentry.setTimeOfDay(toggetime);
                    newdayentry.setDaycode(code);
                    newdayentry.setSteps(steps);
                    if (!datefound){
                        Log.d("addentry", "insidedatefound");
//                    newdata.setCode(code);
                        Data newdata=realm.createObject(Data.class, code);
//                    Data newdata=realm.createObject(Data.class);
                        Log.d("addentry", "insidedatefoundnow");
                        RealmList<Day> newentrys=new RealmList<Day>();
                        Log.d("addentry", "insidedatefoundhi");
                        newentrys.add(newdayentry);
                        Log.d("addentry", "insidedatefoundno");

                        newdata.setData(newentrys);
                        Log.d("addentry", "insidedatefoundway");
                    }else{
                        Log.d("addentry", "insidedatefoundelse");
                        Data daytoadd=realm.where(Data.class).equalTo("code",code).findFirst();
                        daytoadd.getData().add(newdayentry);
                }


                Log.d("addentry", "beforefor");


                Log.d("addentry", "beforedatefound");
//                if (!finalDatefound){
//                    Log.d("addentry", "insidedatefound");
//                    Data newdata=realm.createObject(Data.class);
//                    RealmList<Day> newentrys=new RealmList<Day>();
//                    newentrys.add(newdayentry);
//                    newdata.setCode(code);
//                    newdata.setData(newentrys);
//                }else {
//                    Data daytoadd=realm.where(Data.class).equalTo("code",code).findFirst();
//                    daytoadd.getData().add(newdayentry);
//                }

                }

            }
        });


    }

    @Override
    protected void onPause() {
        super.onPause();

    }
}
