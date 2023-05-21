using UnityEngine;

public class MainMenu : MonoBehaviour {

    private bool interrupt;

    private void Awake() {
        interrupt = PlayerPrefs.GetInt("Tutorial", 0) == 0;
    }

    public void Play() {
        int index = interrupt? UnityEngine.SceneManagement.SceneManager.sceneCountInBuildSettings - 1 : Random.Range(1, UnityEngine.SceneManagement.SceneManager.sceneCountInBuildSettings);
        if (interrupt) PlayerPrefs.SetInt("Tutorial", 1);
        
        StageManager.instance.LoadScene(index);
        AudioManager.instance.Play("Select");
    }

    public void PlaySound() {
        AudioManager.instance.Play("Select");
    }

    public void Quit() {
        AudioManager.instance.Play("Select");
        Application.Quit();
    }
}