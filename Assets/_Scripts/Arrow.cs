using UnityEngine;

public class Arrow : MonoBehaviour {

    private void OnCollisionEnter2D(Collision2D collision) {
        if (collision.gameObject.CompareTag("Player"))
            collision.gameObject.GetComponent<PlayerHealth>().Damage(0.1f, PlayerHealth.DeathType.Bow);

        Destroy(gameObject);
    }
}