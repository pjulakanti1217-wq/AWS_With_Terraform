# Common Installation Commands
# For macOS
brew install hashicorp/tap/terraform

# For Ubuntu/Debian
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Setup Commands
terraform -install-autocomplete
alias tf=terraform
terraform -version

# Common Installation Error (macOS) 
# If you encounter:
Error: No developer tools installed.

# Install Command Line Tools:
xcode-select --install


