using UnityEngine;
using System.Collections;

public class Bucket : MonoBehaviour {

    public SpriteRenderer paintRenderer;
    public SpriteRenderer paintball;

    private bool isEmpty;
    private Color color;

    private void Awake() {
        paintRenderer.color = new Color(Random.value, Random.value, Random.value);
    }

    private void OnMouseOver() {
        if (Input.GetMouseButtonDown(1) && !isEmpty) {
            AudioManager.instance.Play("Bucket");
            isEmpty = true;
            color = paintRenderer.color;
            paintRenderer.color = new Color(0.2735849f, 0.2735849f, 0.2735849f);
            StartCoroutine(IThrowPaint());
            Destroy(gameObject, 5);
        }
    }

    private IEnumerator IThrowPaint() {
        for (int i = 0; i < 20; i++) {
            SpriteRenderer sr = Instantiate(paintball, paintRenderer.transform.position, paintRenderer.transform.rotation);
            sr.color = color;
            yield return new WaitForSeconds(.05f);
        }

        Destroy(GetComponent<DragBehaviour>());
    }
}