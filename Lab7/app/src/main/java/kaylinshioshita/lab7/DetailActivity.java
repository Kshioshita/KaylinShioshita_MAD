package kaylinshioshita.lab7;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements ArtistDetailFragment.ButtonClickListener, ArtistDetailFragment.ArtistDetailListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        ArtistDetailFragment frag =(ArtistDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        int eraId = (int)getIntent().getExtras().get("id");
        frag.setEraId(eraId);
    }

    @Override
    public void addArtistClicked(View view) {
        ArtistDetailFragment fragment = (ArtistDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addArtist();
    }

    @Override
    public void itemClicked(long id) {

    }
}
