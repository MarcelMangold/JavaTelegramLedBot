package com.mysticalducks.bot.led.bot;

import com.mysticalducks.bot.led.util.KeyboardFactory;
import java.util.function.Consumer;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.telegram.abilitybots.api.bot.AbilityBot;
import org.telegram.abilitybots.api.objects.Ability;
import org.telegram.abilitybots.api.objects.Locality;
import org.telegram.abilitybots.api.objects.MessageContext;
import org.telegram.abilitybots.api.objects.Privacy;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Message;

@SuppressWarnings("all")
public class Bot extends AbilityBot {
  public Bot(final String token, final String botUsername) {
    super(token, botUsername);
  }
  
  public Ability sayHello() {
    final Consumer<MessageContext> _function = new Consumer<MessageContext>() {
      @Override
      public void accept(final MessageContext ctx) {
        StringConcatenation _builder = new StringConcatenation();
        _builder.append("Folgende Optionen stehen dir zur Auswahl:");
        _builder.newLine();
        _builder.append("\t\t\t\t\t\t");
        _builder.append("- /an");
        _builder.newLine();
        _builder.append("\t\t\t\t\t\t");
        _builder.append("- /aus");
        _builder.newLine();
        Bot.this.silent.send(_builder.toString(), (ctx.chatId()).longValue());
      }
    };
    return Ability.builder().name("help").info("Show functions").privacy(Privacy.PUBLIC).locality(Locality.ALL).input(0).action(_function).build();
  }
  
  public Ability setLedOn() {
    final Consumer<MessageContext> _function = new Consumer<MessageContext>() {
      @Override
      public void accept(final MessageContext ctx) {
        try {
          Bot.this.sender.<Message, SendMessage>execute(new SendMessage().setText("test").setChatId(ctx.chatId()).setReplyMarkup(KeyboardFactory.ledButtons()));
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    };
    return Ability.builder().name("an").info("turn leds on").privacy(Privacy.PUBLIC).locality(Locality.ALL).input(0).action(_function).build();
  }
  
  @Override
  public int creatorId() {
    return 123;
  }
}
