using UnityEngine;

public class Paint : MonoBehaviour {

    private void Awake() {
        float v = Random.Range(.1f, .5f);
        transform.localScale = new Vector3(v, v, 1);
        Destroy(gameObject, 5);
    }

    private void OnTriggerEnter2D(Collider2D collision) {
        if (collision.CompareTag("Player")) {
            collision.GetComponent<PlayerHealth>().Damage(transform.localScale.x / 5, PlayerHealth.DeathType.Paint);
            Destroy(gameObject);
        }
    }
}