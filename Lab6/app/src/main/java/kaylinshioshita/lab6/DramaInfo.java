package kaylinshioshita.lab6;

/**
 * Created by kaylinshioshita on 12/4/17.
 */

public class DramaInfo {
    private String title;
    private String url;

    public String getTitle(){
        return title;
    }

    public String getUrl(){
        return url;
    }
    public void setDrama(Integer genrePref, Integer fandomPref){
        if (genrePref != 0){
            switch (genrePref){
                case 1: //melodrama
                    if (fandomPref==0){ //harry potter
                        title="Goblin: The Lonely Great God";
                        url="https://www.dramafever.com/drama/4914/Goblin:_The_Lonely_and_Great_God/";
                    } else if (fandomPref==1) { //Game of thrones
                        title="Descendants of the Sun";
                        url="https://www.dramafever.com/drama/4627/Descendants_of_the_Sun/";
                    } else if (fandomPref==2) { //Friends
                        title="Good Doctor";
                        url="https://www.dramafever.com/drama/4306/Good_Doctor/";
                    } else { //Sherlock
                        title="City Hunter";
                        url="https://www.dramafever.com/drama/3937/City_Hunter/";
                    }
                    break;

                case 2: //romantic comedy
                    if (fandomPref==0){ //harry potter
                        title="Strong Woman Do Bong Soon";
                        url="https://www.dramafever.com/drama/4988/Strong_Woman_Do_Bong_Soon/";
                    } else if (fandomPref==1) { //Game of thrones
                        title="Master's Sun";
                        url="https://www.dramafever.com/drama/4305/The_Master%27s_Sun/";
                    } else if (fandomPref==2) { //Friends
                        title="Weightlifting Fairy Kim Bok Joo";
                        url="https://www.dramafever.com/drama/4981/Weightlifting_Fairy_Kim_Bok_Joo/";
                    } else { //Sherlock
                        title="I Hear Your Voice";
                        url="https://www.dramafever.com/drama/4275/I_Hear_Your_Voice/";
                    }
                    break;

                case 3: //action
                    if (fandomPref==0){ //harry potter
                        title="Let's Fight Ghost";
                        url="https://www.dramafever.com/drama/4923/Let%27s_Fight_Ghost/";
                    } else if (fandomPref==1) { //Game of thrones
                        title="Circle: Two Worlds Connected";
                        url="https://www.dramafever.com/drama/5028/Circle:_Two_Worlds_Connected/";
                    } else if (fandomPref==2) { //Friends
                        title="Squad 38";
                        url="https://www.dramafever.com/drama/4929/Squad_38/";
                    } else { //Sherlock
                        title="Signal";
                        url="https://www.dramafever.com/drama/4686/next/Signal/";
                    }
                    break;

                case 4: //historical
                    if (fandomPref==0){ //harry potter
                        title="Gu Family Book";
                        url="https://www.dramafever.com/drama/4244/Gu_Family_Book/";
                    } else if (fandomPref==1) { //Game of thrones
                        title="Faith";
                        url="https://www.dramafever.com/drama/4123/Faith/";
                    } else if (fandomPref==2) { //Friends
                        title="Hwarang";
                        url="https://www.dramafever.com/drama/4884/Hwarang/";
                    } else { //Sherlock
                        title="Arang and the Magistrate";
                        url="https://www.dramafever.com/drama/4133/Arang_and_the_Magistrate/";
                    }
                    break;


            }
        }

    }
}
