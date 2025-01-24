import os
import sys
import subprocess

# Define your customizable variables
username = "btherien"
jupyter_port = "4410"
docker_image = "benjamintherien/dev:cu12.2.2-py3.9-jax-mpi"
working_dir = f"/home/{username}"

# Get the container name from the command line argument
if len(sys.argv) != 2:
    print("Usage: python run_docker.py <container_name>")
    sys.exit(1)

container_name = sys.argv[1]

# Environment-dependent modifications
host = os.environ.get('HOST', 'default_host')

# Example customization based on $HOST
if host == 'hightower':
    memory = "512g"
    cpus = "128"
    shm_size = "5g"
    uid = "1013"
    gid = "1013"
elif host == 'therien-ws':
    memory = "256g"
    cpus = "48"
    shm_size = "5g"
    uid = "1000"
    gid = "1000"
else:
    raise ValueError(f"Unknown host: {host}")

# Check if the container is already running
check_command = ["docker", "ps", "-q", "--filter", f"name=^{container_name}$"]
running_container = subprocess.run(check_command, capture_output=True, text=True).stdout.strip()

if running_container:
    print(f"Container \"{container_name}\" is already running. Attaching...")
    attach_command = ["docker", "exec", "-it", container_name, "bash"]
    subprocess.run(attach_command)
else:
    # Construct the Docker run command
    docker_command = [
        "docker", "run",
        "-v", "/etc/passwd:/etc/passwd:ro",
        "-v", "/etc/group:/etc/group:ro",
        # f"-v", f"/tmp/run.sh/23956:/home/{username}",
        f"-v", f"/home/{username}/.Xauthority:/home/{username}/.Xauthority",
        f"-v", f"/home/{username}/.Xauthority:/root/.Xauthority",
        "-v", "/tmp/.X11-unix:/tmp/.X11-unix",
        "--net=host",
        f"-u", f"{uid}:{gid}",
        f"-v", f"/home/{username}/.jupyter:/home/{username}/.jupyter",
        "-v", "/scr/data:/scr/data",
        "--gpus", "all",
        "--name", container_name,
        f"--memory={memory}",
        f"--cpus={cpus}",
        f"--shm-size={shm_size}",
        f"-p", f"{jupyter_port}:{jupyter_port}",
        f"-v", f"/home/{username}:/home/{username}",
        "-e", f"HOME=/home/{username}",
        "-e", f"JUPYTER_PORT={jupyter_port}",
        "-w", working_dir,
        "-v", "/mnt:/mnt",
        "-v", "/home:/home",
        "--rm", "-it",
        docker_image, "bash"
    ]
    print("[RUNNING]"," ".join(docker_command))
    # Execute the Docker run command
    subprocess.run(docker_command)