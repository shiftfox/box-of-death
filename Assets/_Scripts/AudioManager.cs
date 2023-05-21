using UnityEngine;

public class AudioManager : MonoBehaviour {

    [System.Serializable]
    public class Sound {
        [HideInInspector] public AudioSource source;
        public string name;
        public bool loop;
        [Range(0, 1)] public float volume;
        public AudioClip clip;
    }

    public Sound[] sounds;
    public static AudioManager instance;

    private void Awake() {
        if (instance != null) {
            Destroy(gameObject);
            return;
        }

        transform.SetParent(null, false);
        instance = this;
        DontDestroyOnLoad(instance);

        foreach (Sound sound in sounds) {
            sound.source = gameObject.AddComponent<AudioSource>();
            sound.source.volume = sound.volume;
            sound.source.pitch = 1f;
            sound.source.loop = sound.loop;
            sound.source.clip = sound.clip;
        }
    }

    public void Play(string name) {
        foreach (Sound sound in sounds) {
            if (sound.name == name) {
                if (!sound.loop) sound.source.pitch = Random.Range(1f, 2f);
                sound.source.Play();
            }
        }
    }

    public void Stop(string name) {
        foreach (Sound sound in sounds) {
            if (sound.name == name)
                sound.source.Stop();
        }
    }
}