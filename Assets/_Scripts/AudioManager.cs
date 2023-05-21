using UnityEngine;

public class AudioManager : MonoBehaviour {

    [System.Serializable]
    public class Sound {
        [HideInInspector] public AudioSource source;
        public string name;
        public bool loop;
        public bool playOnAwake;
        [Range(0, 1)] public float volume;
        [Range(-3, 3)] public float pitch = 1f;
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
            sound.source.pitch = sound.pitch;
            sound.source.loop = sound.loop;
            sound.source.clip = sound.clip;

            if (sound.playOnAwake) sound.source.Play();
        }
    }

    public void Play(string name) {
        foreach (Sound sound in sounds) {
            if (sound.name == name)
                sound.source.Play();
        }
    }

    public void Stop(string name) {
        foreach (Sound sound in sounds) {
            if (sound.name == name)
                sound.source.Play();
        }
    }
}