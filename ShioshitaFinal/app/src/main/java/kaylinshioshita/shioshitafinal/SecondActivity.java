package kaylinshioshita.shioshitafinal;

import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
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
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;

import java.util.ArrayList;

public class SecondActivity extends AppCompatActivity {

    ListView workoutListView;
    ArrayList<String> workouts=new ArrayList<String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        Log.d("secondactivity", "nice");
        workoutListView=(ListView)findViewById(R.id.listView2);
        Log.d("secondactivity", "no");
        final ArrayAdapter<Workout> listAdapter;
        Log.d("secondactivity", "im");

        Intent i=getIntent();
        final int typeId=i.getIntExtra("id", -1);
        switch (typeId){
            case 0:
                listAdapter=new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.cardios);
                break;
            case 1:
                listAdapter=new ArrayAdapter<Workout>(this,android.R.layout.simple_list_item_1, Workout.strengths);
                break;
            case 2:
                listAdapter=new ArrayAdapter<Workout>(this,android.R.layout.simple_list_item_1, Workout.flexibility);
                break;
            default:
                listAdapter=null;
        }

        workoutListView.setAdapter(listAdapter);

        Log.d("secondactivity", "here");


        Log.d("secondactivity", "now");
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        Log.d("secondactivity", "ok");
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                LinearLayout layout=new LinearLayout(SecondActivity.this);
                layout.setOrientation(LinearLayout.VERTICAL);
                final EditText workoutname=new EditText(SecondActivity.this);
                workoutname.setHint("Workout Name");
                final EditText workouturl=new EditText(SecondActivity.this);
                workouturl.setHint("URL");
                layout.addView(workoutname);
                layout.addView(workouturl);
                AlertDialog.Builder dialog=new AlertDialog.Builder(SecondActivity.this);
                dialog.setTitle("Add Book");
                dialog.setView(layout);
                dialog.setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        final String newWorkoutName=workoutname.getText().toString();
                        final String newWorkoutUrl=workoutname.getText().toString();
                        final int newWorkoutId=typeId;
                        if (!newWorkoutName.isEmpty()){
                            Workout newWorkout=new Workout(newWorkoutName, newWorkoutUrl, newWorkoutId);
                            switch (typeId){
                                case 0:
                                    Workout.cardios.add(newWorkout);
                                    break;
                                case 1:
                                    Workout.strengths.add(newWorkout);
                                    break;
                                case 2:
                                    Workout.flexibility.add(newWorkout);
                                    break;

                            }
                            listAdapter.notifyDataSetChanged();

                        }
                    }
                });
                dialog.setNegativeButton("Cancel", null);
                dialog.show();
            }
        });

        AdapterView.OnItemClickListener clickListener=new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent = new Intent(Intent.ACTION_VIEW);
                switch (typeId){
                    case 0:
                        intent.setData(Uri.parse(Workout.cardios.get(position).getUrl()));

                        break;
                    case 1:

                        intent.setData(Uri.parse(Workout.strengths.get(position).getUrl()));

                        break;
                    case 2:

                        intent.setData(Uri.parse(Workout.flexibility.get(position).getUrl()));

                        break;

                }
                startActivity(intent);
            }
        };

        workoutListView.setOnItemClickListener(clickListener);

        AdapterView.OnItemLongClickListener listener=new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, final int position, long id) {
                LinearLayout layout=new LinearLayout(SecondActivity.this);
                layout.setOrientation(LinearLayout.VERTICAL);
                final EditText workoutname=new EditText(SecondActivity.this);
                workoutname.setHint("Workout Name");
                final EditText workouturl=new EditText(SecondActivity.this);
                workouturl.setHint("URL");
                layout.addView(workoutname);
                layout.addView(workouturl);

                AlertDialog.Builder dialog = new AlertDialog.Builder(SecondActivity.this);
                dialog.setTitle("Edit Workout");
                dialog.setView(layout);
                dialog.setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Log.d("changeWorkout", String.valueOf(typeId));

                        switch (typeId){
                            case 0:
                                if (!workoutname.getText().toString().isEmpty()){
                                    Log.d("changeWorkout", String.valueOf(position));
                                    Workout changeWorkout = Workout.cardios.get(position);
                                    Log.d("changeWorkout", changeWorkout.getName());
                                    changeWorkout.setUrl(workouturl.getText().toString());
                                    changeWorkout.setName(workoutname.getText().toString());
                                }
                                listAdapter.notifyDataSetChanged();
                                break;
                            case 1:
                                if (!workoutname.getText().toString().isEmpty()){
                                    Log.d("changeWorkout", String.valueOf(position));
                                    Workout changeWorkout = Workout.strengths.get(position);
                                    Log.d("changeWorkout", changeWorkout.getName());
                                    changeWorkout.setUrl(workouturl.getText().toString());
                                    changeWorkout.setName(workoutname.getText().toString());
                                }
                                listAdapter.notifyDataSetChanged();
                                break;
                            case 2:
                                if (!workoutname.getText().toString().isEmpty()){
                                    Log.d("changeWorkout", String.valueOf(position));
                                    Workout changeWorkout = Workout.flexibility.get(position);
                                    Log.d("changeWorkout", changeWorkout.getName());
                                    changeWorkout.setUrl(workouturl.getText().toString());
                                    changeWorkout.setName(workoutname.getText().toString());
                                }
                                listAdapter.notifyDataSetChanged();
                                break;
                        }
                    }
                });
                dialog.setNegativeButton("Delete", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        switch (typeId){
                            case 0:
                                Workout.cardios.remove(position);
                                break;
                            case 1:
                                Workout.cardios.remove(position);
                                break;
                            case 2:
                                Workout.cardios.remove(position);
                                break;
                        }
                        listAdapter.notifyDataSetChanged();
                    }
                });
                dialog.create();
                dialog.show();
                return false;

            }
        };
        workoutListView.setOnItemLongClickListener(listener);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_second, menu);
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
}
