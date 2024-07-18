# MacOS Development Environment Setup Scripts

This repository contains a collection of bash scripts for setting up various development environments on MacOS. These scripts automate the installation of essential tools and configurations for different development needs.

## Available Scripts

1. `bootstrap_devops.sh`: Sets up a DevOps environment with relevant tools.
2. `bootstrap_golang.sh`: Prepares the system for Golang development.
3. `bootstrap_gpg.sh`: Configures GPG for secure communications.
4. `bootstrap_terminal.sh`: Sets up a customized terminal environment.

## Prerequisites

- MacOS operating system
- Internet connection

## Usage

1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/c-j-p-nordquist/dev-env-bootstrap.git
    ```

2. Navigate to the repository directory:
    ```bash
    cd mac-terminal-bootstrap
    ```

3. Make the scripts executable:
    ```bash
    chmod +x bootstrap_*.sh
    ```

4. Run the desired script(s):
    ```bash
    ./bootstrap_devops.sh
    ./bootstrap_golang.sh
    ./bootstrap_gpg.sh
    ./bootstrap_terminal.sh
    ```

   Each script will guide you through the installation process, allowing you to select which tools to install.

## Script Details

### bootstrap_devops.sh
This script sets up a DevOps environment by installing tools like Docker, Kubernetes CLI, Terraform, AWS CLI, and more. It uses an interactive menu to let you choose which tools to install.

### bootstrap_golang.sh
This script prepares your system for Golang development. It installs Go, sets up the GOPATH, and installs common Go development tools. It also provides options for installing related tools like VS Code or GoLand.

### bootstrap_gpg.sh
This script helps you set up GPG (GNU Privacy Guard) for secure communications and signing. It guides you through the process of generating a GPG key and configuring it for use.

### bootstrap_terminal.sh
This script customizes your terminal environment. It installs and configures Zsh, Oh My Zsh, and useful plugins to enhance your command-line experience.

## Customization

Feel free to modify these scripts to suit your specific needs. You can add or remove tools from the installation lists in each script.

## Contributing

Contributions to improve these scripts or add new functionality are welcome. Please feel free to submit pull requests or open issues for any bugs or feature requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.