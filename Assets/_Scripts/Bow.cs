using UnityEngine;

public class Bow : MonoBehaviour {

    public Rigidbody2D arrow;
    public Transform firePoint;
    public float bulletSpeed;

    private int shots;

    private void OnMouseOver() {
        if (Input.GetMouseButtonDown(1))
            Shoot();
    }

    private void Shoot() {
        shots++;
        AudioManager.instance.Play("Bow");

        Rigidbody2D rb = Instantiate(arrow, firePoint.position, firePoint.rotation);
        rb.AddForce(transform.right * bulletSpeed, ForceMode2D.Impulse);

        Destroy(rb.gameObject, 5);

        if (shots >= 5) Destroy(gameObject);
    }
}