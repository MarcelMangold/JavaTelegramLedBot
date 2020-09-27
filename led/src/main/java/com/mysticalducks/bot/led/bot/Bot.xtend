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
import com.mysticalducks.bot.led.util.Client
import com.mysticalducks.bot.led.util.KeyboardFactory.LedButtonsType

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
					.setText("Bitte wähle eine der Farben aus:")
                    .setChatId(ctx.chatId)
                    .setReplyMarkup(KeyboardFactory.ledButtons) )
			]
			.reply (
				[upd |
					val color = upd.callbackQuery.data
					try {
						Client.sendMessage(color.hexColor)
              			silent.send(
						'''Farbe erfolgreich in «color» gewechselt.
						''', upd.callbackQuery.message.chat.id)
					} catch (Exception e) {
						silent.send(
							'''Die Farbe konnte nicht gewechselt werden. Es gab Probleme bei der Socketverbindung.''',
							upd.callbackQuery.message.chat.id
						)
					}
            	],
            	CALLBACK_QUERY,
            	isColorCode()
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
				try {
					Client.sendMessage("off")
              		silent.send(
						'''
						LED's erfolgreich ausgeschaltet.
						''', ctx.chatId)
					} catch (Exception e) {
						silent.send(
							'''
							Die Led's konnten nicht ausgeschaltet werden.
							Es gab Probleme bei der Socketverbindung.
							''',
							ctx.chatId
						)
					}
			].build
	}
	
	
    @NotNull
    private def Predicate<Update> hasMessageWith(String msg) {
        return [upd | 
				upd.callbackQuery.data.equals(msg)
        ];
    }
    
    @NotNull
    private def Predicate<Update> isColorCode() {
        return [upd | 
        		_isColorCode(upd.callbackQuery.data)
        ];
    }
    
    private def _isColorCode(String color) {
    	for(type : LedButtonsType.values){
    		if(KeyboardFactory.getLedButton(type) == color)
    			return true
    	}
    	return false
    }


	override creatorId() {
		return 123
	}
	
	private def String getHexColor(String color) {
		switch(color) {
			case KeyboardFactory.getLedButton(LedButtonsType.BLUE) 		: "255,000,255"
			case KeyboardFactory.getLedButton(LedButtonsType.GREEN) 	: "255,115,115"
			case KeyboardFactory.getLedButton(LedButtonsType.WHITE) 	: "255,255,255"
			default: "255,255,255"
		}
			 
			
	}

}
