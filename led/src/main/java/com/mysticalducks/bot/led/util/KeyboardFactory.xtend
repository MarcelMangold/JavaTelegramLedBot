package com.mysticalducks.bot.led.util

import org.telegram.telegrambots.meta.api.objects.replykeyboard.InlineKeyboardMarkup
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.InlineKeyboardButton
import org.telegram.telegrambots.meta.api.objects.replykeyboard.ReplyKeyboard
import java.util.List
import java.util.ArrayList
import com.mysticalducks.bot.led.util.KeyboardFactory.LedButtonsType

class KeyboardFactory {
	
	enum LedButtonsType {BLUE, WHITE, GREEN}
	
	//@ToDo add google inject
	def static ReplyKeyboard ledButtons() {
        val InlineKeyboardMarkup inlineKeyboard = new InlineKeyboardMarkup();
        val List<List<InlineKeyboardButton>> rowsInline = newArrayList
        val List<InlineKeyboardButton> rowInline = newArrayList;
        for(type : LedButtonsType.values) {
        	 rowInline.add(new InlineKeyboardButton().setText(type.ledButton).setCallbackData(type.ledButton))
        }
        rowsInline.add(rowInline);
        inlineKeyboard.setKeyboard(rowsInline);
        return inlineKeyboard;
    }
    
    
    
    
    def static String getLedButton(LedButtonsType buttonsType) {
    	switch(buttonsType) {
    		case BLUE : "blau"
    		case WHITE : "weiß"
    		case GREEN: "grün"
    		default: null
    	}
    }
}