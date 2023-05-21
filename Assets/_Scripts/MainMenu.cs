using UnityEngine;

public class MainMenu : MonoBehaviour {

    public void Play() {
        StageManager.instance.LoadScene(PlayerPrefs.GetInt("Stage", 1));
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