package kaylinshioshita.shioshitafinal;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ListView listView=(ListView)findViewById(R.id.listView);
        String[] exercises = {"Cardio", "Strength", "Flexibility"};
        ArrayAdapter<String> listAdapter=new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, exercises);


        AdapterView.OnItemClickListener itemClickListener=new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent=new Intent(MainActivity.this, SecondActivity.class);
                intent.putExtra("id", position);
                startActivity(intent);
            }
        };

        listView.setAdapter(listAdapter);
        listView.setOnItemClickListener(itemClickListener);

    }
}
