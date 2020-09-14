package com.mysticalducks.bot.led.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import org.eclipse.xtext.xbase.lib.Exceptions;

@SuppressWarnings("all")
public class PropertyReader {
  public enum PropertyType {
    BOT_TOKEN,
    
    BOT_USERNAME;
  }
  
  private Properties prop = null;
  
  public PropertyReader() {
    Properties _properties = new Properties();
    this.prop = _properties;
    String _property = System.getProperty("user.dir");
    final String fileName = (_property + "\\resources\\config\\config.properties");
    System.out.println(fileName);
    InputStream is = null;
    try {
      FileInputStream _fileInputStream = new FileInputStream(fileName);
      is = _fileInputStream;
      this.prop.load(is);
    } catch (final Throwable _t) {
      if (_t instanceof FileNotFoundException) {
        throw new RuntimeException((("Config file" + fileName) + "doesn\'t exist"));
      } else if (_t instanceof IOException) {
        throw new RuntimeException(("Error while reading" + fileName));
      } else {
        throw Exceptions.sneakyThrow(_t);
      }
    }
  }
  
  public String getProperty(final PropertyReader.PropertyType property) {
    return this.prop.getProperty(this.getPropertyValue(property));
  }
  
  private String getPropertyValue(final PropertyReader.PropertyType property) {
    String _switchResult = null;
    if (property != null) {
      switch (property) {
        case BOT_TOKEN:
          _switchResult = "bot_token";
          break;
        case BOT_USERNAME:
          _switchResult = "bot_username";
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
