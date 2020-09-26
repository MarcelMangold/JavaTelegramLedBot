package com.mysticalducks.bot.led.bot;

import com.mysticalducks.bot.led.util.KeyboardFactory
import java.util.function.Predicate
import javax.validation.constraints.NotNull
import org.telegram.abilitybots.api.bot.AbilityBot
import org.telegram.abilitybots.api.objects.Ability
import org.telegram.telegrambots.meta.api.methods.send.SendMessage
import org.telegram.telegrambots.meta.api.objects.Update

import static org.telegram.abilitybots.api.objects.Flag.*
import static org.telegram.abilitybots.api.objects.Locality.*
import static org.telegram.abilitybots.api.objects.Privacy.*

class Bot extends AbilityBot {
	

	new (String token, String botUsername) {
		super(token, botUsername)
	}
	
	
	def Ability sayHello()  {
		return Ability.builder
			.name("help")
			.info("Show functions")
			.privacy(PUBLIC)  
        	.locality(ALL) 
			.input(0)
			.action[ ctx | 
				silent.send(
					'''Folgende Optionen stehen dir zur Auswahl:
						- /an
						- /aus
					''', ctx.chatId())
			].build
	}


	def Ability setLedOn()  {
		return Ability.builder
			.name("an")
			.info("turn leds on")
			.privacy(PUBLIC)  
        	.locality(ALL) 
			.input(0)
			.action[ ctx |
				
				sender.execute(new SendMessage()
					.setText("as")
                    .setChatId(ctx.chatId)
                    .setReplyMarkup(KeyboardFactory.ledButtons) )
			]
			.reply (
				[upd |
              		// Prints to console
              		System.out.println("I'm in a reply!");
             		// Sends message
              		silent.send(
					'''test
					''', upd.callbackQuery.message.chat.id)
            		
            	],
            	CALLBACK_QUERY,
            	
//            	isReplyToBot,
            	hasMessageWith("blau")
            )
			.build
	}
	
	def Ability setLedOff()  {
		return Ability.builder
			.name("aus")
			.info("turn leds of")
			.privacy(PUBLIC)  
        	.locality(ALL) 
			.input(0)
			.action[ ctx |
				sender.execute(new SendMessage()
					.setText("as")
                    .setChatId(ctx.chatId)
                    .setReplyMarkup(KeyboardFactory.ledButtons) )
			].build
	}
	
	
    @NotNull
    private def Predicate<Update> hasMessageWith(String msg) {
        return [upd | 
				upd.callbackQuery.data.equals(msg)
        ];
    }


	override creatorId() {
		return 123
	}

}
