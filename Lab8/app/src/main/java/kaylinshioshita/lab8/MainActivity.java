package kaylinshioshita.lab8;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class MainActivity extends AppCompatActivity {

    private EditText placeEditText;
    private ImageView weatherImage;
    private TextView weatherResponse;
    private TextView tempResponse;
    private ProgressBar progressBar;
    private static final String API_KEY = "3hYpE0bQAyldFgLwOhuSC3SAUCX5oVCfDXNsrbWJ";
    private static final String API_URL = "http://api.aerisapi.com/observations/";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        placeEditText=(EditText)findViewById(R.id.editText);
        weatherImage=(ImageView)findViewById(R.id.weatherImageView);
        weatherResponse = (TextView)findViewById(R.id.textViewWeather);
        tempResponse=(TextView)findViewById(R.id.textViewTemp);
        progressBar=(ProgressBar)findViewById(R.id.progressBar);
        weatherImage.setImageResource(android.R.color.transparent);
        Button searchButton = (Button)findViewById(R.id.button);
        searchButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String place = placeEditText.getText().toString();
                new RetrieveFeedTask().execute(place);
            }
        });
    }

    class RetrieveFeedTask extends AsyncTask<String, Void, String >{
        private Exception exception;

        @Override
        protected void onPreExecute() {
            progressBar.setVisibility(View.VISIBLE);
            weatherResponse.setText("");
            tempResponse.setText("");
            weatherImage.setImageResource(android.R.color.transparent);

        }

        @Override
        protected String doInBackground(String... strings) {
            String place = strings[0];
            try{
                Log.d("url", "doInBackground: ");
                URL url = new URL(API_URL+place+"?client_id=7BrmRkWPr8jeCTIPGlIUo&client_secret="+API_KEY);
                Log.d("url", API_URL+place+"?client_id=7BrmRkWPr8jeCTIPGlIUo&client_secret="+API_KEY);
                HttpURLConnection urlConnection = (HttpURLConnection)url.openConnection();
                try{
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
                    StringBuilder stringBuilder = new StringBuilder();
                    String line;
                    while ((line=bufferedReader.readLine())!=null){
                        stringBuilder.append(line).append("\n");
                        Log.d("line", line);
                    }
                    bufferedReader.close();
                    return stringBuilder.toString();

                } finally {
                    urlConnection.disconnect();
                }
            } catch (Exception e){
                Log.d("Error", e.getMessage(), e);
                return null;
            }

        }

        @Override
        protected void onPostExecute(String s) {
            if (s==null){
                s="There was an error";
            }
            progressBar.setVisibility(View.GONE);
            try{
                Log.d("s", s);
                JSONObject object = (JSONObject)new JSONTokener(s).nextValue();
                Log.d("badcity", String.valueOf(object.getString("success").equals("false")));
                if(object.getString("success").equals("false")){
                    weatherResponse.setText("No Data. Please Try Again.");
                }else{
                    JSONObject response = object.getJSONObject("response");
                    JSONObject ob=response.getJSONObject("ob");
                    Log.d("response", String.valueOf(response));
                    Log.d("ob", String.valueOf(ob));
                    String tempF = ob.getString("tempF");
                    Log.d("temp", tempF);
                    String weatherShort = ob.getString("weatherShort");
                    weatherResponse.setText(weatherShort);
                    tempResponse.setText(tempF+"°F");
                    switch (weatherShort){
                        case "Clear":
                            weatherImage.setImageResource(R.drawable.clear);
                            break;
                        case "Sunny":
                            weatherImage.setImageResource(R.drawable.clear);
                            break;
                        case "Mostly Sunny":
                            weatherImage.setImageResource(R.drawable.clear);
                            break;
                        case "Snow":
                            weatherImage.setImageResource(R.drawable.snow);
                            break;
                        case "Rain":
                            weatherImage.setImageResource(R.drawable.rain);
                            break;
                        case "Light Rain":
                            weatherImage.setImageResource(R.drawable.rain);
                            break;
                        case "Partly Cloudy":
                            weatherImage.setImageResource(R.drawable.partlyclear);
                            break;
                        case "Fog":
                            weatherImage.setImageResource(R.drawable.fog);
                            break;
                        case "Cloudy":
                            weatherImage.setImageResource(R.drawable.cloud);
                            break;
                        case "Mostly Cloudy":
                            weatherImage.setImageResource(R.drawable.cloud);
                            break;
                        default: weatherImage.setImageResource(android.R.color.transparent);
                    }

                }


            }catch (JSONException e){
                e.printStackTrace();
            }
        }
    }

}
