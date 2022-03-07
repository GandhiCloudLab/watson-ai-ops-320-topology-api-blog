# Enabling Topology Manager API

This document explains about how to enable and use Topology Manager API service in IBM Cloud Pak for Watson AIOps.

## 1. Enabling Topology Manager API Route

1. Open the web console of the OCP Cluster where WAIOps AIMgr is installed.

2. Open the ASM Operator by doing the following.

- Choose the `Installed Operators` mneu
- Choose the project `cp4waiops`
- Choose `IBM Netcool Agile Service Manager` operator

<img src="images/01-installed-operator.png">

3. Choose the Yaml tab and the yaml would be like this.

<img src="images/02-asm-config.png">

As seen in the image, need to add the below values at the license attribute level. ( `metadata`  > `annotations`  >  `alm-examples`  >  `spec`  > `helmValuesASM`  )

```
  "helmValuesASM": {
      "global.enableAllRoutes": true"
  },
```

4. Wait for 2 minutes, the routes will start getting created.

## 2. Retrieve Topology Manager API access details

A shell script [files/00-print-topology-url-usr-pwd.sh](./files/00-print-topology-url-usr-pwd.sh) is available to print the url and access details of the Topology API.

#### 1. Update NAMESPACE property

In the above script file, update the below property to point to WAIOps AIMgr installed namespace

```
NAMESPACE=cp4waiops
```

#### 2. Login into OCP Cluster

Login into the OCP Cluster where WAIOps AIMgr is installed 
```
oc login ....
```

#### 3. Print the Topology Manager API and access details

Run the below script

```
sh files/00-print-topology-url-usr-pwd.sh
```

As a result, Topology API url and access details will be printed like the below.


```
================================================================
TOPO_API_URL=https://aiops-topology-topology-cp4waiops.aaaa.cloud/1.0/topology
TOPO_API_URL_SWAGGER=https://aiops-topology-topology-cp4waiops.aaaa.cloud/1.0/topology/swagger
TOPO_USER=aiops-topology-cp4waiops-user
TOPO_PWD=aaaaaaaaaaaaaaaa
TOPO_TENENT_ID=cfd95b7e-3bc7-4006-a4a8-a73a79c71255
================================================================
```

## 3. Swagger UI

The Swagger UI url will be printed as part of the above script. The `TOPO_API_URL_SWAGGER` url to be used to open the Swagger UI.

The above printed User, Password and TenantId fields would be used in Swagger UI.

Swagger UI allows anyone to visualize and interact with the API’s resources. 

<img src="images/03-swagger.png">

## Note :

1. The article is based on the the following.
- RedHat OpenShift 4.8 on IBM Cloud (ROKS)
- IBM Cloud Pak for Watson AIOps 3.2.0


2. API service is not officially supported for production.