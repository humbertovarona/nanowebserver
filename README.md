
# Multi-Site Docker with Nginx and PHP-FPM (nanowebserver)

This repository provides a Docker setup that serves multiple websites using Nginx and PHP-FPM. The setup is configured to work in a local network, allowing access to different websites hosted within the same Docker container.

## Version

![](https://img.shields.io/badge/Version%3A-1.0-success)

## Release date

![](https://img.shields.io/badge/Release%20date-Aug%2C%2023%2C%202024-9cf)

## DOI

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8152683.svg)](https://doi.org/10.5281/zenodo.13550841)

## License

![](https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge)

This project is licensed under the MIT License. Feel free to use and modify the code as per the terms of the license.

### IMPORTANT NOTE

This Docker was developed by specialists at the Centro de **Estudos e Ensaios em Risco e Modelagem Ambiental (CEERMA)** as part of the project identified under **Process No.: APQ-0235-1.08/23**, funded by **FACEPE/APAC**. This Docker was designed to support the **Núcleo de Oceanografia Operacional do Estado de Pernambuco (NOPE) project**.

It is available for free use by any individual or institution in scientific research, such as scientific articles, technical reports, books, and other scientific documents. It is important to note that proper citation of this Docker is required in the references of any scientific research in which it is used. Additionally, acknowledgments in such scientific articles, technical reports, books, and other scientific documents must explicitly include an acknowledgment to **CEERMA** as an institution.

For any commercial use of this Docker, it is necessary to contact the coordinator and/or vice-coordinator of the **NOPE** project and **CEERMA** beforehand to establish the corresponding terms and conditions of use.

## Cite as

Humberto L. Varona, Silena Herold-Garcia. (2024). Multi-Site Docker with Nginx and PHP-FPM (nanowebserver). (1.0). Zenodo. https://doi.org/10.5281/zenodo.13550841

## Project Structure

The project is organized as follows:

```
work_directory/
├── configs/
│   ├── nginx/
│   │   ├── nginx.conf                  # Main Nginx configuration file
│   │   ├── sites/                      # Virtual host configurations
│   │   │   ├── site1.conf              # Configuration for site1
│   │   │   └── site2.conf              # Configuration for site2
│   │   └── hosts                       # Hosts file containing domain mappings
│   └── php/
│       └── php-fpm.conf                # PHP-FPM configuration file
├── websites/
│   ├── site1/                          # Files for site1
│   │   ├── index.php
│   │   ├── styles.css
│   │   └── script.js
│   └── site2/                          # Files for site2
│       ├── index.php
│       ├── styles.css
│       └── script.js
└── Dockerfile                          # Dockerfile for building the image
```

## Prerequisites

- Docker and Docker Compose installed on your system.
- A local network with a fixed IP for the machine running Docker.

## Setup Instructions

1. Clone this repository to your local machine.
2. Navigate to the `work_directory` where the `Dockerfile` is located.

## Accessing the Websites

The websites are accessible through the network using the domain names configured in the hosts file. Ensure that your local machine and other machines in the network have their hosts files configured correctly.

## Editing the Hosts File

### Linux

1. Open a terminal and edit the `/etc/hosts` file using superuser privileges:

   ```bash
   sudo nano /etc/hosts
   ```

2. Add the following lines to map the domain names to the Docker host's IP address:

   ```plaintext
   192.168.1.100 site1.local
   192.168.1.100 site2.local
   ```

3. Save and exit the editor.

### MacOS

1. Open the Terminal and run:

   ```bash
   sudo nano /etc/hosts
   ```

2. Add the following lines:

   ```plaintext
   192.168.1.100 site1.local
   192.168.1.100 site2.local
   ```

3. Save the file and exit the editor.

## Running the Docker Container

To build and run the Docker container, execute the following commands:

```bash
docker build -t nanowebserver .
```

```bash
docker run -d --name nwsite -p 8083:8083 \
-v $(pwd)/configs/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
-v $(pwd)/configs/nginx/sites/:/etc/nginx/sites-available/:ro \
-v $(pwd)/websites/site1:/var/www/html/site1 \
-v $(pwd)/websites/site2:/var/www/html/site2 \
-v $(pwd)/configs/nginx/hosts:/etc/hosts:ro \
nanowebserver
```

## Verifying the Setup

1. Ping the domain names from another machine in the network to ensure they resolve correctly:

   ```bash
   ping site1.local
   ```

2. Open a browser and access the websites:

   - `http://site1.local:8083`
   - `http://site2.local:8083`

If everything is configured correctly, you should see the websites being served by the Docker container.
