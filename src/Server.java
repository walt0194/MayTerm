import java.io.*;
import java.net.*;

public class Server {

	public static void main(String [] args) throws IOException{
		
		int port = 6374;
		while(true) {
			
			try(	
				ServerSocket serverSocket = new ServerSocket(port);
				Socket socket = serverSocket.accept();
				PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
				BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			)
			{
				System.out.println("Connection Established");
				String message = "";
				
				while(message != null) {
					message = in.readLine();
					System.out.println("CLient: " + message);
				}
				
				System.out.println("Connection Lost");
			}
			catch(IOException e){
				System.out.println("Error, IO Exception");
				System.exit(1);
			}
		}
	}

}
