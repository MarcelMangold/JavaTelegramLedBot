package com.mysticalducks.bot.led.main;

import org.telegram.telegrambots.ApiContextInitializer;
import org.telegram.telegrambots.meta.TelegramBotsApi;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import com.mysticalducks.bot.led.bot.Bot;
import com.mysticalducks.bot.led.util.PropertyReader
import com.mysticalducks.bot.led.util.PropertyReader.PropertyType

/**
 * Hello world!
 *
 */
class Main 
{
    def static void main( String[] args )
    {
    	ApiContextInitializer.init();
		val TelegramBotsApi botsApi = new TelegramBotsApi();

		try {
			val propReader = new PropertyReader();
			val token = propReader.getProperty(PropertyType.BOT_TOKEN);
			val botUserName = propReader.getProperty(PropertyType.BOT_USERNAME);
			botsApi.registerBot(new Bot(token,botUserName));
		} catch (TelegramApiException e) {
			e.printStackTrace();
		}
    }
}
