package com.mysticalducks.bot.led.util

import java.net.Socket
import java.io.PrintStream
import java.io.InputStream
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.UnknownHostException
import java.io.IOException

class Client {
	
	def static void sendMessage(String message) {
		var Socket socket = null;
		try { 
           	socket = new Socket("localhost", 50007); 

            val outputStream = socket.getOutputStream(); 
            val ps = new PrintStream(outputStream, true); 
            ps.println(message); 

            val InputStream inputStream = socket.getInputStream(); 
            val buff = new BufferedReader(new InputStreamReader(inputStream)); 
             
            while (buff.ready()) { 
            	val line = buff.readLine()
            	if(line == 1){
            		throw new RuntimeException("Error in led api..")
            	}
                System.out.println(buff.readLine()); 
            } 
            

        } catch (UnknownHostException e) { 
            System.out.println("Unknown Host..."); 
            e.printStackTrace(); 
        } catch (IOException e) { 
            System.out.println("IOProbleme..."); 
            e.printStackTrace(); 
        } finally { 
            if (socket !== null) 
                try { 
                    socket.close(); 
                    System.out.println("Socket closed..."); 
                } catch (IOException e) { 
                    System.out.println("Socket can't closed..."); 
                    e.printStackTrace(); 
                } 
        } 
	}
	
}