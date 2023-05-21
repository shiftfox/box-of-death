using UnityEngine;
using TMPro;

public class Timer : MonoBehaviour {

    public float time;
    public TextMeshProUGUI text;
    public PlayerHealth health;

    [HideInInspector] public float timer;

    private void Update() {
        if (timer == -1) return;
        if (health == null) {
            text.color = Color.green;
            return;
        }

        timer += Time.deltaTime;

        text.text = (time - timer).ToString("0.00");

        float t = Mathf.Max(timer / time * 2, 1f);
        text.transform.localScale = new Vector3(t, t, 1);

        if (timer >= time) {
            timer = -1;
            text.color = Color.red;
            health.Damage(1, PlayerHealth.DeathType.Timer);
        }
    }
}