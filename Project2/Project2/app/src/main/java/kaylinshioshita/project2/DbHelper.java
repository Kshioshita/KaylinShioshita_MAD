package kaylinshioshita.project2;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteDatabase;
/**
 * Created by kaylinshioshita on 12/9/17.
 */

public class DbHelper extends SQLiteOpenHelper{

    public static final int DATABASE_VERSION=1;
    public static final String DATABASE_NAME="RegimenDB.db";
    public DbHelper(Context context){
        super(context, DATABASE_NAME,null,DATABASE_VERSION);

    }

    @Override
    public void onCreate(SQLiteDatabase db){
        String CREATE_TABLE="CREATE TABLE Regimen ( " +
                "Steps ARRAYLIST, " +
                "title TEXT, "+
                "activeRegimen BOOL,)";
        db.execSQL(CREATE_TABLE);

    }
    public void onUpgrade(SQLiteDatabase database, int oldversion, int newversion){
        database.execSQL("DROP TABLE IF EXISTS Regimens");
        this.onCreate(database);
    }

    public void onDowngrade(SQLiteDatabase database, int oldversion, int newversion){
        onUpgrade(database, oldversion, newversion);
    }

    private static final String TABLE_REGIMENS="regimens";
    private static final String KEY_TITLE ="title";
    private static final String KEY_STEPS="steps";
    private static final String KEY_ACTIVE="activeRegimen";
//    private static final String KEY_STEP="Step";

    private static final String[] COLUMNS={KEY_TITLE, KEY_STEPS, KEY_ACTIVE};

    public void addRegimen(Regimen regimen){
        SQLiteDatabase db=this.getWritableDatabase();
        ContentValues values=new ContentValues();
        values.put(KEY_TITLE, regimen.getTitle());
//        values.put(KEY_STEPS, regimen.getSteps());
        values.put(KEY_ACTIVE, regimen.getActiveRegimen());
        db.insert(TABLE_REGIMENS,null,values);
        db.close();

    }
}
