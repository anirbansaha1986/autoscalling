# BACKSTORY

I sat through the worst technical screen I've had in my professional career.  I
did not represent myself as either an AWS nor a terraform expert; rather, I was
clear that it had been six years since I had worked with AWS, I worked with
Azure, and that in my role as an application architect, I had configured
servers with Terraform some years ago, using guidelines (and restrictions)
inherent from a company whose IT policies are ... five years out.  I provisioned
the kubernetes cluster using kubespray, of course, it's natural if you're using
Terraform.  Parenthetically, when I was first evaluating orchestration
platforms, I deployed a two-node cluster with kubeadm with colocated etcd.
The first time you do `kubectl get pod` and see something you've created...

I had an in-person, in which we discussed many things germaine to my day-in,
day-out function, such as Jenkins configuration, configuration backup,
Hashicorp consul and vault, my bonafide use of Terraform, Kubernetes
architecture (as far as nodes, document store), as well as Kubernetes
application infrastructure, services, clusterip vs nodeport services,
daemonsets, how data persistent works when configured with a cloud provider
(and when not...) and so forth.  I was requested to come back in to demonstrate
my technical skills.

The first sign something had gone wrong was that when I got there, I hadn't
brought anything.  "You didn't bring a laptop?  We'll have to reschedule..."
Fortunately, I had a laptop in my car.  The second bird of ill-omen was that I
would need to tether my laptop (i.e., to my phone), that I could have internet
access.  I'm not exactly sure what bird that would be in the analogy, like
Rhyme of the Ancient Mariner, but with a dodo...?

My assignment, therefore, was to create an aws autoscaling group using terraform
12 and to utilize dynamic blocks to support `mixed_instance_policy` along with
`launch_template` or `launch_configuration`.  What could go wrong?

I had an hour to do this, as part 1, with part 2 being to write a python script
to filter ec2 instances by tags using boto3, and best practices with pyenv,
e.g., to produce a setup.py.  _If I did nothing but use terraform day-in day-out
in AWS, I would've been hard-pressed to make a reasonable stab at the first_.
I wound up finding a really nice github which already solved the problem
here: https://github.com/cloudposse/terraform-aws-ec2-autoscale-group.  I wound
up focusing on the python task, from which I am about four years removed,
the vagaries of setup.py lost to the mists of time.  Not, as it were, forever
unexpurgatably removed as the hiring manager apparently went on to presume.

If I were tasked with this professionally, given what I have explained, it would
be a solid few days' work, _the first time_.  I've spent a day and a half of
personal time to get here, and mind, since it's my dime, I'm going through
the complete exercize.

This is a first pass at an autoscaling group with mixed instance policy.

# INTRODUCTION

I have spent a couple days relearning AWS, in particular, the relatively new
launch template feature, and the relatively new autoscaling feature.  I've
gotten a little lost in the weeds with VPC.  I've done things this way because
_it is my personal time_, and this is, for me, far and away the best way to
learn something to heart.  I've spent a little more time working through the
dynamic blocks of terraform 12 (and obviously, not using inline resource id
references...)

# NEXT STEPS

What I plan to do next:

* continue working through this to thoroughly tweak the auto scaling
* refactor the VPC/network stuff into one module (this has been done many times
before, I'm aware; again, _my time, my dime_.
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

