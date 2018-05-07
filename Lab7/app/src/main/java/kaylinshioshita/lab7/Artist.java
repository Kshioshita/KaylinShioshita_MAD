package kaylinshioshita.lab7;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by kaylinshioshita on 4/16/18.
 */

public class Artist {
    private String era;
    private ArrayList<String> artists = new ArrayList<>();


    private Artist(String era, ArrayList<String> newartists){
        this.artists=new ArrayList<String>(newartists);
        this.era=era;
    }

    public static ArrayList<Artist> artistsArray = new ArrayList<Artist>();

    public static final Artist[] artistslist = {
            new Artist("Impressionism", new ArrayList<String>(Arrays.asList("Claude Monet", "Edgar Degas", "Pierre-Auguste Renoir", "Édouard Manet"))),
            new Artist("Expressionism", new ArrayList<String>(Arrays.asList("Vincent Van Gogh", "Ernst Ludwig Kirchner", "Edvard Munch"))),
            new Artist("Surrealism", new ArrayList<String>(Arrays.asList("Pablo Picasso", "Salvador Dalí", "Max Ernst", "Frida Kahlo")))
    };

    public void storeArtists(Context context, int era){
        SharedPreferences sharedPreferences=context.getSharedPreferences("Artists",Context.MODE_PRIVATE);
        SharedPreferences.Editor editor=sharedPreferences.edit();
        Set<String> set=new HashSet<String>();
        set.addAll(artistslist[era].artists);

        editor.putStringSet(artistslist[era].getEra(), set);
        editor.commit();

    }

    public String getEra(){
        return era;
    }

    public ArrayList<String> getArtists(){
        return artists;
    }

    public String toString(){
        return this.era;
    }


}
