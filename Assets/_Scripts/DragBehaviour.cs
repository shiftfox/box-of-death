using UnityEngine;

public class DragBehaviour : MonoBehaviour {

    public float speed;
    [HideInInspector] public Rigidbody2D rb;

    private void Awake() {
        rb = GetComponent<Rigidbody2D>();
    }

    private void OnMouseDrag() {
        Vector2 mouse = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        transform.position = Vector2.Lerp(transform.position, mouse, speed * Time.deltaTime);
        rb.velocity = Vector2.zero;
    }
}