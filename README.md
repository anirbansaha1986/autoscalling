# INTRODUCTION

This is my project to learn launch templates and auto scaling groups.  I've
spent a lot of time trying to build the entire infrastructure from the ground
up, to better learn and understand terraform itself.

# NEXT STEPS

The following are big and long term goals.

* continue working through this to thoroughly tweak the auto scaling
* refactor the VPC/network stuff into one module (this has been done many times
before, I'm aware)
* refactor the launch template to a module.
* refactor the autoscaling group to a module, following the original request
* use the VPC module to create a VPC;
* use the ASG module to create a dual master ASG for Kubernetes master nodes,
sing the VPC
* use the ASG module to create an ASG for Kubernetes worker nodes
* use the ASG module to create an ASG for etcd nodes
* provision the nodes using kubespray with nginx ingress, the dashboard, AWS
provider, and helm
* I'm really interested in running the cluster across availability zones, so I
need to spend some more time researching persistent volumes and pod affinity.
* Throw all of this away and replace with EKS; after all, this costs a fortune
to operate, and without some specific use cases for operating your own cluster,
keeping pace with kubespray is daunting if you have a competent ops team
* I'm really interested in GraphQL running on Kafka for server push, with socket
io in the front end.  I hope to restart a blog on this stack, with vuejs, and
at least document this.

