- azure ad module contains for_each from a csv file,testing timeouts block, and azuread provider.
https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts
- Network takes a map of objects representing any amount of virtual networks and subnets, and creates the subnets and vnets
- Transit module takes the virtual network module and then creates network attachments for each in the virtual wan, as well as a dynamic route table
- Todo for transit - do a foreach loop similar to network module, so that we can add the vnet->transit route
- Quick read on some basic info : https://arsenvlad.medium.com/mapping-aws-iam-concepts-to-similar-ones-in-azure-c31ed7906abb

Basic terraform.tfvars should be passed in containing all the networks that should be created.
```
billing = {
  default_emails = [
    "redacted"
  ]
}

virtual_networks = {
  prod = {
    name     = "redacted"
    cidr     = ["redacted"]
    location = "eastus"
    subnets = {
      PrivateA = "10.100.10.0/26"
      PrivateB = "redacted"
      PublicA  = "redacted"
      PublicB  = "redacted"
    }
    tags = {
      environment = "prod"
      superman    = "nou"
    }
  }
  dev = {
    name     = "dev"
    cidr     = ["10.20.10.0/24"]
    location = "eastus"
    subnets = {
      PrivateA = "10.200.10.0/26"
      PrivateB = "redacted"
      PublicA  = "redacted"
      PublicB  = "redacted"
    }
    tags = {
      environment = "dev"
      spiderman   = "thebest"
    }
  }
}

transit_virtual_network = {
  name     = "transit"
  cidr     = ["redacted"]
  location = "eastus"
  subnets = {
    PrivateA = "10.300.10.0/26"
    PrivateB = "redacted"
    PublicA  = "redacted"
    PublicB  = "redacted"
  }
  tags = {
    environment = "prod"
  }
}
```

