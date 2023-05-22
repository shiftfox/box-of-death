using UnityEngine;
using DG.Tweening;

public class EffectManager : MonoBehaviour {

    public GameObject[] objects;
    public static EffectManager instance;

    private void Awake() {
        if (instance != null) {
            Destroy(gameObject);
            return;
        }

        transform.SetParent(null, false);
        instance = this;
        DontDestroyOnLoad(instance);
    }

    public void CameraShake() {
        Camera.main.DOShakePosition(.25f, strength: 0.1f);
    }

    public void SpawnParticle(Transform t, int p) {
        Destroy(Instantiate(objects[p], t.position, t.rotation), 2.5f);
    }
}