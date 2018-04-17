package kaylinshioshita.lab7;


import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


/**
 * A simple {@link Fragment} subclass.
 */
public class EraListFragment extends Fragment implements AdapterView.OnItemClickListener{

    private EraListListener listener;

    public EraListFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_era_list, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        View view = getView();
        if(view!=null){
            ListView listEra=(ListView)view.findViewById(R.id.listView);
            ArrayAdapter<Artist> listAdapter=new ArrayAdapter<Artist>(getActivity(), android.R.layout.simple_list_item_1, Artist.artistslist);
            listEra.setAdapter(listAdapter);
            listEra.setOnItemClickListener(this);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        listener=(EraListListener) context;

    }

    interface EraListListener{
        void itemClicked(long id);

    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        if (listener!=null){
            listener.itemClicked(id);
        }
    }

}
