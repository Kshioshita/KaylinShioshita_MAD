package kaylinshioshita.lab6;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

public class RecieveDrama extends AppCompatActivity {

    private String dramaTitle;
    private String dramaUrl;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recieve_drama);
        Intent intent =getIntent();
        dramaTitle=intent.getStringExtra("dramaName");
        dramaUrl=intent.getStringExtra("dramaurl");
        Log.i("title", dramaTitle);
        Log.i("url", dramaUrl);

        TextView msgTextView=(TextView)findViewById(R.id.dramaRecTextView);
        msgTextView.setText("You should watch "+dramaTitle);

        final ImageButton imgButton=(ImageButton)findViewById(R.id.imageButton);
        View.OnClickListener onclick=new View.OnClickListener() {
            public void onClick(View v) {
                loadUrl(v);
            }
        };

        imgButton.setOnClickListener(onclick);
    }

    public void loadUrl(View view){
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(dramaUrl));
        startActivity(intent);
    }
}
