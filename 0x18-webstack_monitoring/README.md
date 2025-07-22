# 0x18. Webstack monitoring

This project focuses on setting up monitoring for web infrastructure using Datadog. The project includes setting up monitoring agents, creating custom monitors, and building dashboards for system metrics visualization.

## Learning Objectives

At the end of this project, you should be able to explain:
- Why monitoring is needed
- What are the 2 main areas of monitoring
- What are access logs for a web server (such as Nginx)
- What are error logs for a web server (such as Nginx)

## Requirements

### General
- Allowed editors: `vi`, `vim`, `emacs`
- All files will be interpreted on Ubuntu 16.04 LTS
- All files should end with a new line
- A `README.md` file, at the root of the folder of the project, is mandatory
- All Bash script files must be executable
- Bash scripts must pass Shellcheck (version 0.3.7) without any error
- The first line of all Bash scripts should be exactly `#!/usr/bin/env bash`
- The second line of all Bash scripts should be a comment explaining what the script does

## Server Information

- **751420-web-01**: Primary web server
- **751420-web-02**: Secondary web server  
- **751420-lb-01**: Load balancer

## Tasks

### 0. Sign up for Datadog and install datadog-agent
- Sign up for Datadog account using US website (https://app.datadoghq.com)
- Use US1 region
- Install datadog-agent on web-01
- Create application key
- Configure hostname as XX-web-01

### 1. Monitor some metrics
- Set up monitor for read requests per second
- Set up monitor for write requests per second
- Configure alerts for both monitors

### 2. Create a dashboard
- Create new dashboard with at least 4 widgets
- Monitor various system metrics
- Get dashboard ID using Datadog API

## Files

- `2-setup_datadog`: Contains the dashboard ID

## Usage

1. Follow Datadog setup instructions for agent installation
2. Configure monitors through Datadog web interface
3. Create dashboard and note the ID
4. Update configuration files as needed

## Resources

- [Datadog Documentation](https://docs.datadoghq.com/)
- [System Check Metrics](https://docs.datadoghq.com/integrations/system/)
- [Datadog API Reference](https://docs.datadoghq.com/api/)

## Author

ALX System Engineering & DevOps Program