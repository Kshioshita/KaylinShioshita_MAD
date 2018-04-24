package kaylinshioshita.skincaremanager;

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

    private static class ViewHolder{
        TextView condition;
        TextView entryTime;
        ImageView conditionImg;
    }

    EntryAdapter(DayDetailActivity activity, OrderedRealmCollection<Day> data){
        super(data);
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
            viewHolder.conditionImg.setImageResource(R.drawable.goods);
            viewHolder.condition.setText(day.getCondition());
            viewHolder.entryTime.setText(day.getTimeOfDay());
        }
        return convertView;
    }
}
