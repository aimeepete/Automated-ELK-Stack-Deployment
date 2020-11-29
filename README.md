# **Automated ELK Stack Deployment**

- The files in this repository were used to configure the network depicted below.

  ![Microsoft Azure Network Diagram](https://github.com/aimeepete/Project-1/blob/main/Diagrams/Microsoft%20Azure%20Network%20Diagram.png)

- These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.

  [pentest.yml](Ansible/pentest.yml)

  [elk-playbook.yml](Ansible/elk-playbook.yml)

  [filebeat-playbook.yml](Ansible/filebeat-playbook.yml)

  [metricbeat-playbook.yml](Ansible/metricbeat-playbook.yml)

- This document contains the following details:
    - Description of the Topology
    - Access Policies
    - ELK Configuration
        - Beats in Use
        - Machines Being Monitored
    - How to Use the Ansible Build


### Description of the Topology

- The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn
  Vulnerable Web Application.

- Load balancing ensures that the application will be highly available, in addition to restricting access
  to the network.

  - **What aspect of security do load balancers protect?**

      Load Balancers monitor traffic to maintain stability between servers, protecting the availability of resources.

  - **What is the advantage of a jump box?**

      Accessing other machines that are not exposed to the public internet securely. Utilizing it to jump from machine to machine to conduct administrative tasks.

- Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network
  and system logs.

  - **What does Filebeat watch for?**

      Log data

  - **What does Metricbeat record?**

      Metric data

- The configuration details of each machine may be found below.

| Name                 | Function | IP Address                                | Operating System |
|----------------------|----------|-------------------------------------------|------------------|
| Jump-Box-Provisioner | Gateway  | Public 40.85.155.70<br>Private 10.0.0.7   | Linux            |
| Web-1                | Server   | Private 10.0.0.9                          | Linux            |
| Web-2                | Server   | Private 10.0.0.8                          | Linux            |
| Elk                  | Server   | Public 52.148.128.202<br>Private 10.1.0.4 | Linux            |

### Access Policies

- The machines on the internal network are not exposed to the public Internet. 

- Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine
  is only allowed from the Workstation's Personal IP Address.

- Machines within the network can only be accessed by Jump-Box-Provisioner using a docker container.

- **Which machine did you allow to access your ELK VM? What was its IP address?**

    - Jump-Box-Provisioner 10.0.0.7

- A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IP Addresses              |
|----------------------|---------------------|-----------------------------------|
| Jump-Box-Provisioner | Yes                 | Workstation's Personal IP Address |
| Web-1                | No                  | 10.0.0.7                          |
| Web-2                | No                  | 10.0.0.7                          |
| Elk                  | No                  | 10.0.0.7                          |

### Elk Configuration

- Ansible was used to automate the configuration of the ELK machine. No configuration was performed
  manually which is advantageous because provisions can be applied to multiple servers within a few minutes.

- The playbook implements the following tasks:

    - Install Docker.io and Module
    - Install python3-pip3
    - Increase virtual memory
    - Use more memory
    - download and launch a docker web container

- The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

  ![docker ps](https://github.com/aimeepete/Project-1/blob/main/Images/docker%20ps.png)

### Target Machines & Beats

- This ELK server is configured to monitor the following machines:

    - Web-1 10.0.0.9

    - Web-2 10.0.0.8 

- We have installed the following Beats on these machines:

    - Filebeat

    - Metricbeat

- These Beats allow us to collect the following information from each machine:

    - Filebeat collects log events. For example, System logs that track sudo commands, SSH logins, New users and groups, etc.

    - Metricbeat fetches metrics. For example, Docker containers will show metrics on the Number of Containers, CPU and Memory usage, etc.

### Using the Playbook

- To use the playbook, you will need to have an Ansible control node already configured. Assuming
  you have such a control node provisioned: 

    - SSH into the control node and follow the steps below:

      - Copy the **filebeat-config.yml** and **metricbeat-config.yml** files to `/etc/ansible/files`
      - Update the **filebeat-config.yml** and **metricbeat-config.yml** with **Elk server private IP**
      - Run the playbooks. To check that the installation worked, navigate to,    
      
      ![Beats success](https://github.com/aimeepete/Project-1/blob/main/Images/Filebeat%20success.png) 

- Answer the following questions to fill in the blanks:

    - **Which file is the playbook? Where do you copy it?**

        filebeat-playbook.yml and metricbeat-playbook.yml copy to `/etc/ansible/roles/`.

    - **Which file do you update to make Ansible run the playbook on a specific machine?** 

        `/etc/ansible/hosts`

    - **How do I specify which machine to install the ELK server on versus which to install Filebeat on?**

        `nano /etc/ansible/hosts`

        [webservers]

        10.0.0.9 ansible_python_interpreter=/usr/bin/python3

        10.0.0.8 ansible_python_interpreter=/usr/bin/python3

        [Elk]

        10.1.0.4 ansible_python_interpreter=/usr/bin/python3

  - Which URL do you navigate to in order to check that the ELK server is running?

      ![http://52.148.128.202:5601/app/kibana#/home](https://github.com/aimeepete/Project-1/blob/main/Images/Elk%20server%20running.png)

  - As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.

      ## Filebeat

      - `ssh username@jump_box_public_IP_address`
      - Locate container id `sudo docker container list -a`

        **558***********

      - `sudo docker start 558`

        **using first 3 characters from container id will work**

      - `sudo docker attach 558`

        **you should see root@full container id:~#**

      - http://**Elk server public IP address**:5601/app/kibana#/home/tutorial/systemLogs
      - Select **DEB** under **Gettings Started** 
      - Run commands, 

        - `curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/  filebeat-7.6.1-amd64.deb`
        
        - `dpkg -i filebeat-7.6.1-amd64.deb`

      - `nano /etc/filebeat/filebeat.yml`

        **Lines #1106 and #1806 replace the IP address with Elk server private IP**

        [configurations](Ansible/filebeat-config.yml)

      - `cp filebeat.yml /etc/ansible/files/filebeat-config.yml` 
      - [`nano /etc/ansible/roles/filebeat-playbook.yml`](Ansible/filebeat-playbook.yml)
      - Run commands,
        - `filebeat modules enable system`
        - `filebeat setup`
        - `service filebeat start`
      - Run playbook,
      
       `ansible-playbook /etc/ansible/roles/filebeat-playbook.yml`

      ## Metricbeat

      - http://**Elk server public IP address**:5601/app/kibana#/home/tutorial/dockerMetrics
      - Select **DEB** under **Gettings Started** 
      - Run Commamnds,

        - `curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb`
       
        - `dpkg -i metricbeat-7.6.1-amd64.deb`

      - `nano /etc/metricbeat/metricbeat.yml`

        [configurations](https://github.com/aimeepete/Project-1/blob/main/Ansible/metricbeat-config.yml)

      - `cp metricbeat.yml /etc/ansible/files/metricbeat-config.yml` 
      - [`nano /etc/ansible/roles/metricbeat-playbook.yml`](Ansible/metricbeat-playbook.yml)
      - Run Commands,
        - `metricbeat modules enable docker`
        - `metricbeat setup`
        - `service metricbeat start`
      - Run playbook,
      
       `ansible-playbook /etc/ansible/roles/metricbeat-playbook.yml`



- ### Resources

    2020

    FILEBEAT
    Lightweight shipper for logs

    https://www.elastic.co/beats/filebeat

    METRICBEAT
    Lightweight shipper for metrics

    https://www.elastic.co/beats/metricbeat

    Elk server Kibana
    http://52.148.128.202:5601/app/kibana#/home