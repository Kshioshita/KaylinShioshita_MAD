package kaylinshioshita.lab7;


import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Fragment;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.RequiresApi;
import android.util.Log;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class ArtistDetailFragment extends Fragment implements  View.OnClickListener, AdapterView.OnItemClickListener {

    private ArrayAdapter<String> adapter;
    private long eraId;
    public void setEraId(long id){
        this.eraId=id;
    }


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onStart() {
        super.onStart();
        View view = getView();
        ListView artistlist = (ListView)view.findViewById(R.id.artistlistview);
        ArrayList<String>artistNamelist=new ArrayList<String>();
        artistNamelist=Artist.artistslist[(int)eraId].getArtists();

        adapter=new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1,artistNamelist);
        Log.d("detail", "detail");
        artistlist.setAdapter(adapter);
        Log.d("detail2", "detail2");

        Button addArtist=(Button)view.findViewById(R.id.addArtistButton);
        addArtist.setOnClickListener(this);
        registerForContextMenu(artistlist);
        artistlist.setOnItemClickListener(this);

        ArtistDetailFragment fragment = (ArtistDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        listlistener=(ArtistDetailListener)fragment.getContext();



    }

    public ArtistDetailFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        if (savedInstanceState!=null){
            eraId=savedInstanceState.getLong("eraId");
        }
        return inflater.inflate(R.layout.fragment_artist_detail, container, false);
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        outState.putLong("eraId", eraId);
    }

    interface ButtonClickListener{

        void addArtistClicked(View view);
    }

    private ButtonClickListener listener;

    @SuppressLint("NewApi")
    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        listener=(ButtonClickListener)context;

//        listlistener=(ArtistDetailListener)context;


    }

    @Override
    public void onClick(View v) {
        if (listener!=null){
            listener.addArtistClicked(v);
        }
    }

    public void addArtist(){
        AlertDialog.Builder dialog=new AlertDialog.Builder(getActivity());
        final EditText edittext = new EditText(getActivity());
        dialog.setView(edittext);
        dialog.setTitle("Add Artist");
        dialog.setPositiveButton("Add", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                String artistName = edittext.getText().toString();
                if (!artistName.isEmpty()){
                    Artist.artistslist[(int)eraId].getArtists().add(artistName);
                    ArtistDetailFragment.this.adapter.notifyDataSetChanged();
                }
            }
        });
        dialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {

            }
        });
        dialog.show();
    }


    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo=(AdapterView.AdapterContextMenuInfo)menuInfo;
        String artistName = adapter.getItem(adapterContextMenuInfo.position);
        menu.setHeaderTitle("Delete " + artistName);
        menu.add(1,1, 1, "Yes");
        menu.add(2,2,2,"No");

    }


    @Override
    public boolean onContextItemSelected(MenuItem item) {
        int itemIndex = item.getItemId();
        if (itemIndex==1){
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo)item.getMenuInfo();
            Artist.artistslist[(int)eraId].getArtists().remove(info.position);
            ArtistDetailFragment.this.adapter.notifyDataSetChanged();
        }
        return true;
    }


    private ArtistDetailListener listlistener;

    interface ArtistDetailListener{
        void itemClicked(long id);
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Log.d("onItemClick", String.valueOf(position));
        if (listlistener != null){
            Log.d("onItemClick", String.valueOf(position));
            ArrayList<String> artistlist=new ArrayList<String>();
            artistlist=Artist.artistslist[(int)eraId].getArtists();
            String artistimg = artistlist.get(position);
            Log.d("artistimg", artistimg);
            View vi = getView();
            ImageView eraimg = (ImageView)vi.findViewById(R.id.imageView);
            switch (artistimg){
                case "Claude Monet":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.monet);
                    break;
                case "Vincent Van Gogh":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.gogh);
                    break;
                case "Max Ernst":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.ernst);
                    break;
                case "Pierre-Auguste Renoir":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.renoir);
                    break;
                case "Édouard Manet":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.manet);
                    break;
                case "Ernst Ludwig Kirchner":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.kirchner);
                    break;
                case "Edvard Munch":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.munch);
                    break;
                case "Pablo Picasso":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.picasso);
                    break;
                case "Salvador Dalí":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.dali);
                    break;
                case "Frida Kahlo":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.kahlo);
                    break;
                case "Edgar Degas":
                    eraimg.setVisibility(View.VISIBLE);
                    eraimg.setImageResource(R.drawable.degas);
                    break;
                default:
                    eraimg.setVisibility(View.INVISIBLE);
            }
        }
    }
}
