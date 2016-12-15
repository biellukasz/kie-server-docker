This repository contains Docker images for products related to Drools and jBPM projects.

These images are optimized for usage on OpenShift.

Currently implemented to use latest snapshot version.


####kie-server-base folder:

Contains Docker image of Kie server. Implemented to use PostgreSQL database deployed on OpenShift.
Can be configured to use PostgreSQL from different source, in that case define appropriate environment variables. For more info see Dockerfile.

####workbench folder:

Contains Docker image of jBPM Workbench.

####kie-server-router folder:

Contains Docker image of Kie Server router.
