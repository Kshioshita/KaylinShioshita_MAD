package kaylinshioshita.skincaremanager;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.CalendarView;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        AdapterView.OnClickListener itemCLickListener = new AdapterView.OnClickListener() {

            @Override
            public void onClick(View v) {
                Log.d("onclicklistener", "onItemClick: here");
            }

        };



        CalendarView calendarView = (CalendarView)findViewById(R.id.calendarView);
        calendarView.setOnClickListener(itemCLickListener);
        calendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener(){

            @Override
            public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
                Log.d("onclicklistener", "onItemClick: in here");
                Intent intent = new Intent(MainActivity.this, DayDetailActivity.class);
                intent.putExtra("year", year);
                intent.putExtra("month", month);
                intent.putExtra("day", dayOfMonth);
                startActivity(intent);
            }
        });

    }

}
