package kaylinshioshita.skincaremanager;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Intent;
import android.icu.util.Calendar;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.CalendarView;
import android.widget.ImageView;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import io.realm.Realm;

//Resources
// OnDateChangeListener
// https://stackoverflow.com/questions/12641250/android-calendarview-ondatechangelistener
public class MainActivity extends Activity {
    private Realm realm;
    ImageView imageView0;
    ImageView imageView1;
    ImageView imageView2;
    ImageView imageView3;
    ImageView imageView4;
    ImageView imageView5;
    ImageView imageView6;
    ImageView imageView7;
    ImageView imageView8;
    ImageView imageView9;
    ImageView imageView10;
    ImageView imageView11;
    ImageView imageView12;
    ImageView imageView13;
    ImageView imageView14;
    ImageView imageView15;
    ImageView imageView16;
    ImageView imageView17;
    ImageView imageView18;
    ImageView imageView19;
    ImageView imageView20;
    ImageView imageView21;
    ImageView imageView22;
    ImageView imageView23;
    ImageView imageView24;
    ImageView imageView25;
    ImageView imageView26;
    ImageView imageView27;
    ImageView imageView28;
    ImageView imageView29;
    ImageView imageView30;
    ImageView imageView31;
    ImageView imageView32;
    ImageView imageView33;
    ImageView imageView34;

    ImageView[] backgroundImgs;

    CalendarView calendarView;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        realm=Realm.getDefaultInstance();

        imageView0=(ImageView)findViewById(R.id.imageViewR1C1);
        imageView1=(ImageView)findViewById(R.id.imageViewR1C2);
        imageView2=(ImageView)findViewById(R.id.imageViewR1C3);
        imageView3=(ImageView)findViewById(R.id.imageViewR1C4);
        imageView4=(ImageView)findViewById(R.id.imageViewR1C5);
        imageView5=(ImageView)findViewById(R.id.imageViewR1C6);
        imageView6=(ImageView)findViewById(R.id.imageViewR1C7);
        imageView7=(ImageView)findViewById(R.id.imageViewR2C1);
        imageView8=(ImageView)findViewById(R.id.imageViewR2C2);
        imageView9=(ImageView)findViewById(R.id.imageViewR2C3);
        imageView10=(ImageView)findViewById(R.id.imageViewR2C4);
        imageView11=(ImageView)findViewById(R.id.imageViewR2C5);
        imageView12=(ImageView)findViewById(R.id.imageViewR2C6);
        imageView13=(ImageView)findViewById(R.id.imageViewR2C7);
        imageView14=(ImageView)findViewById(R.id.imageViewR3C1);
        imageView15=(ImageView)findViewById(R.id.imageViewR3C2);
        imageView16=(ImageView)findViewById(R.id.imageViewR3C3);
        imageView17=(ImageView)findViewById(R.id.imageViewR3C4);
        imageView18=(ImageView)findViewById(R.id.imageViewR3C5);
        imageView19=(ImageView)findViewById(R.id.imageViewR3C6);
        imageView20=(ImageView)findViewById(R.id.imageViewR3C7);
        imageView21=(ImageView)findViewById(R.id.imageViewR4C1);
        imageView22=(ImageView)findViewById(R.id.imageViewR4C2);
        imageView23=(ImageView)findViewById(R.id.imageViewR4C3);
        imageView24=(ImageView)findViewById(R.id.imageViewR4C4);
        imageView25=(ImageView)findViewById(R.id.imageViewR4C5);
        imageView26=(ImageView)findViewById(R.id.imageViewR4C6);
        imageView27=(ImageView)findViewById(R.id.imageViewR4C7);
        imageView28=(ImageView)findViewById(R.id.imageViewR5C1);
        imageView29=(ImageView)findViewById(R.id.imageViewR5C2);
        imageView30=(ImageView)findViewById(R.id.imageViewR5C3);
        imageView31=(ImageView)findViewById(R.id.imageViewR5C4);
        imageView32=(ImageView)findViewById(R.id.imageViewR5C5);
        imageView33=(ImageView)findViewById(R.id.imageViewR5C6);
        imageView34=(ImageView)findViewById(R.id.imageViewR5C7);



        backgroundImgs=new ImageView[] {imageView0, imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9, imageView10, imageView11, imageView12, imageView13, imageView14, imageView15, imageView16, imageView17, imageView18, imageView19, imageView20, imageView21, imageView22, imageView23, imageView24, imageView25, imageView26, imageView27, imageView28, imageView29, imageView30, imageView31, imageView32, imageView33, imageView34};
        Log.d("mainactivity", String.valueOf(backgroundImgs.length));

        AdapterView.OnClickListener itemCLickListener = new AdapterView.OnClickListener() {

            @Override
            public void onClick(View v) {
                Log.d("onclicklistener", "onItemClick: here");
            }

        };



        calendarView = (CalendarView)findViewById(R.id.calendarView);
//        calendarView.setDateTextAppearance(R.style.TextAppearance_AppCompat_Display1);

        calendarView.setOnClickListener(itemCLickListener);
        calendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener(){

            @TargetApi(Build.VERSION_CODES.N)
            @Override
            public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
                Log.d("onclicklistener", "onItemClick: in here");
                Log.d("onselecteddaychange", String.valueOf(year));
                Intent intent = new Intent(MainActivity.this, DayDetailActivity.class);
                intent.putExtra("year", String.valueOf(year));
                intent.putExtra("month", String.valueOf(month));
                intent.putExtra("day", String.valueOf(dayOfMonth));
                String stringDate;
                if (month<10){
                    stringDate="01-0"+month+"-"+year;
                }else {
                    stringDate="01-"+month+"-"+year;
                }

                Log.d("mainstringdate", stringDate);
                SimpleDateFormat f = new SimpleDateFormat("dd/MM/yyyy");
                long milliseconds=0;
                Date d=new Date();
                try{
                    d=f.parse(stringDate);
                    milliseconds = d.getTime();

                }catch(ParseException e){
                    e.printStackTrace();
                }

                Calendar calendar = Calendar.getInstance();
                Log.d("maindate", String.valueOf(d));
                calendar.setTime(d);
                Log.d("maindayofweek", String.valueOf(calendar.get(calendar.DAY_OF_WEEK)));
                startActivity(intent);
            }
        });

    }

    @Override
    protected void onResume() {
        super.onResume();
        calendarView.setDate(System.currentTimeMillis());
    }
}
