

## Prerequisites

### Installing Docker

<details>
<summary>mac OS</summary>


1. **Manual Installation:**
    - Download Docker Desktop from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
    - Install and launch Docker Desktop
    - Ensure Docker is running (you should see the Docker icon in your menu bar)
2. Or ** Using Homebrew:**
   ```bash
   brew install --cask docker
   ```
   Then launch Docker Desktop from Applications.
</details>

<details>
<summary>Windows</summary>

1. Download Docker Desktop from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Install and launch Docker Desktop
3. Ensure WSL 2 is enabled if prompted
</details>

<details>
<summary>Linux (Ubuntu/Debian)</summary>


```bash
# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group (optional, to avoid sudo)
sudo usermod -aG docker $USER
```

</details>

## 🏗️ Setting Up the Project

Follow these steps to get the project up and running:

### 1. Clone the repository

```bash
git clone https://github.com/jayasanka-sack/etl-group-3
cd openmrs-to-omop
```

---

### 2. Build the Required Images

Run the following command to build the `omop-etl-core` image:

```bash
docker compose --profile manual build
```

---

### 3. Start the services

```bash
docker compose up
```

### 4. **Clone the OpenMRS DB**  

```bash
docker compose run --rm core clone-openmrs-db
```
This command will clone the OpenMRS database into a DB called `openmrs` running on port 3307.

## Development

### **Creating SQL Models**

For information on how to create SQL models, please refer to the [SQLMesh Models Overview documentation](https://sqlmesh.readthedocs.io/en/stable/concepts/models/overview/).

### **RUN SQL Mesh**  
   ```bash
   docker compose run --rm core apply-sqlmesh-plan
   ```
   Rerun this after making changes to model files.

   After running this command, it will create views under a database called `omop_db` which is running on port 3307.

