package com.mysticalducks.bot.led.util;

import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.InlineKeyboardMarkup;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.ReplyKeyboard;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.InlineKeyboardButton;

@SuppressWarnings("all")
public class KeyboardFactory {
  public enum LedButtonsType {
    BLUE,
    
    WHITE,
    
    GREEN;
  }
  
  public static ReplyKeyboard ledButtons() {
    final InlineKeyboardMarkup inlineKeyboard = new InlineKeyboardMarkup();
    final List<List<InlineKeyboardButton>> rowsInline = CollectionLiterals.<List<InlineKeyboardButton>>newArrayList();
    final List<InlineKeyboardButton> rowInline = CollectionLiterals.<InlineKeyboardButton>newArrayList();
    KeyboardFactory.LedButtonsType[] _values = KeyboardFactory.LedButtonsType.values();
    for (final KeyboardFactory.LedButtonsType type : _values) {
      rowInline.add(new InlineKeyboardButton().setText(KeyboardFactory.getLedButton(type)).setCallbackData(KeyboardFactory.getLedButton(type)));
    }
    rowsInline.add(rowInline);
    inlineKeyboard.setKeyboard(rowsInline);
    return inlineKeyboard;
  }
  
  public static String getLedButton(final KeyboardFactory.LedButtonsType buttonsType) {
    String _switchResult = null;
    if (buttonsType != null) {
      switch (buttonsType) {
        case BLUE:
          _switchResult = "blau";
          break;
        case WHITE:
          _switchResult = "weiß";
          break;
        case GREEN:
          _switchResult = "grün";
          break;
        default:
          _switchResult = null;
          break;
      }
    } else {
      _switchResult = null;
    }
    return _switchResult;
  }
}
