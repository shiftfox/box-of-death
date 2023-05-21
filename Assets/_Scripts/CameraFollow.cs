using UnityEngine;

public class CameraFollow : MonoBehaviour {

    public Transform target;
    public Vector3 offset;
    public float time;

    private void FixedUpdate() {
        if (target != null) transform.position = Vector3.Lerp(transform.position, target.position + offset, time);
    }
}