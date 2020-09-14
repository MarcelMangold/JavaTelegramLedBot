package com.mysticalducks.bot.led.bot;

import org.telegram.abilitybots.api.bot.AbilityBot
import org.telegram.abilitybots.api.objects.Ability

import static org.telegram.abilitybots.api.objects.Locality.*
import static org.telegram.abilitybots.api.objects.Privacy.*
import org.telegram.telegrambots.meta.api.methods.send.SendMessage
import com.mysticalducks.bot.led.util.KeyboardFactory
import org.telegram.abilitybots.api.objects.ReplyFlow
import org.telegram.abilitybots.api.objects.Reply
import java.util.function.Predicate
import org.telegram.telegrambots.meta.api.objects.Update
import javax.validation.constraints.NotNull

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
                    .setText("test")
                    .setChatId(ctx.chatId)
                    .setReplyMarkup(KeyboardFactory.ledButtons) )
			].build
	}
	
	
	
//    def ReplyFlow directionFlow() {
//        val Reply saidLeft = Reply.of([upd | silent.send("Sir, I have gone left.", get]),
//          hasMessageWith("go left or else"));
//
//        val ReplyFlow leftflow = ReplyFlow.builder(db)
//          .action(upd -> silent.send("I don't know how to go left.", getChatId(upd)))
//          .onlyIf(hasMessageWith("left"))
//          .next(saidLeft).build();
//
//        val Reply saidRight = Reply.of([upd | silent.send("Sir, I have gone right.", getChatId(upd)]),
//          hasMessageWith("right"));
//
//        return ReplyFlow.builder(db)
//          .action([upd | silent.send("Command me to go left or right!", getChatId(upd))])
//          .onlyIf(hasMessageWith("wake up"))
//          .next(leftflow)
//          .next(saidRight)
//          .build();
//    }
//
//    @NotNull
//    private def Predicate<Update> hasMessageWith(String msg) {
//        return [upd | upd.getMessage().getText().equalsIgnoreCase(msg)];
//    }


	override creatorId() {
		return 123
	}

}
