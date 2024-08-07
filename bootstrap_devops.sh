#!/bin/bash

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

# Function to install a tool
install_tool() {
    echo "Installing $1..."
    if [[ $1 == "iterm2" || $1 == "docker" || $1 == "visual-studio-code" || $1 == "google-cloud-sdk" ]]; then
        brew install --cask $1
    else
        brew install $1
    fi
}

# Array of available tools
tools=(
    "iterm2:iTerm2 terminal emulator"
    "zsh:Zsh shell"
    "awscli:AWS CLI"
    "kubectl:Kubernetes CLI"
    "terraform:Infrastructure as Code tool"
    "docker:Containerization platform"
    "ansible:Automation tool"
    "azure-cli:Azure CLI"
    "google-cloud-sdk:Google Cloud SDK"
    "visual-studio-code:Code editor"
    "git:Version control system"
    "htop:Interactive process viewer"
    "tmux:Terminal multiplexer"
    "wget:File retriever"
    "tree:Directory listing"
    "jq:JSON processor"
    "vim:Text editor"
)

# Function to display menu and get user choices
get_user_choices() {
    local choices=()
    local selected=()
    for i in "${!tools[@]}"; do
        selected[i]=false
    done

    while true; do
        echo "Select the tools you want to install:"
        for i in "${!tools[@]}"; do
            if [ "${selected[i]}" = true ]; then
                echo "$((i+1)). [X] ${tools[i]#*:} (${tools[i]%:*})"
            else
                echo "$((i+1)). [ ] ${tools[i]#*:} (${tools[i]%:*})"
            fi
        done
        echo "$((${#tools[@]}+1)). Done (proceed with installation)"
        echo "$((${#tools[@]}+2)). Exit (cancel installation)"

        read -p "Enter a number to select/deselect, 'a' to select all, or 'd' when done: " input

        case $input in
            ''|*[!0-9]*) 
                if [[ $input == "a" ]]; then
                    for i in "${!tools[@]}"; do
                        selected[i]=true
                    done
                elif [[ $input == "d" ]]; then
                    break
                else
                    echo "Invalid input. Please enter a number, 'a', or 'd'."
                fi
                ;;
            *)
                if (( input > 0 && input <= ${#tools[@]} )); then
                    selected[$((input-1))]=$([ "${selected[$((input-1))]}" = true ] && echo false || echo true)
                elif (( input == ${#tools[@]}+1 )); then
                    break
                elif (( input == ${#tools[@]}+2 )); then
                    echo "Installation cancelled."
                    exit 0
                else
                    echo "Invalid number. Please try again."
                fi
                ;;
        esac
        echo ""
    done

    for i in "${!selected[@]}"; do
        if [ "${selected[i]}" = true ]; then
            choices+=("${tools[i]%:*}")
        fi
    done

    echo "You've selected: ${choices[*]}"
    read -p "Proceed with installation? (y/n): " confirm
    if [[ $confirm != [Yy]* ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    for choice in "${choices[@]}"; do
        install_tool "$choice"
    done
}

# Call the function to get user choices and install tools
get_user_choices

# Special handling for Zsh and Oh My Zsh
if [[ " ${choices[*]} " == *" zsh "* ]]; then
    # Set Zsh as default shell
    chsh -s $(which zsh)

    # Install Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install zsh-syntax-highlighting plugin
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting plugin..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi

    # Install zsh-autosuggestions plugin
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions plugin..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    # Add plugins to .zshrc file
    sed -i '' 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc
fi

echo "Setup complete! Some changes may require a restart of your terminal or system to take effect."
if [[ " ${choices[*]} " == *" zsh "* ]]; then
    echo "You've installed Zsh. Please restart your terminal or run 'zsh' to start using it."
fi
if [[ " ${choices[*]} " == *" iterm2 "* ]]; then
    echo "You've installed iTerm2. Please open iTerm2 to use your new terminal emulator."
fi