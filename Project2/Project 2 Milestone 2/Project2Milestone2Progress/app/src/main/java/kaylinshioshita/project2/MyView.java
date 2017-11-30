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
    private Path path;
    private float seconds;
    private float angle=0;

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
        paint.setColor(Color.BLUE);
        paint.setStrokeWidth(4);
        paint.setStyle(Paint.Style.STROKE);

    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onDraw(Canvas canvas) {
        // TODO Auto-generated method stub
        super.onDraw(canvas);
        Log.d("drawing", "onDraw: inside");
        final RectF oval = new RectF();
        paint.setStyle(Paint.Style.STROKE);
        oval.set(50,50,150,150);
        String angleString=Float.toString(angle);
        Log.d("angle", angleString);
        canvas.drawArc(oval, 0, angle,false, paint);

        paint.setStyle(Paint.Style.FILL);
//        canvas.drawCircle(300, 300, 200, paint);
        //drawCircle(cx, cy, radius, paint)

    }

    public void setSeconds(float sec, float orignalsec){
        seconds=sec;
        angle=sec/orignalsec*360;
//        angle=270;
        Log.d("angle", "here2");

    }

    public float getAngle(){
        angle=0;
//        Log.d("angle", String.format("%d", angle));
        return angle;
    }
}