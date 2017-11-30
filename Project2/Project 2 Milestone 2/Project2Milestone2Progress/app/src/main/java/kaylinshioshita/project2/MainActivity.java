package kaylinshioshita.project2;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.TimePicker;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    TimePicker myTimePicker;
    TextView timeUpText;
    boolean isTimerRunning=false;
    boolean isTimerPaused=false;
    CountDownTimer myTimer;
    long seconds;
    float originalSecs;

    MyView drawingCanvas;

    ArrayList<Regimen> regimens;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        myTimePicker = (TimePicker)findViewById(R.id.myTimePicker);
        myTimePicker.setIs24HourView(true);
        drawingCanvas=(MyView)findViewById(R.id.myView);

//        Regimen defaultRegimen=new Regimen();
//        ArrayList<String> defaultSteps("Oil Cleanser");
//        defaultRegimen.setSteps();
    }

    @SuppressLint("NewApi")
    public void startTimer(View view){

        if (isTimerRunning==false){
            if(isTimerPaused==true){
                myTimer=new CountDownTimer(seconds, 1000){
                    public void onTick(long millisUntilFinished){
//                timeUpText.setText((int) millisUntilFinished);
//                timeUpText.setText((int) (millisUntilFinished/1000));
                        seconds=seconds-1000;
                        timeUpText.setText("seconds remaining: " + seconds / 1000);
                        Log.d("seconds", String.format("%d", seconds/1000));
                        drawingCanvas.setSeconds(seconds, originalSecs);
                        drawingCanvas.invalidate();
                    }
                    public void onFinish(){
                        timeUpText.setText("Time's Up!");
                    }

                }.start();
                isTimerRunning=true;
                isTimerPaused=false;
            } else{
                timeUpText=(TextView)findViewById(R.id.textView);
                long startTime=(long)myTimePicker.getHour()*60000+myTimePicker.getMinute()*1000;
//                Log.d("startTime", String.format("%d",startTime));
                seconds=startTime;
                originalSecs=startTime;
                myTimer=new CountDownTimer(seconds, 1000){
                    public void onTick(long millisUntilFinished){
//                timeUpText.setText((int) millisUntilFinished);
//                timeUpText.setText((int) (millisUntilFinished/1000));
                        seconds=seconds-1000;
                        timeUpText.setText("seconds remaining: " + millisUntilFinished / 1000);
                        drawingCanvas.setSeconds(seconds, originalSecs);
                        drawingCanvas.invalidate();
                    }
                    public void onFinish(){
                        timeUpText.setText("Time's Up!");
                    }

                }.start();
                isTimerRunning=true;
                isTimerPaused=false;
            }

        }

    }

    public void stopTimer(View view){
        myTimer.cancel();
        isTimerRunning=false;
        isTimerPaused=true;

    }

    public void resetTimer(View view){
        myTimer.cancel();
        drawingCanvas.setSeconds(0, 0);
        drawingCanvas.invalidate();
        isTimerRunning=false;
        isTimerPaused=false;
    }
}
