<center><img src="https://otland.net/proxy.php?image=https%3A%2F%2Fi.imgur.com%2FbfCWw1f.png&hash=dfccf5ee88e4883e5f5c78dda0af29d3"></center>

## Requirements
- Ubuntu 18 +
- a VPS (Suggested provider: https://OVH.us)

### Recommended VPS
- 4 vCore
- 8 GB
- 160 GB SSD NVMe
- 1 Gbps unmetered

### How-to setup
Run those commands on Linux Terminal (step by step)
- Enter the root: ``sudo -i``
- Create the main folder: ``cd /var && mkdir yurots && chmod 777 -R /var/yurots``
- Clone the repository: ``git clone https://github.com/rodolfoaugusto/yurOTS-server.git server``
- Install the libraries and tools: ``apt-get install screen zip git cmake build-essential liblua5.2-dev libgmp3-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libpugixml-dev libcrypto++-dev libboost-filesystem-dev -y``
- Enter the folder and start compiling: ``cd server && mkdir build && cd build && cmake .. && make``
- Move the generated file to main folder: ``mv /var/yurots/server/build/yurOTS /var/yurots/server && cd ..``
- Give rights to the generated file: ``chmod +x yurOTS``
- Start a screen (server keep running without shutdown when you close the terminal): ``screen -A -S server``
- Start the server: ``./yurOTS``
- Close the current screen: ``control +A +D``
- Enter the screen ``screen -x server`` and have fun!

### Linux Keyboards Commands
- Close/Stop current application: ``control + c``
- Quit without close the current screen: ``control + A + D``


### Discord: rodi#9161
