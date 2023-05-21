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
        group.DOFade(1f, 1f);
        await Task.Delay(1000);

        AsyncOperation operation = SceneManager.LoadSceneAsync(name);
        operation.allowSceneActivation = false;

        do {
            await Task.Delay(1);
            slider.DOValue(operation.progress, 1f);
        } while (operation.progress < 0.9f);

        await Task.Delay(1000);

        operation.allowSceneActivation = true;
        slider.DOValue(0f, 1f);
        group.DOFade(0, 1f);
    }

    public void ReloadScene() {
        LoadScene(SceneManager.GetActiveScene().name);
    }

    public void LoadScene(int index) {
        LoadScene(SceneManager.GetSceneByBuildIndex(index).name);
    }
}