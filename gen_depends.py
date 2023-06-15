import json

# Load the terraform.tfstate file
with open('teststates.states', 'r') as f:
    tfstate = json.load(f)


# Extract the resources from the root module
resources = tfstate["resources"]
print(len(resources))

# Iterate through each resource and extract the necessary data
resource_names = []
for resource in resources:
    resource_type = resource['type']
    resource_name = resource['name']
    resource_names.append(f"{resource_type}.{resource_name}")

print(resource_names)