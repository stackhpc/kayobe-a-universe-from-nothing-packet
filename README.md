# Terraform for "A Universe From Nothing" Lab

Terraform for the following configuration:

* OpenStack virtualised lab instances
* An OpenStack virtualised container registry instance
* Cinder volumes for instance storage
* Floating IPs for networking

This Terraform deployment reproduces the environment for [a universe from
nothing](https://github.com/stackhpc/a-universe-from-nothing) workshop on
OpenStack infrastructure.

## Prerequisites

* A Neutron network the instances can attach to, with a router
* Plenty of resource quota
* Terraform installed (see instructions
  [here](https://developer.hashicorp.com/terraform/install))

## Software Components

[Kayobe](https://docs.openstack.org/kayobe/latest/) enables the deployment of
containerised OpenStack to bare metal.

# Instructions for deployment

After cloning this repo, source the regular OpenStack rc file with the
necessary vars for accessing the *A Universe From Nothing* lab project.

There are various variables available for configuration. These can be seen
in `vars.tf`, and can be set in `terraform.tfvars` (see sample file
`terraform.tfvars.sample`).

Create the resources using Terraform:

    terraform init
    terraform plan
    terraform apply -auto-approve -parallelism=52

To reprovision a lab machine:

    terraform taint openstack_compute_instance_v2.lab[#]
    terraform apply -auto-approve

where `#` is the lab index which can be obtained from the web UI.

To destroy the cluster:

    terraform destroy

# Instructions for lab users

## Logging in

SSH in to your lab instance by running and entering the provided password:

    ssh lab@<lab-ip-address> -o PreferredAuthentications=password

The default password is the id of the lab instance. As such, it is recommended
that you run `passwd` immediately to change the default password.

## Nested virtualisation

Make sure that nested virtualisation is enabled on the host:

    egrep --color 'vmx|svm' /proc/cpuinfo

Look for **vmx** or **svm** coloured red in the output.

## Initial seed deployment

Ensure that the initialsation steps are complete by looking at the log:

    tail -f a-seed-from-nothing.out

When complete, it should report an elapsed time as follows:

    [INFO] 22 minutes and 3 seconds elapsed.

## Inspect the Bifrost container inside your seed VM:

    ssh stack@192.138.33.5
    docker ps
    exit

## Configuring bare metal cloud using Kayobe

Look at the steps involved in deploying Kayobe control plane:

    less a-universe-from-seed.sh

# Wrapping up

Join the discussion at `#openstack-kolla` channel on IRC.
