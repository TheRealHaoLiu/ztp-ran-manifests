# About
Simulates DU RAN profile policies for k3s clusters using hub-side templating.

# Usage
## Prerequisites

1. Hub with OCP 4.9+ and ACM 2.4+
2. `oc` CLI on your local environment

## Steps

1. Clone this repo
2. Navigate to this folder
3. Apply all policies in the `policies` folder
    ````
    oc apply -f policies
    ````
4. Apply all siteconfigs in the `siteconfigs` folder
    ````
    oc apply -f siteconfigs
    ````
5. Check the `default` namespace to ensure all policies are available


