﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Enermy : MonoBehaviour {

    public GameObject target;
    NavMeshAgent agent;
    Animator animator;

	// Use this for initialization
	void Start () {
        agent = GetComponent<NavMeshAgent>();
        animator = GetComponentInChildren<Animator>();
	}
	
	// Update is called once per frame
	void Update () {
        agent.destination = target.transform.position;
        animator.SetFloat("Speed", agent.velocity.magnitude);
	}
}
