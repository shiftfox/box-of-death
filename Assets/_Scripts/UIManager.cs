using UnityEngine;

public class UIManager : MonoBehaviour {
    
    public void Restart() {
        StageManager.instance.ReloadScene();
    }

    public void Quit() {
        StageManager.instance.LoadScene(0);
    }
}