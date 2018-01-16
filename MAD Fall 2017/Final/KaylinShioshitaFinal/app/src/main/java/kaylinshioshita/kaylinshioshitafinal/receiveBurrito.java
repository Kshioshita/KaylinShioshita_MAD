package kaylinshioshita.kaylinshioshitafinal;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

public class receiveBurrito extends AppCompatActivity {

    String burritoPlace;
    String burritoUrl;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_receive_burrito);

        Intent intent=getIntent();
        burritoPlace=intent.getStringExtra("place");
        burritoUrl=intent.getStringExtra("url");
        System.out.println(burritoPlace+" "+burritoUrl);

        TextView textSuggestion=(TextView)findViewById(R.id.textViewPlace);
        textSuggestion.setText("You should check out "+burritoPlace);

        final ImageButton imageButton = (ImageButton) findViewById(R.id.imageButton);
        View.OnClickListener onclick =new View.OnClickListener(){
            public void onClick(View view){
                loadSite(view);
            }
        };

        imageButton.setOnClickListener(onclick);

    }

    public void loadSite(View view){
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(burritoUrl));
        startActivity(intent);
    }
}
