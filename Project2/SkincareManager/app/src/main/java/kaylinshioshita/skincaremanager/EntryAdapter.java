package kaylinshioshita.skincaremanager;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;

import io.realm.OrderedRealmCollection;
import io.realm.RealmBaseAdapter;

/**
 * Created by kaylinshioshita on 4/23/18.
 */

public class EntryAdapter extends RealmBaseAdapter<Day> implements ListAdapter {
    private DayDetailActivity activity;
    String code;
    private static class ViewHolder{
        TextView condition;
        TextView entryTime;
        ImageView conditionImg;
    }

    EntryAdapter(DayDetailActivity activity, OrderedRealmCollection<Day> data, String newcode){
        super(data);
        code=newcode;
        this.activity=activity;
    }


    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null){
            convertView= LayoutInflater.from(parent.getContext()).inflate(R.layout.entry_row_layout,parent,false);
            viewHolder=new ViewHolder();
            viewHolder.condition=(TextView)convertView.findViewById(R.id.conditiontextview);
            viewHolder.conditionImg=(ImageView) convertView.findViewById(R.id.conditionImg);
            viewHolder.entryTime=(TextView)convertView.findViewById(R.id.timetextview);
            convertView.setTag(viewHolder);
        }else {
            viewHolder = (ViewHolder) convertView.getTag();
        }
        if (adapterData != null) {
            Day day = adapterData.get(position);
            Log.d("entryadapter", String.valueOf(day.getCondition()));
            Log.d("entryadaptercode", code);
            Log.d("entryadapter day code", day.getDaycode());
            if (code.equals(day.getDaycode())){
                switch (day.getCondition()){
                    case 0:
                        viewHolder.condition.setText("Terrible");
                        viewHolder.conditionImg.setImageResource(R.drawable.terriblet);
                        if (day.getTimeOfDay()==0){
                            viewHolder.entryTime.setText("Morning");
                        } else{
                            viewHolder.entryTime.setText("Evening");
                        }
                        break;
                    case 1:
                        viewHolder.condition.setText("Bad");
                        viewHolder.conditionImg.setImageResource(R.drawable.badt);
                        if (day.getTimeOfDay()==0){
                            viewHolder.entryTime.setText("Morning");
                        } else{
                            viewHolder.entryTime.setText("Evening");
                        }
                        break;
                    case 2:
                        viewHolder.condition.setText("Fine");
                        viewHolder.conditionImg.setImageResource(R.drawable.finet);
                        if (day.getTimeOfDay()==0){
                            viewHolder.entryTime.setText("Morning");
                        } else{
                            viewHolder.entryTime.setText("Evening");
                        }
                        break;
                    case 3:
                        viewHolder.condition.setText("Good");
                        viewHolder.conditionImg.setImageResource(R.drawable.goodt);
                        if (day.getTimeOfDay()==0){
                            viewHolder.entryTime.setText("Morning");
                        } else{
                            viewHolder.entryTime.setText("Evening");
                        }
                        break;
                    case 4:
                        viewHolder.condition.setText("Great");
                        viewHolder.conditionImg.setImageResource(R.drawable.greatt);
                        if (day.getTimeOfDay()==0){
                            viewHolder.entryTime.setText("Morning");
                        } else{
                            viewHolder.entryTime.setText("Evening");
                        }
                        break;
                    default:
                        viewHolder.condition.setText("Default");
                }
            }

//            viewHolder.condition.setText(day.getCondition());
//            viewHolder.entryTime.setText(day.getTimeOfDay());
            Log.d("entryadapter", "getView: end");
        }
        return convertView;
    }
}
