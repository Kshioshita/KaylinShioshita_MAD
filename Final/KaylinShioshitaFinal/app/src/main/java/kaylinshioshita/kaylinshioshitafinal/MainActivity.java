package kaylinshioshita.kaylinshioshitafinal;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    String nameValue;
    String meat;
    String burritoType;
    String location;
    private BurritoPlace myBurrito=new BurritoPlace();
    RadioGroup radioGroup;
    Spinner locationSpinner;
    TextView result;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        result=(TextView)findViewById(R.id.textViewResult);
        locationSpinner=(Spinner)findViewById(R.id.spinner);
    }



    public void buildBurrito(View view){
        radioGroup=(RadioGroup)findViewById(R.id.radioGroup);
        location=String.valueOf(locationSpinner.getSelectedItem());
        EditText name=(EditText)findViewById(R.id.editText);
        nameValue=name.getText().toString();
        ToggleButton toggle=(ToggleButton)findViewById(R.id.toggleButton);
        if(toggle.isChecked()){
            meat="meat";
        } else{
            meat="veggies";
        }

        RadioGroup radiogrp=(RadioGroup)findViewById(R.id.radioGroup);
        ImageView imageType=(ImageView)findViewById(R.id.imageView);
        int type=radiogrp.getCheckedRadioButtonId();
        if(type==R.id.radioButton1){
            burritoType="burrito";
            imageType.setImageResource(R.drawable.burrito);
        }else{
            burritoType="taco";
            imageType.setImageResource(R.drawable.taco);
        }

        CheckBox salsaBox=(CheckBox)findViewById(R.id.checkBox);
        Boolean salsa=salsaBox.isChecked();
        CheckBox cheeseBox=(CheckBox)findViewById(R.id.checkBox2);
        Boolean cheese=cheeseBox.isChecked();
        CheckBox sourBox=(CheckBox)findViewById(R.id.checkBox3);
        Boolean sour=sourBox.isChecked();
        CheckBox guacBox=(CheckBox)findViewById(R.id.checkBox4);
        Boolean guac=guacBox.isChecked();
        if(salsa){
            meat+=", salsa";
        }
        if(cheese){
            meat+=", cheese";
        }
        if(sour){
            meat+=", sour cream";
        }
        if(guac){
            meat+=", guacamole";
        }
        Switch glutenSwitch=(Switch)findViewById(R.id.switch1);
        if(glutenSwitch.isChecked()){
            meat+=" on a corn tortilla";
        }
        result.setText("The "+nameValue+" is a "+burritoType+" with "+meat+". You'd like to eat on "+location);
    }

    public void findBurrito(View view){
        location=String.valueOf(locationSpinner.getSelectedItem());
        myBurrito.setBurritoPlace(location);
        Intent intent=new Intent(this, receiveBurrito.class);
        intent.putExtra("place", myBurrito.getBurritoPlace());
        intent.putExtra("url",myBurrito.getBurritoUrl());
        startActivity(intent);
    }
}
