package bitsy.lang;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class ProcessUtil {
	static class StreamGobbler extends Thread {
		InputStream is;
		String type;

		StreamGobbler(InputStream is, String type) {
			this.is = is;
			this.type = type;
		}

		public void run() {
			try {
				InputStreamReader isr = new InputStreamReader(is);
				BufferedReader br = new BufferedReader(isr);
				String line = null;
				while ((line = br.readLine()) != null) {
					System.out.println(type + ">" + line);
					System.out.flush();
				}
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
	}
	
	public static int run(String cmd) {
    	System.out.println(cmd);
    	System.out.flush();
    	int result;
    	try {
        	Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec(cmd);
    		StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR");
    		StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT");
    		errorGobbler.start();
    		outputGobbler.start();
            result = proc.waitFor();
            System.out.println("Returned: "+result);
            System.out.flush();
    	} catch (IOException | InterruptedException e) {
    	    e.printStackTrace();
    	    result = -1;
    	}
        return result;
    }
}
