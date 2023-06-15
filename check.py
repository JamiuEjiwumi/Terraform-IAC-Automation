import json

numberOfResourcesExpected = 40
minAcceptable = 20
validationResource = None

Allresources = ['kubernetes_service.ingress', 'digitalocean_kubernetes_cluster.lafia-k8s', 'digitalocean_record.ant-media', 'digitalocean_record.fhir-server', 
             'digitalocean_record.keycloak', 'digitalocean_record.lafia-backend', 'digitalocean_record.lafia-cms', 'digitalocean_record.lafia-dhis2', 
             'digitalocean_record.openhim-console', 'digitalocean_record.suresalama-backend', 'digitalocean_record.suresalama-cms', 'helm_release.cert-manager', 
             'helm_release.ingress-nginx', 'kubernetes_deployment.fhir', 'kubernetes_deployment.lafia-backend', 'kubernetes_deployment.lafia-cms', 
             'kubernetes_deployment.media', 'kubernetes_deployment.suresalama-backend', 'kubernetes_deployment.suresalama-cms', 'kubernetes_ingress_v1.ant-media', 
             'kubernetes_ingress_v1.fhir-server', 'kubernetes_ingress_v1.keycloak', 'kubernetes_ingress_v1.lafia-backend', 'kubernetes_ingress_v1.lafia-cms', 
             'kubernetes_ingress_v1.lafia-dhis2', 'kubernetes_ingress_v1.openhim-console', 'kubernetes_ingress_v1.suresalama-backend', 
             'kubernetes_ingress_v1.suresalama-cms', 'kubernetes_namespace.keda', 'kubernetes_namespace.production', 'kubernetes_namespace.staging', 
             'kubernetes_secret.lafia_backend_secret', 'kubernetes_service.fhir_service', 'kubernetes_service.lafia-cms', 'kubernetes_service.lafia_service', 
             'kubernetes_service.media_service', 'kubernetes_service.suresalama-backend', 'kubernetes_service.suresalama-cms', 'null_resource.apply_kubernetes_manifests', 
             'null_resource.installCRDs']


class Check:
    def __init__(self, tfstate="terraform.tfstate") -> None:
        try:
            with open(tfstate, 'r') as s:
                self.tfstate = json.loads(s.read())
                self.resources = self.tfstate["resources"]
                self.resources_names = [f"{resource['type']}.{resource['name']}" for resource in self.resources]
                self.allresources = Allresources
        except:
            self.tfstate = None

        self.missing = [item for item in self.allresources if item not in self.resources_names]

    def wasItSucessful(self):
        print("Doing Pre-Checks....")
        print("Expected Resource:", numberOfResourcesExpected)
        print("Created:", len(self.resources_names))  # use self.resources_names instead of self.resources
        print("Missing:", self.missing)
    

        if self.tfstate == None:
            return -1
    
        '''
        0: failed from the very beginging; destroy and restart
        1: partial sucess, consider as sucessful but should be refreshed (run apply again)
        2: everything deplpoyed successfully; good to go.
        '''
 
        if len(self.resources) < minAcceptable:
            return 0
        
        # if validationResource in self.resources_names:
        #     try:
        #         r = self.resources[self.resources_names.index(validationResource)]
        #         id = r["instances"][0]["attributes"]["id"] #has an id if completely deployed
        #         if id is not None:
        #             return 2
        #     except:
        #         return 1


   
        if len(self.missing) > 0:
            if len(self.missing) == 1 and self.missing[0]=='kubernetes_ingress_v1.keycloak':
                return 2
            return 1
        
        if len(self.missing) == 0:
            return 2
        
        return 0
            
            
# test = Check(tfstate="teststates.states")
# print("code:", test.wasItSucessful(), print(test.missing))





        