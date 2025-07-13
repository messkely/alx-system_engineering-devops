# 0x10. HTTPS SSL

This project focuses on configuring HTTPS SSL termination using HAproxy and implementing DNS subdomain configurations. The project demonstrates how to secure web traffic and manage DNS records for load balancing.

## Learning Objectives

By the end of this project, you should be able to explain:
- What HTTPS SSL 2 main roles are
- What is the purpose of encrypting traffic
- What SSL termination means
- How to configure HAproxy for SSL termination
- How to manage DNS records and subdomains

## Requirements

### General
- Allowed editors: `vi`, `vim`, `emacs`
- All files interpreted on Ubuntu 16.04 LTS
- All files should end with a new line
- All Bash script files must be executable
- Bash scripts must pass Shellcheck (version 0.3.7) without errors
- First line of all Bash scripts: `#!/usr/bin/env bash`
- Second line of all Bash scripts: comment explaining the script's purpose

### Infrastructure
- **Load Balancer**: 751420-lb-01
- **Web Servers**: 751420-web-01, 751420-web-02
- **Operating System**: Ubuntu 16.04 LTS
- **HAproxy Version**: 1.5 or higher (required for SSL termination)

## Project Structure

```
0x10-https_ssl/
├── README.md
├── 0-world_wide_web
└── 1-haproxy_ssl_termination
```

## Tasks

### 0. World Wide Web (Mandatory)

**File**: `0-world_wide_web`

Configure DNS subdomains and create a Bash script to audit subdomain information.

#### DNS Configuration Required:
- `www` → points to lb-01 IP
- `lb-01` → points to lb-01 IP  
- `web-01` → points to web-01 IP
- `web-02` → points to web-02 IP

#### Script Requirements:
- Accept 2 arguments: `domain` (mandatory) and `subdomain` (optional)
- Use `awk` and at least one Bash function
- Ignore shellcheck case SC2086
- Output format: `The subdomain [SUB_DOMAIN] is a [RECORD_TYPE] record and points to [DESTINATION]`

#### Usage Examples:
```bash
# Check all default subdomains
./0-world_wide_web holberton.online

# Check specific subdomain
./0-world_wide_web holberton.online web-02
```

#### Expected Output:
```
The subdomain www is a A record and points to 54.210.47.110
The subdomain lb-01 is a A record and points to 54.210.47.110
The subdomain web-01 is a A record and points to 34.198.248.145
The subdomain web-02 is a A record and points to 54.89.38.100
```

### 1. HAproxy SSL Termination (Mandatory)

**File**: `1-haproxy_ssl_termination`

Configure HAproxy for SSL termination to handle encrypted HTTPS traffic.

#### Requirements:
- HAproxy listens on port TCP 443
- HAproxy accepts SSL traffic
- HAproxy serves encrypted traffic returning `/` of web server
- Root domain query must return page containing "ALX"
- Use HAproxy 1.5 or higher

#### Configuration Features:
- **SSL Termination**: HAproxy handles encryption/decryption
- **Load Balancing**: Round-robin between web servers
- **Health Checks**: Monitors backend server status
- **HTTP to HTTPS Redirect**: Automatic redirect for security
- **Security Headers**: Adds X-Forwarded-Proto header

## Implementation Steps

### Step 1: DNS Configuration
1. Configure your domain registrar/DNS provider
2. Add A records for all required subdomains
3. Point them to respective server IPs

### Step 2: SSL Certificate Generation
```bash
# Install certbot
sudo apt-get update
sudo apt-get install certbot

# Generate SSL certificate
sudo certbot certonly --standalone -d www.yourdomain.com

# Create combined certificate for HAproxy
sudo cat /etc/letsencrypt/live/www.yourdomain.com/fullchain.pem \
    /etc/letsencrypt/live/www.yourdomain.com/privkey.pem \
    > /etc/ssl/certs/www.yourdomain.com.pem
```

### Step 3: HAproxy Configuration
```bash
# Install HAproxy 1.5+
sudo apt-get install haproxy

# Apply configuration
sudo cp 1-haproxy_ssl_termination /etc/haproxy/haproxy.cfg

# Restart HAproxy
sudo service haproxy restart
```

### Step 4: Web Server Configuration
Ensure your web servers serve content containing "ALX" at the root path.

## Testing

### Test DNS Configuration:
```bash
# Test subdomain script
./0-world_wide_web yourdomain.com

# Verify DNS records
dig www.yourdomain.com
dig lb-01.yourdomain.com
```

### Test SSL Termination:
```bash
# Test HTTPS access
curl -sI https://www.yourdomain.com

# Verify content contains ALX
curl https://www.yourdomain.com

# Test HTTP redirect
curl -sI http://www.yourdomain.com
```

## Security Considerations

- **SSL/TLS Encryption**: All traffic between clients and load balancer is encrypted
- **Certificate Management**: Regular certificate renewal required
- **HTTP Security Headers**: Implemented for enhanced security
- **Backend Communication**: Internal traffic between HAproxy and web servers uses HTTP

## Troubleshooting

### Common Issues:
1. **Certificate errors**: Ensure certificate path is correct in HAproxy config
2. **Permission issues**: Check file permissions for certificate files
3. **Port conflicts**: Ensure no other services are using ports 80/443
4. **DNS propagation**: Allow time for DNS changes to propagate globally

### Useful Commands:
```bash
# Check HAproxy configuration
sudo haproxy -c -f /etc/haproxy/haproxy.cfg

# View HAproxy logs
sudo tail -f /var/log/haproxy.log

# Check certificate expiration
sudo certbot certificates

# Test SSL configuration
openssl s_client -connect www.yourdomain.com:443
```

## Repository Information

- **GitHub Repository**: `alx-system_engineering-devops`
- **Directory**: `0x10-https_ssl`
- **Files**: 
  - `0-world_wide_web`
  - `1-haproxy_ssl_termination`
  - `README.md`

## Author

This project is part of the ALX System Engineering & DevOps curriculum, focusing on HTTPS SSL implementation and DNS management.

