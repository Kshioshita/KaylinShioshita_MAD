package kaylinshioshita.lab6;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    private DramaInfo recommendedDrama=new DramaInfo();

    public void findDrama(View view){
        Spinner genrespinner=(Spinner)findViewById(R.id.spinner);
        int gen=genrespinner.getSelectedItemPosition();
        Log.d("spinner", String.format("%d", gen));

        RadioGroup fandomgroup=(RadioGroup)findViewById(R.id.radioGroup);
        int fan=fandomgroup.getCheckedRadioButtonId();
        if (fan==R.id.radioButton1){
            fan=0;
        } else if(fan==R.id.radioButton2){
            fan=1;
        } else if(fan==R.id.radioButto3){
            fan=2;
        } else if(fan==R.id.radioButton4){
            fan=3;
        } else {
            Context context = getApplicationContext();
            CharSequence text = "Please select a Fandom";
            int duration = Toast.LENGTH_SHORT;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        }
        Log.d("radiobutton", String.format("%d", fan));

        if(gen==0){
            Context context = getApplicationContext();
            CharSequence text = "Please select a genre";
            int duration = Toast.LENGTH_SHORT;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        }

        if(gen!=0 && fan!=-1){
            recommendedDrama.setDrama(gen, fan);
            System.out.println(recommendedDrama.getTitle());
            String recommendedTitle=recommendedDrama.getTitle();
            String recommendedUrl=recommendedDrama.getUrl();
            Intent intent = new Intent(this, RecieveDrama.class);

            intent.putExtra("dramaName", recommendedTitle);
            intent.putExtra("dramaurl", recommendedUrl);

            startActivity(intent);
        }


    }


}
