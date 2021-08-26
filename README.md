# Photo Gallery from a Directory in server via Node js with NFS-server on GKE - ReadWriteMany(RWX)
 
## Create GKE cluster and Persistent Disk in Google Compute Engine

To create these things run the createCluster-PD.sh shell file

```
sh createCluster-PD.sh
```

Now your cluster and PD is ready for opration, you can create the nfs-server. 

## Create NFS Server in GKE

Now the disk is created, let’s create the NFS server.

```
kubectl apply -f 001-nfs-server.yaml
```

## Create NFS Service

The compute disk and nfs-server is ready, let's create nfs-service

```
kubectl apply -f 002-nfs-server-service.yaml
```

Also check the service is created perfectly or not.

```
kubectl get svc nfs-server
```

## Create Persistent Volume and Persistent Volume Claim

#### Note : Note down the *clusterIP* from the nfs-service as it will be required for the next part.

Now we create a persistent volume and a persistent volume claim in kubernetes.

```
kubectl apply -f 003-pv-pvc.yaml
```

#### Note : Notice here that storage is 10Gi on both PV and PVC. It’s 10Gi on PV because the Compute Engine persistent disk we created was of the size 10Gi.You can have any storage value for PVC as long as you don’t exceed the storage value defined in PV.

## Run nodeGallaryApp

Now go to this directory */nodeGallaryApp/GKE* then run the app with this command

```
sh gCloudDeploymentNodeGallary.sh
```

Now you will get the port after running this shell file completely, then launch that on browser you will get photo gallary.


Thank you... :)