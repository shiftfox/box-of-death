using System.Collections;
using UnityEngine;

public class RandomBox : DragBehaviour {

    public float force;
    public Rigidbody2D[] items;
    private bool canSpawn = true;

    private void OnMouseOver() {
        if (Input.GetMouseButtonDown(1))
            SpawnRandom();
    }

    public void SpawnRandom() {
        if (!canSpawn) return;

        EffectManager.instance.CameraShake();
        EffectManager.instance.SpawnParticle(transform, 1);

        AudioManager.instance.Play("Item");
        StartCoroutine(IColliderDisable());

        Rigidbody2D item = Instantiate(items[Random.Range(0, items.Length)], transform.position, Quaternion.identity);
        item.AddForce(new Vector2(0, force), ForceMode2D.Impulse);
    }

    private IEnumerator IColliderDisable() {
        Collider2D collider = GetComponent<Collider2D>();

        float g = rb.gravityScale;

        collider.isTrigger = true;
        rb.gravityScale = 0;
        canSpawn = false;

        yield return new WaitForSeconds(.2f);

        collider.isTrigger = false;
        rb.gravityScale = g;
        canSpawn = true;
    }
}