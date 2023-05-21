using UnityEngine;
using System.Collections;

public class PlayerMovement : MonoBehaviour {

    public float speed;
    public float jumpForce;
    public int maxJumps;
    public LayerMask whatIsGround;

    private int jumps;
    private float movement;
    private Rigidbody2D rb;

    private void Awake() {
        rb = GetComponent<Rigidbody2D>();
        StartCoroutine(IWalkNoise());
    }

    private void Update() {
        movement = Input.GetAxis("Horizontal");
        if (movement > 0) transform.rotation = Quaternion.identity;
        else if (movement < 0) transform.rotation = Quaternion.Euler(0, 180, 0);

        if (Input.GetButtonDown("Jump") && jumps < maxJumps)
            Jump();
    }

    public void Jump() {
        jumps++;
        AudioManager.instance.Play("Jump");
        rb.AddForce(new Vector2(0, jumpForce), ForceMode2D.Impulse);
    }

    private void FixedUpdate() {
        rb.velocity = new Vector2(speed * movement * Time.fixedDeltaTime, rb.velocity.y);
    }

    private void OnCollisionEnter2D(Collision2D collision) {
        if (((1 << collision.gameObject.layer) & whatIsGround) != 0)
            jumps = 0;
    }

    private IEnumerator IWalkNoise() {
        while (true) {
            if (jumps == 0 && (movement > 0.5f || movement < -0.5f)) {
                AudioManager.instance.Play("Walk");
            }

            yield return new WaitForSeconds(.25f);
        }
    }
}