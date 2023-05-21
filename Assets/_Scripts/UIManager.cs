using UnityEngine;
using DG.Tweening;

public class UIManager : MonoBehaviour {

    private static bool paused;
    public CanvasGroup pauseMenu;
    
    public void TogglePause() {
        paused = !paused;

        pauseMenu.DOFade(paused ? 1f : 0f, 1f).SetUpdate(true);
        pauseMenu.interactable = paused;
        pauseMenu.blocksRaycasts = paused;

        Time.timeScale = paused ? 0f : 1f;

        AudioManager.instance.Play("Select");
    }

    private void Update() {
        if (Input.GetKeyDown(KeyCode.Escape)) TogglePause();
    }

    public void Restart() {
        StageManager.instance.ReloadScene();
        AudioManager.instance.Play("Select");
    }

    public void Quit() {
        StageManager.instance.LoadScene(0);
        AudioManager.instance.Play("Select");
    }
}