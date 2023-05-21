using UnityEngine;

public class Music : MonoBehaviour {

    public string stop;
    public string start;

    private void Start() {
        AudioManager.instance.Stop(stop);
        AudioManager.instance.Play(start);
        Destroy(gameObject);
    }
}