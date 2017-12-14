package kaylinshioshita.project2;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RectF;
import android.os.Build;
import android.support.annotation.RequiresApi;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;

/**
 * Created by kaylinshioshita on 11/29/17
 */

public class MyView extends View {

    private Paint paint;
    private Paint paint2;
    private Path path;
    private float seconds;
    private float angle=0;
    private float initangle=0;
    final RectF oval=new RectF();

    public MyView(Context context){
        super(context);
        init();
    }

    public MyView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public MyView(Context context, AttributeSet attrs, int seconds) {
        super(context, attrs, seconds);
        init();
    }

    private void init(){
        paint = new Paint();
        paint.setColor(Color.LTGRAY);
        paint.setStrokeWidth(12);
        paint.setStyle(Paint.Style.STROKE);

        paint2=new Paint();
        paint2.setColor(Color.WHITE);
        paint2.setStrokeWidth(12);
        paint2.setStyle(Paint.Style.STROKE);


    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onDraw(Canvas canvas) {
        // TODO Auto-generated method stub
        super.onDraw(canvas);
        Log.d("drawing", "onDraw: inside");

        paint.setStyle(Paint.Style.STROKE);
        int height=canvas.getHeight()/2;
        int width=canvas.getWidth()/2;
        oval.set(50,50,650,650);
        String angleString=Float.toString(angle);
        Log.d("angle", angleString);
        canvas.drawArc(oval, 0, initangle,false, paint2);
        canvas.drawArc(oval, 270, angle,false, paint);


        paint.setStyle(Paint.Style.FILL);
//        canvas.drawCircle(300, 300, 200, paint);
        //drawCircle(cx, cy, radius, paint)

    }

    public void setSeconds(float sec, float orignalsec){
        if(sec==0 && orignalsec==0){
            initangle=0;
        } else{
            initangle=360;
        }
        seconds=sec;
        angle=360-sec/orignalsec*360;
//        initangle=360;
//        angle=270;
        Log.d("angle", "here2");

    }

    public float getAngle(){
        angle=0;
//        Log.d("angle", String.format("%d", angle));
        return angle;
    }
}