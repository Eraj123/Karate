package GeneretData;

import java.util.Random;

public class Data {

	public static void main(String[] args) {
      
		System.out.println(Email());
		
	}

	public static  String Email() {
		String name = "john";
		String LN = "@gmail.com";
	 	Random Rand = new Random();
        String  email = name + Rand.nextInt() + LN;
        return email;
	}
}
