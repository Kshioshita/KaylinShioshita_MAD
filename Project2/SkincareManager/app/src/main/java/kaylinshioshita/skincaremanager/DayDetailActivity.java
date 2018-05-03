package kaylinshioshita.skincaremanager;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import io.realm.Realm;
import io.realm.RealmList;
import io.realm.RealmResults;

public class DayDetailActivity extends AppCompatActivity {

    private Realm realm;
    String year;
    String month;
    String dayofmonth;
    String code;
    int offset;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_day_detail);
        realm=Realm.getDefaultInstance();
        Intent i =getIntent();
        year=i.getStringExtra("year");
        month=i.getStringExtra("month");
        dayofmonth=i.getStringExtra("day");
        offset=i.getIntExtra("offset", -1);
        Log.d("daydetailoffset", String.valueOf(offset));
        code=dayofmonth+month+year;
//        RealmResults<Data> allData=realm.where(Data.class).findAll();
        RealmResults<Data> alldata=realm.where(Data.class).findAll();
        RealmList<Day> dayentries = new RealmList<Day>();
        Data oneday=realm.where(Data.class).contains("code", code).findFirst();
        if (oneday!=null){
            dayentries = oneday.getData();
        }else{
            dayentries=null;
        }

        Log.d("DayDetail Data Size", String.valueOf(alldata.size()));
        Log.d("realmpath", realm.getConfiguration().getPath());
        Log.d("", "path: " + realm.getPath());
        realm.getConfiguration().getPath();



//        Log.d("daydetailactivity", year);


        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

//        final EntryAdapter adapter = new EntryAdapter(this, (OrderedRealmCollection<Day>) sampledays);
        final EntryAdapter adapter = new EntryAdapter(this, dayentries, code);
        AdapterView.OnItemClickListener itemClickListener= new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Log.d("daydetail", "entry clicked");
                Intent intent=new Intent(DayDetailActivity.this, AddEntryActivity.class);
                intent.putExtra("index", position);
                intent.putExtra("code", code);
                intent.putExtra("update", true);
                startActivity(intent);
            }
        };

        AdapterView.OnItemLongClickListener itemLongClickListener=new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, final int position, long id) {
                AlertDialog.Builder dialog = new AlertDialog.Builder(DayDetailActivity.this);
                dialog.setTitle("Delete Entry");
                dialog.setPositiveButton("Delete", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        deleteEntry(code, position);
                    }
                });
                dialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener(){
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                });
                dialog.create();
                dialog.show();
                return true;
            }
        };
        ListView listView=(ListView)findViewById(R.id.entrylistview);
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(itemClickListener);
        listView.setOnItemLongClickListener(itemLongClickListener);





        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(DayDetailActivity.this, AddEntryActivity.class);
                intent.putExtra("year", year);
                intent.putExtra("month", month);
                intent.putExtra("day", dayofmonth);
                startActivity(intent);

            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_day_detail, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private void deleteEntry(final String deletecode, final int position){
        realm.executeTransactionAsync(new Realm.Transaction() {
            @Override
            public void execute(Realm realm) {
                realm.where(Data.class).equalTo("code", deletecode).findFirst().getData().get(position).deleteFromRealm();
            }
        });

    }
}
