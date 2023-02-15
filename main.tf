# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "FYP" {0
  name     = "FYP-resources"
  location = "East Asia"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "FYP-VN" {
  name                = "FYP-network"
  location            = azurerm_resource_group.FYP.location
  resource_group_name = azurerm_resource_group.FYP.name
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "FYP-subnet" {
  name                 = "FYP-subnet"
  resource_group_name  = azurerm_resource_group.FYP.name
  virtual_network_name = azurerm_virtual_network.FYP-VN.name
  address_prefixes     = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "FYP-sg" {
  name                = "FYP-sg"
  location            = azurerm_resource_group.FYP.location
  resource_group_name = azurerm_resource_group.FYP.name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "FYP-dev-rule" {
  name                        = "FYP-dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.FYP.name
  network_security_group_name = azurerm_network_security_group.FYP-sg.name
}

resource "azurerm_subnet_network_security_group_association" "FYP-sga" {
  subnet_id                 = azurerm_subnet.FYP-subnet.id
  network_security_group_id = azurerm_network_security_group.FYP-sg.id
}

resource "azurerm_public_ip" "FYP-ip" {
  name                = "FYP-ip"
  resource_group_name = azurerm_resource_group.FYP.name
  location            = azurerm_resource_group.FYP.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "FYP-nic" {
  name                = "FYP-nic"
  location            = azurerm_resource_group.FYP.location
  resource_group_name = azurerm_resource_group.FYP.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.FYP-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.FYP-ip.id
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_linux_virtual_machine" "FYP-VM-test" {
  name                = "FYP-VM-test"
  resource_group_name = azurerm_resource_group.FYP.name
  location            = azurerm_resource_group.FYP.location
  size                = "Standard_B2s"
  disable_password_authentication = "false"
  admin_username      = "adminuser"
  admin_password      = "!Adminuser"
  network_interface_ids = [
    azurerm_network_interface.FYP-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/FYPazurekey.pub")
  }

  custom_data = filebase64("userdata.tpl")

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}