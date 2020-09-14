package com.mysticalducks.bot.led.main;

import com.mysticalducks.bot.led.bot.Bot;
import com.mysticalducks.bot.led.util.PropertyReader;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.telegram.telegrambots.ApiContextInitializer;
import org.telegram.telegrambots.meta.TelegramBotsApi;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

/**
 * Hello world!
 */
@SuppressWarnings("all")
public class Main {
  public static void main(final String[] args) {
    ApiContextInitializer.init();
    final TelegramBotsApi botsApi = new TelegramBotsApi();
    try {
      final PropertyReader propReader = new PropertyReader();
      final String token = propReader.getProperty(PropertyReader.PropertyType.BOT_TOKEN);
      final String botUserName = propReader.getProperty(PropertyReader.PropertyType.BOT_USERNAME);
      Bot _bot = new Bot(token, botUserName);
      botsApi.registerBot(_bot);
    } catch (final Throwable _t) {
      if (_t instanceof TelegramApiException) {
        final TelegramApiException e = (TelegramApiException)_t;
        e.printStackTrace();
      } else {
        throw Exceptions.sneakyThrow(_t);
      }
    }
  }
}
