import java.util.Set;
import java.util.HashSet;

public enum Keys {
  FORWARD,
  BACKWARD,
  ROTATE_LEFT,
  ROTATE_RIGHT,
  FIRE
}

class InputHandler {
  Set<Keys> active;
  Set<Keys> removeQueue;
  Set<Keys> addQueue;
  HashMap<Character, Keys> keyMap;
  
  InputHandler() {
    addQueue = new HashSet<Keys>();
    removeQueue = new HashSet<Keys>();
    active = new HashSet<Keys>();
    keyMap = new HashMap<Character, Keys>();
    keyMap.put('w', Keys.FORWARD);
    keyMap.put('a', Keys.ROTATE_LEFT);
    keyMap.put('s', Keys.BACKWARD);
    keyMap.put('d', Keys.ROTATE_RIGHT);
    keyMap.put(' ', Keys.FIRE);
  }

  void update() {
    active.addAll(addQueue);
    addQueue.clear();
  }
  
  void add(char k) {
    if (keyMap.containsKey(k)) {
      addQueue.add(keyMap.get(k));   
    }
  }

  void release(char k) {
    if (keyMap.containsKey(k)) {
      removeQueue.add(keyMap.get(k));   
    }
  }
  
  void clearReleased() {
    active.removeAll(removeQueue);
    removeQueue.clear();
  }
  
  boolean isPressed(Keys k) {
    return active.contains(k);
  }
}