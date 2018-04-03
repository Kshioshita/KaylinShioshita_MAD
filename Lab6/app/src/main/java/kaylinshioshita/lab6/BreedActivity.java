package kaylinshioshita.lab6;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class BreedActivity extends Activity {

    private String breedname;
    private String groupname;
    private int breedindex;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_breed);
        Intent i = getIntent();
        breedname = i.getStringExtra("breedName");
        groupname = i.getStringExtra("groupName");
        breedindex = (Integer)i.getExtras().get("breedindex");

        TextView textView = (TextView)findViewById(R.id.textView);
        textView.setText(breedname);
        ImageView imageView = (ImageView)findViewById(R.id.imageView2);
        switch (groupname){
            case "Toy Group":
                imageView.setImageResource(Dog.toys[breedindex].getImageResourceId());
                break;
            case "Working Group":
                imageView.setImageResource(Dog.working[breedindex].getImageResourceId());
                break;
            case "Terrier Group":
                imageView.setImageResource(Dog.terrier[breedindex].getImageResourceId());
                break;
            case "Non-Sporting Group":
                imageView.setImageResource(Dog.nonsporting[breedindex].getImageResourceId());
                break;
            default:



        }
        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);

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
