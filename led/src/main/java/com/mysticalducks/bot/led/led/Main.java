package com.mysticalducks.bot.led.led;

import org.telegram.telegrambots.ApiContextInitializer;
import org.telegram.telegrambots.meta.TelegramBotsApi;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import com.mysticalducks.bot.led.bot.Bot;

/**
 * Hello world!
 *
 */
public class Main 
{
    public static void main( String[] args )
    {
    	 ApiContextInitializer.init();
    	 
    	 TelegramBotsApi botsApi = new TelegramBotsApi();

         try {
             botsApi.registerBot(new Bot());
         } catch (TelegramApiException e) {
             e.printStackTrace();
         }
    }
}
