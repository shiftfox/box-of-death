using UnityEngine;
using DG.Tweening;
using UnityEngine.UI;
using System.Threading.Tasks;
using UnityEngine.SceneManagement;

public class StageManager : MonoBehaviour {

    public CanvasGroup group;
    public Slider slider;
    public static StageManager instance;

    private void Awake() {
        if (instance != null) {
            Destroy(gameObject);
            return;
        }

        transform.SetParent(null, false);
        instance = this;
        DontDestroyOnLoad(instance);

        group.alpha = 1;
        group.DOFade(0, 1f);
    }

    public async void LoadScene(string name) {
        group.DOFade(1f, 1f).SetUpdate(true);
        await Task.Delay(1000);

        AsyncOperation operation = SceneManager.LoadSceneAsync(name);
        operation.allowSceneActivation = false;

        do {
            await Task.Delay(1);
            slider.DOValue(operation.progress + 0.1f, 1f).SetUpdate(true);
        } while (operation.progress < 0.9f);

        operation.allowSceneActivation = true;
        Time.timeScale = 1;

        await Task.Delay(1000);
        group.DOFade(0, 1f).SetUpdate(true);

        await Task.Delay(1000);

        slider.value = 0;
    }

    public void ReloadScene() {
        LoadScene(SceneManager.GetActiveScene().name);
    }

    public async void LoadScene(int index) {
        group.DOFade(1f, 1f).SetUpdate(true);
        await Task.Delay(1000);

        AsyncOperation operation = SceneManager.LoadSceneAsync(index);
        operation.allowSceneActivation = false;

        do {
            await Task.Delay(1);
            slider.DOValue(operation.progress + 0.1f, 1f).SetUpdate(true);
        } while (operation.progress < 0.9f);

        operation.allowSceneActivation = true;
        Time.timeScale = 1;

        await Task.Delay(1000);
        group.DOFade(0, 1f).SetUpdate(true);

        await Task.Delay(1000);

        slider.value = 0;
    }
}