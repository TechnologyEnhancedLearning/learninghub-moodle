# Learning Hub Moodle

Learning Hub is the NHS England learning management and delivery platform developed and maintained by the Technology Enhanced Learning team. This repository houses the code for the Moodle component of the Learning Hub application.

## Moodle

[Moodle][1] is the World's Open Source Learning Platform, widely used around the world by countless universities, schools, companies, and all manner of organisations and individuals.

Moodle is designed to allow educators, administrators and learners to create personalised learning environments with a single robust, secure and integrated system.

### Documentation

- Read our [User documentation][3]
- Discover our [developer documentation][5]
- Take a look at our [demo site][4]

### Community

[moodle.org][1] is the central hub for the Moodle Community, with spaces for educators, administrators and developers to meet and work together.

You may also be interested in:

- attending a [Moodle Moot][6]
- our regular series of [developer meetings][7]
- the [Moodle User Association][8]

### Installation and hosting

Moodle is Free, and Open Source software. You can easily [download Moodle][9] and run it on your own web server, however you may prefer to work with one of our experienced [Moodle Partners][10].

Moodle also offers hosting through both [MoodleCloud][11], and our [partner network][10].



## LearningHub Moodle CI/CD Workflow

This page contains information on the CI/CD Actions which have been created for LearningHub-Moodle.

> **&#9432;** Actions is the name that GitHub uses for pipelines.

### CI/CD Workflow
Actions have been setup to test the code for, and deploy the code to, three different environments, development, testing and production. The actions for all three environments are very similar (they all run the same tests), but deploy to different environments in Azure. 

Each environment has two actions - Test and Deploy. The Test action is triggered when a Pull Request is created for the branch relating to the environment. The Deploy action, for development and test environments, is triggered by a merge to the branch relating to the environment. For the Production environment a manual trigger has been created for the deployment.

> **&#9432;** The Test Action takes quite a long time to run, about 1.5 hrs.

#### Development environment
The development environment can be found here. 

When pull requests are created for the CI branch, the Tests Action will be triggered.

When code is merged to the CI branch, the Deployment Action will be triggered.

#### Test environment
The test environment can be found here.

When pull requests are created for the RC branch, the Tests Action will be triggered. 

When code is merged to the RC branch, the Deployment Action will be triggered.

#### Production environment
The production environment can be found here.

When pull requests are created for the main branch, the Tests Action will be triggered.

The Deployment Action for the production environment is triggered manually. When this is triggered, several parameters can be provided (if these are not provided, default values, from GitHub environment variables, will be used.

| Parameter | Description |
|-----------|-------------|
| Number of nodes in the AKS cluster | The number of machines which will form the cluster |
| Size of each node in the AKS cluster | How powerful will each of the machines in the cluster be |
| Number of replicas in the AKS cluster | How many docker containers should run in the cluster |
| Are you sure you want to proceed | Only a value of yes will allow the deployment to proceed |

The production deployment pipeline requires approval from one of the senior devs before it will run.

 

### Updating Terraform
Each of the deployment pipelines contains Terraform configuration and commands. Terraform will create and modify the infrastructure for the given environment, based on the configuration which it is given.

To update the Terraform configuration, take a look in the repository at the Terraform folder. In here you’ll find sub folders which relate to each of the 3 environments. Within those folders you’ll find several Terraform configuration files (*.tf and *.tfvars). The definition of the infrastructure which Terraform will commission can be found in the main.tf file. Make changes here, or in the variables passed to this file, to modify the infrastructure which Terraform will commission. 

Once changes have been made to Terraform configuration, simply commit and push the changes. When the changes are merged to the branch for an environment, terraform will make the changes as required.

### Debugging Common Action Issues
Each of the Actions uses a Service Principal to authenticate itself with Azure. The secrets which are held for these Service Principals will expire after a period (I usually set the secrets to expire after 2 years). If the secret expires the Action will no longer be able to authenticate itself with Azure. To fix this problem, the secret must be replaced with a new one. Details on how to fix these issues can be found here.

There are several points at which the pipelines might report an error, but still continue to run. These are not a cause for concern. The two most common errors reported are:

Create the Default Namespace Secret - an error is caused here if the secret already exists.

Attach ACR to Cluster - There can sometimes be an issue with AAD propagation. This can be ignored if the command has been run manually on the command line.

### Rollback procedure
In the event of a failed deployment, which requires rollback, reverse the changes that have been made in git and go through the deployment procedure again. 

In non-production environments it is possible to simply tear down the existing infrastructure and create it again using Terraform (probably best to avoid tearing down the DB though). This should be considered as a last ditch option. 

### License
Moodle is provided freely as open source software, under version 3 of the GNU General Public License. For more information on our license see

1. https://moodle.org
2. https://moodle.com
3. https://docs.moodle.org/
4. https://sandbox.moodledemo.net/
5. https://moodledev.io
6. https://moodle.com/events/mootglobal/
7. https://moodledev.io/general/community/meetings
8. https://moodleassociation.org/
9. https://download.moodle.org
10. https://moodle.com/partners
11. https://moodle.com/cloud
12. https://moodledev.io/general/license
