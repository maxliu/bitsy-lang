package bitsy.lang;

import java.text.DecimalFormat;
import java.text.NumberFormat;

public class Test {

	public static void main(String[] args) {
		NumberFormat nf = new DecimalFormat("#.#########################");
		Double d1 = 1.0d;
		String ds = nf.format(d1);
	}

}
