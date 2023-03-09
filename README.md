# Summary

Demo is based on the outline at https://mobb.ninja/docs/rosa/aws-load-balancer-operator/

## Walkthrough

1. Create the infrastructure needed (IAM):

```
make infra-init
make infra-plan
make infra-apply
```

Take note of the output, specifically the `controller_role_arn` value:

```
Apply complete! Resources: 10 added, 0 changed, 3 destroyed.

Outputs:

controller_role_arn = "arn:aws:iam::XXXXXXXXXXXXX:role/dscott-aws-load-balancer-controller"
```

2. Create the namespace and the secret containing the `controller_role_arn` from the previous step and enable the operator:

```
export ROLE_ARN=<controller_role_arn_from_last_step>
make namespace-openshift
make secret-openshift
make operator-openshift
```

3. Once the operator is available, enable the controller:

```
make controller-openshift
```

4. Deploy the demo resources and take note of the ingress addresses:

```
make demo-openshift
```

Take note of the ingress ADDRESS field:

```
oc get ingress -A

NAMESPACE   NAME           CLASS   HOSTS                                       ADDRESS                                                               PORTS   AGE
app1        echo-service   alb     app.apps.dscott.sugn.p1.openshiftapps.com   k8s-app1-echoserv-98f2ab2d35-645390986.us-east-1.elb.amazonaws.com    80      8m16s
app2        echo-service   alb     app.apps.dscott.sugn.p1.openshiftapps.com   k8s-app2-echoserv-0ab7a910f3-1983779787.us-east-1.elb.amazonaws.com   80      8m15s
```

5. Access the app:

```
curl -H 'X-Forwarded-Port: 80080' -H 'X-Original-Host: test' -H 'Host: app.apps.dscott.sugn.p1.openshiftapps.com' http://k8s-app2-echoserv-0ab7a910f3-1983779787.us-east-1.elb.amazonaws.com
```