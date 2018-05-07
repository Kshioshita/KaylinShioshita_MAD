package kaylinshioshita.lab7;

import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity implements EraListFragment.EraListListener, ArtistDetailFragment.ButtonClickListener, ArtistDetailFragment.ArtistDetailListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        if
    }

    @Override
    public void itemClicked(long id) {
        View fragmentContainer = findViewById(R.id.fragment_container);
        if (fragmentContainer!=null){
            ArtistDetailFragment frag = new ArtistDetailFragment();
            frag.setEraId(id);
            FragmentTransaction ft = getFragmentManager().beginTransaction();
            ft.replace(R.id.fragment_container, frag);
            ft.addToBackStack(null);
            ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
            ft.commit();
        } else {
            Intent intent = new Intent(this,DetailActivity.class);
            intent.putExtra("id", (int)id);
            startActivity(intent);
        }

    }

    @Override
    public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount()>0){
            getFragmentManager().popBackStack();
        }else {
            super.onBackPressed();
        }
    }

    @Override
    public void addArtistClicked(View view) {
        ArtistDetailFragment fragment =(ArtistDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addArtist();
    }
}
