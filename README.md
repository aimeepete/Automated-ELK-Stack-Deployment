# **Automated ELK Stack Deployment**

- The files in this repository were used to configure the network depicted below.

  [Microsoft Azure Network Diagram](https://github.com/aimeepete/Project-1/blob/main/Diagrams/Microsoft%20Azure%20Network%20Diagram.png)

- These files have been tested and used to generate a live ELK deployment on Azure. They can be used to
  either recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.

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

      Accessing other machines that are not exposed to the public internet securly. Utilizing it to jump from machine to machine in order to conduct admistrative tasks.

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

- Ansible was used to automate configuration of the ELK machine. No configuration was performed manually
  which is advantageous because provisions can be applied to multiple servers within a few minutes.

- The playbook implements the following tasks:

    - Install Docker.io and Module
    - Install python3-pip3
    - Increase virtual memory
    - Use more memory
    - download and launch a docker web container

- The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

  [docker ps](Images/docker_ps_output.png)

### Target Machines & Beats

- This ELK server is configured to monitor the following machines:

    - Web-1 10.0.0.9

    - Web-2 10.0.0.8 

- We have installed the following Beats on these machines:

    - Filebeat

    - Metricbeat

- These Beats allow us to collect the following information from each machine:

    - Filebeat collects log events. For example, System logs which tracks sudo commands, SSH logins, New users and groups, etc.

    - Metricbeat fetches metrics. For example, Docker conatiners which will show metrics on Number of Containers, CPU and Memory usage, etc.

### Using the Playbook

- In order to use the playbook, you will need to have an Ansible control node already configured. Assuming
  you have such a control node provisioned: 

    - SSH into the control node and follow the steps below:

      - Copy the [filebeat-config.yml] and [metricbeat-config.yml] files to /etc/ansible/files
      - Update the filebeat-config.yml and metricbeat-config.yml with Elk servers private IP under 
        [output.elasticsearch and setup.kibana](Images/docker_ps_output.png)
      - Run the playbook, and navigate to http://**Elk public IP**:5601/app/kibana#/home to check that the
      installation worked as expected.

- Answer the following questions to fill in the blanks:

    - **Which file is the playbook? Where do you copy it?**

        [filebeat-playbook.yml] and [metricbeat-playbook.yml] copy to /etc/ansible/files.

    - **Which file do you update to make Ansible run the playbook on a specific machine?** 

        /etc/ansible/hosts

    - **How do I specify which machine to install the ELK server on versus which to install Filebeat on?**

        [webservers]

        10.0.0.9 ansible_python_interpreter=/usr/bin/python3

        10.0.0.8 ansible_python_interpreter=/usr/bin/python3

        [Elk]

        10.1.0.4 ansible_python_interpreter=/usr/bin/python3

  - Which URL do you navigate to in order to check that the ELK server is running?

      http://**Elk public IP**:5601/app/kibana#/home

  - As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.

      - create or update playbook `nano /etc/ansible/files/playbookname.yml`

      - run playbook `ansible-playbook /etc/ansible/files/playbookname.yml`
