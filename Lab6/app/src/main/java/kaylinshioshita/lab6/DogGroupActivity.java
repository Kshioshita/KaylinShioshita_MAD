package kaylinshioshita.lab6;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;

public class DogGroupActivity extends Activity {

    private String groupname;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dog_group);
        Intent i = getIntent();
        groupname = i.getStringExtra("groupname");
        ListView listGroups = (ListView)findViewById(R.id.listView);
        ArrayAdapter<Dog> listAdapter;
        ImageView doggroupimage = (ImageView)findViewById(R.id.imageView);
        switch (groupname){
            case "Toy Group":
                listAdapter = new ArrayAdapter<Dog>(this, android.R.layout.simple_list_item_1, Dog.toys);
                doggroupimage.setImageResource(R.drawable.toy);
                break;
            case "Working Group":
                listAdapter = new ArrayAdapter<Dog>(this, android.R.layout.simple_list_item_1, Dog.working);
                doggroupimage.setImageResource(R.drawable.working);
                break;
            case "Terrier Group":
                listAdapter = new ArrayAdapter<Dog>(this, android.R.layout.simple_list_item_1, Dog.terrier);
                doggroupimage.setImageResource(R.drawable.terrier);
                break;
            case "Non-Sporting Group":
                listAdapter = new ArrayAdapter<Dog>(this, android.R.layout.simple_list_item_1, Dog.nonsporting);
                doggroupimage.setImageResource(R.drawable.nonsporting);
                break;
            default:
                listAdapter = new ArrayAdapter<Dog>(this, android.R.layout.simple_list_item_1, Dog.toys);
                doggroupimage.setImageResource(R.drawable.toy);


        }
        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> listView, View view, int position, long id) {
                Log.d("position", String.valueOf(listView.getItemAtPosition(position)));
                String dogbreed = String.valueOf(listView.getItemAtPosition(position));
                Log.d("dogbreed", dogbreed);
                Intent intent = new Intent(DogGroupActivity.this, BreedActivity.class);
                intent.putExtra("breedName", dogbreed);
                intent.putExtra("groupName", groupname);
                intent.putExtra("breedindex", (int)id);
                startActivity(intent);
            }
        };
        listGroups.setAdapter(listAdapter);
        listGroups.setOnItemClickListener(itemClickListener);


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

}
