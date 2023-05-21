using UnityEngine;
using UnityEngine.UI;

public class PlayerHealth : MonoBehaviour {

    public enum DeathType {
        Axe,
        Bow,
        Paint,
        Stick,
        Timer
    }

    private float damageDealt = 0;
    public Slider slider;

    public void Damage(float amount, DeathType type) {
        damageDealt += amount;
        slider.value = 1 - damageDealt;

        if (damageDealt >= 1) {
            DeathManager.instance.HandleDeath(type);
            AudioManager.instance.Play("Explosion");
            Destroy(gameObject);
        } else AudioManager.instance.Play("Hit/Hurt");
    }
}