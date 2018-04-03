package kaylinshioshita.lab6;

import android.app.ListActivity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;


// Paw icon by Jono Freeman from the Noun Project

public class MainActivity extends ListActivity {

    private String doggroup;
    String[] items = {"Toy Group", "Working Group", "Terrier Group", "Non-Sporting Group"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);


        ListView listGroups=getListView();
        ArrayAdapter<String> grouparray = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, items);
        listGroups.setAdapter(grouparray);
    }

    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item){
        switch (item.getItemId()){
            case R.id.create_order:
                Intent intent = new Intent(Intent.ACTION_VIEW);
                intent.setData(Uri.parse("https://www.petfinder.com/"));
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);

        }
    }
    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
        Log.d("group", items[position]);
        String dogGroup = items[position];
        Intent intent = new Intent(MainActivity.this, DogGroupActivity.class);
        intent.putExtra("groupname", dogGroup);
        startActivity(intent);
    }
}
