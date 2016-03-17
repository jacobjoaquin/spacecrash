import java.util.HashSet;

public enum Sound {
  FIRE
}

class SoundPlayer {
  PApplet parent;
  HashMap<Sound, SoundFile> bank = new HashMap<Sound, SoundFile>();

  SoundPlayer(PApplet parent) {
  	this.parent = parent;
  	bank.put(Sound.FIRE, new SoundFile(parent, "zap.wav"));
  }

  void play(Sound sound) {
  	bank.get(sound).play();
  }	
}