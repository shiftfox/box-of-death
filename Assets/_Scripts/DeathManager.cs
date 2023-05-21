using System.Collections;
using UnityEngine;
using DG.Tweening;
using TMPro;

public class DeathManager : MonoBehaviour {

    public RectTransform deathPanel, lostPanel;
    public Timer timer;
    public TextMeshProUGUI deathTypeText, timerText;
    public static DeathManager instance;

    private void Awake() {
        instance = this;
    }

    public void HandleDeath(PlayerHealth.DeathType type) {
        if (type == PlayerHealth.DeathType.Timer) {
            StartCoroutine(IAnimate(lostPanel));
            return;
        }

        deathTypeText.text = "Death by " + type;
        timerText.text = timer.timer.ToString("0.00") + " seconds";

        StartCoroutine(IAnimate(deathPanel));
    }

    private IEnumerator IAnimate(Transform t) {
        yield return new WaitForSeconds(5f);
        t.DOMoveY(Camera.main.ScreenToWorldPoint(new Vector3(0, Screen.height * 0.5f)).y, 1f);
    }
}