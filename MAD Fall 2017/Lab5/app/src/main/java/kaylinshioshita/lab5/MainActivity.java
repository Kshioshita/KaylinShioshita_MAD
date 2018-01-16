package kaylinshioshita.lab5;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @SuppressLint("SetTextI18n")
    public void findAnimal(View view){
        ToggleButton toggle=(ToggleButton) findViewById(R.id.toggleButton);
        boolean personality=toggle.isChecked();
        String spiritAnimal="None";

        Spinner colorList = (Spinner)findViewById(R.id.spinner);
        String color = String.valueOf(colorList.getSelectedItem());

        RadioGroup element=(RadioGroup)findViewById(R.id.radioGroup);
        int element_id=element.getCheckedRadioButtonId();

        Switch switchAnimals=(Switch)findViewById(R.id.switch1);
        boolean wildAnimal=switchAnimals.isChecked();

        ImageView animalPicture=(ImageView)findViewById(R.id.imageView);
        if(wildAnimal){
            if (personality){ //extrovert
                if(element_id==-1){
                    Context context =getApplicationContext();
                    CharSequence text1="Please select an Element";
                    int duration1=Toast.LENGTH_SHORT;
                    Toast toast1=Toast.makeText(context, text1, duration1);
                    toast1.show();
                    spiritAnimal="None";
                }else{
                    switch (color){
                        case "Red":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Lion";
                                animalPicture.setImageResource(R.drawable.lion);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Monkey";
                                animalPicture.setImageResource(R.drawable.monkey);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Dolphin";
                                animalPicture.setImageResource(R.drawable.dolphin);
                            } else {
                                spiritAnimal = "Toucan";
                                animalPicture.setImageResource(R.drawable.toucan);
                            }
                            break;

                        case "Blue":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Toucan";
                                animalPicture.setImageResource(R.drawable.toucan);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Lion";
                                animalPicture.setImageResource(R.drawable.lion);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Monkey";
                                animalPicture.setImageResource(R.drawable.monkey);
                            } else {
                                spiritAnimal = "Dolphin";
                                animalPicture.setImageResource(R.drawable.dolphin);
                            }
                            break;

                        case "Green":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Monkey";
                                animalPicture.setImageResource(R.drawable.monkey);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Dolphin";
                                animalPicture.setImageResource(R.drawable.dolphin);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Toucan";
                                animalPicture.setImageResource(R.drawable.toucan);
                            } else {
                                spiritAnimal = "Lion";
                                animalPicture.setImageResource(R.drawable.lion);
                            }
                            break;

                        case "Purple":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Dolphin";
                                animalPicture.setImageResource(R.drawable.dolphin);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Toucan";
                                animalPicture.setImageResource(R.drawable.toucan);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Lion";
                                animalPicture.setImageResource(R.drawable.lion);
                            } else {
                                spiritAnimal = "Monkey";
                                animalPicture.setImageResource(R.drawable.monkey);
                            }
                            break;

                        case "Pick a Color":
                            //toast
                            Context context=getApplicationContext();
                            CharSequence text="Please select a color";
                            int duration= Toast.LENGTH_SHORT;
                            Toast toast=Toast.makeText(context, text, duration);
                            toast.show();
                            spiritAnimal="None";
                            break;
                    }
                }

            }
            else { //introvert
                if(element_id==-1){
                    Context context =getApplicationContext();
                    CharSequence text1="Please select an Element";
                    int duration1=Toast.LENGTH_SHORT;
                    Toast toast1=Toast.makeText(context, text1, duration1);
                    toast1.show();
                    spiritAnimal="None";
                }else {
                    switch (color) {
                        case "Red":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Wolf";
                                animalPicture.setImageResource(R.drawable.wolf);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Manatee";
                                animalPicture.setImageResource(R.drawable.manatee);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Panda";
                                animalPicture.setImageResource(R.drawable.panda);
                            } else {
                                spiritAnimal = "Giraffe";
                                animalPicture.setImageResource(R.drawable.giraffe);
                            }
                            break;

                        case "Blue":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Giraffe";
                                animalPicture.setImageResource(R.drawable.giraffe);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Wolf";
                                animalPicture.setImageResource(R.drawable.wolf);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Manatee";
                                animalPicture.setImageResource(R.drawable.manatee);
                            } else {
                                spiritAnimal = "Panda";
                                animalPicture.setImageResource(R.drawable.panda);
                            }
                            break;

                        case "Green":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Panda";
                                animalPicture.setImageResource(R.drawable.panda);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Giraffe";
                                animalPicture.setImageResource(R.drawable.giraffe);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Wolf";
                                animalPicture.setImageResource(R.drawable.wolf);
                            } else {
                                spiritAnimal = "Manatee";
                                animalPicture.setImageResource(R.drawable.manatee);
                            }
                            break;

                        case "Purple":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Manatee";
                                animalPicture.setImageResource(R.drawable.manatee);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Panda";
                                animalPicture.setImageResource(R.drawable.panda);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Giraffe";
                                animalPicture.setImageResource(R.drawable.giraffe);
                            } else {
                                spiritAnimal = "Wolf";
                                animalPicture.setImageResource(R.drawable.wolf);
                            }
                            break;

                        case "Pick a Color":
                            //toast
                            Context context = getApplicationContext();
                            CharSequence text = "Please select a color";
                            int duration = Toast.LENGTH_SHORT;
                            Toast toast = Toast.makeText(context, text, duration);
                            toast.show();
                            spiritAnimal = "None";
                            break;
                    }
                }
            }
        } else{
            if (personality){ //extrovert
                if(element_id==-1){
                    Context context =getApplicationContext();
                    CharSequence text1="Please select an Element";
                    int duration1=Toast.LENGTH_SHORT;
                    Toast toast1=Toast.makeText(context, text1, duration1);
                    toast1.show();
                    spiritAnimal="None";
                }else{
                    switch (color){
                        case "Red":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Dog";
                                animalPicture.setImageResource(R.drawable.dog);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Hamster";
                                animalPicture.setImageResource(R.drawable.hamster);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Frog";
                                animalPicture.setImageResource(R.drawable.frog);
                            } else {
                                spiritAnimal = "Parakeet";
                                animalPicture.setImageResource(R.drawable.parakeet);
                            }
                            break;

                        case "Blue":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Hamster";
                                animalPicture.setImageResource(R.drawable.hamster);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Frog";
                                animalPicture.setImageResource(R.drawable.frog);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Parakeet";
                                animalPicture.setImageResource(R.drawable.parakeet);
                            } else {
                                spiritAnimal = "Dog";
                                animalPicture.setImageResource(R.drawable.dog);
                            }
                            break;

                        case "Green":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Frog";
                                animalPicture.setImageResource(R.drawable.frog);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Parakeet";
                                animalPicture.setImageResource(R.drawable.parakeet);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Dog";
                                animalPicture.setImageResource(R.drawable.dog);
                            } else {
                                spiritAnimal = "Hamster";
                                animalPicture.setImageResource(R.drawable.hamster);
                            }
                            break;

                        case "Purple":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Parakeet";
                                animalPicture.setImageResource(R.drawable.parakeet);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Dog";
                                animalPicture.setImageResource(R.drawable.dog);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Hamster";
                                animalPicture.setImageResource(R.drawable.hamster);
                            } else {
                                spiritAnimal = "Frog";
                                animalPicture.setImageResource(R.drawable.frog);
                            }
                            break;

                        case "Pick a Color":
                            //toast
                            Context context=getApplicationContext();
                            CharSequence text="Please select a color";
                            int duration= Toast.LENGTH_SHORT;
                            Toast toast=Toast.makeText(context, text, duration);
                            toast.show();
                            spiritAnimal="None";
                            break;
                    }
                }

            }
            else { //introvert
                if(element_id==-1){
                    Context context =getApplicationContext();
                    CharSequence text1="Please select an Element";
                    int duration1=Toast.LENGTH_SHORT;
                    Toast toast1=Toast.makeText(context, text1, duration1);
                    toast1.show();
                    spiritAnimal="None";
                }else {
                    switch (color) {
                        case "Red":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Cat";
                                animalPicture.setImageResource(R.drawable.cat);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Rabbit";
                                animalPicture.setImageResource(R.drawable.rabbit);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Goldfish";
                                animalPicture.setImageResource(R.drawable.goldfish);
                            } else {
                                spiritAnimal = "Hedgehog";
                                animalPicture.setImageResource(R.drawable.hedgehog);
                            }
                            break;

                        case "Blue":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Rabbit";
                                animalPicture.setImageResource(R.drawable.rabbit);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Goldfish";
                                animalPicture.setImageResource(R.drawable.goldfish);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Hedgehog";
                                animalPicture.setImageResource(R.drawable.hedgehog);
                            } else {
                                spiritAnimal = "Cat";
                                animalPicture.setImageResource(R.drawable.cat);
                            }
                            break;

                        case "Green":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Goldfish";
                                animalPicture.setImageResource(R.drawable.goldfish);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Hedgehog";
                                animalPicture.setImageResource(R.drawable.hedgehog);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Cat";
                                animalPicture.setImageResource(R.drawable.cat);
                            } else {
                                spiritAnimal = "Rabbit";
                                animalPicture.setImageResource(R.drawable.rabbit);
                            }
                            break;

                        case "Purple":
                            if (element_id==R.id.radioButton1){
                                spiritAnimal="Hedgehog";
                                animalPicture.setImageResource(R.drawable.hedgehog);
                            } else if(element_id==R.id.radioButton2){
                                spiritAnimal="Cat";
                                animalPicture.setImageResource(R.drawable.cat);
                            } else if(element_id==R.id.radioButton3){
                                spiritAnimal="Rabbit";
                                animalPicture.setImageResource(R.drawable.rabbit);
                            } else {
                                spiritAnimal = "Goldfish";
                                animalPicture.setImageResource(R.drawable.goldfish);
                            }
                            break;

                        case "Pick a Color":
                            //toast
                            Context context = getApplicationContext();
                            CharSequence text = "Please select a color";
                            int duration = Toast.LENGTH_SHORT;
                            Toast toast = Toast.makeText(context, text, duration);
                            toast.show();
                            spiritAnimal = "None";
                            break;
                    }
                }
            }

        }

        TextView animalSelection=(TextView)findViewById(R.id.animalTextView);
        if(!"None".equals(spiritAnimal)){
//            System.out.println(spiritAnimal);
//            Log.d(spiritAnimal, spiritAnimal);
            animalSelection.setText("Your spirit animal is a "+spiritAnimal);
        } else {
            animalSelection.setText("");
        }

    }
}
