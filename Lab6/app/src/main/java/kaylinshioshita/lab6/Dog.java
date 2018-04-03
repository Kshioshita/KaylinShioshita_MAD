package kaylinshioshita.lab6;

/**
 * Created by kaylinshioshita on 4/2/18.
 */

public class Dog {
    private String name;
    private int imageResourceId;

    private Dog(String newname, int newId){
        this.name = newname;
        this.imageResourceId = newId;
    }

    public static final Dog[] toys = {
            new Dog("Pug", R.drawable.pug),
            new Dog("Yorkshire Terrier", R.drawable.yorkshireterrier),
            new Dog("Toy Fox Terrier", R.drawable.toyfoxterrier)

    };

    public static final Dog[] nonsporting = {
            new Dog("Dalmatian", R.drawable.dalmatian),
            new Dog("French Bulldog", R.drawable.frenchbulldog),
            new Dog("Chinese Shar-Pei", R.drawable.sharpei)
    };

    public static final Dog[] terrier = {
            new Dog("Scottish Terrier", R.drawable.scottishterrier),
            new Dog("Miniature Schnauzer", R.drawable.schnauzer),
            new Dog("West Highland White Terrier", R.drawable.westie)
    };

    public static final Dog[] working = {
            new Dog("Boxer", R.drawable.boxer),
            new Dog("Komondor", R.drawable.komondor),
            new Dog("Akita", R.drawable.akita)
    };

    public String getName(){
        return name;
    }

    public int getImageResourceId(){
        return imageResourceId;
    }

    public String toString(){
        return this.name;
    }
}
